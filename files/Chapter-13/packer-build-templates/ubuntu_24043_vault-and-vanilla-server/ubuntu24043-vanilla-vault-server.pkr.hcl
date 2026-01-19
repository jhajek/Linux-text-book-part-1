###############################################################################################################
# Packer Virtualbox-iso documentation: https://developer.hashicorp.com/packer/plugins/builders/virtualbox/iso
###############################################################################################################
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

###############################################################################################################
# Packer Init Block -- plugins needed to build Vagrant Boxes
###############################################################################################################
packer {
  required_plugins {
    virtualbox = {
      source  = "github.com/hashicorp/virtualbox"
      version = "~> 1"
    }
      vagrant = {
      version = "~> 1"
      source = "github.com/hashicorp/vagrant"
    }
  }
}

# Packer Virtualbox-iso documentation
# https://developer.hashicorp.com/packer/integrations/hashicorp/virtualbox/latest/components/builder/iso
source "virtualbox-iso" "ubuntu-vault-server" {
    boot_command = [
        "e<wait>",
        "<down><down><down>",
        "<end><bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
      ]
  boot_wait               = "5s"
  disk_size               = 35000
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "Ubuntu_64"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "${var.iso_checksum}"
  iso_urls                = ["${var.iso_url}"]
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_username            = "vagrant"
  ssh_password            = "${var.user-ssh-password}"
  ssh_timeout             = "25m"
  # https://developer.hashicorp.com/packer/integrations/hashicorp/virtualbox/latest/components/builder/iso#optional
  nic_type                = "virtio"
  chipset                 = "ich9"
  gfx_vram_size           = "16"
  gfx_controller          = "vboxvga"
  #hard_drive_interface    = "virtio"
  cpus                    = 2
  memory                  = "${var.memory_amount}"
  # Change to --nat-localhostreachable1 forced by https://github.com/hashicorp/packer/issues/12118
  vboxmanage              = [["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "ubuntu-vault-server"
  headless                = "${var.headless_build}"
}

# Packer Virtualbox-iso documentation
# https://developer.hashicorp.com/packer/integrations/hashicorp/virtualbox/latest/components/builder/iso
source "virtualbox-iso" "ubuntu-vanilla-server" {
    boot_command = [
        "e<wait>",
        "<down><down><down>",
        "<end><bs><bs><bs><bs><wait>",
        "autoinstall ds=nocloud-net\\;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/ ---<wait>",
        "<f10><wait>"
      ]
  boot_wait               = "5s"
  disk_size               = 35000
  guest_additions_path    = "VBoxGuestAdditions_{{ .Version }}.iso"
  guest_os_type           = "Ubuntu_64"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum             = "file:http://mirrors.edge.kernel.org/ubuntu-releases/24.04.3/SHA256SUMS"
  iso_urls                = ["https://mirrors.edge.kernel.org/ubuntu-releases/24.04.3/ubuntu-24.04.3-live-server-amd64.iso"]  
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_username            = "vagrant"
  ssh_password            = "${var.user-ssh-password}"
  ssh_timeout             = "25m"
  # https://developer.hashicorp.com/packer/integrations/hashicorp/virtualbox/latest/components/builder/iso#optional
  nic_type                = "virtio"
  chipset                 = "ich9"
  gfx_vram_size           = "16"
  gfx_controller          = "vboxvga"
  #hard_drive_interface    = "virtio"
  cpus                    = 2
  memory                  = "${var.memory_amount}"
  # Change to --nat-localhostreachable1 forced by https://github.com/hashicorp/packer/issues/12118
  vboxmanage              = [["modifyvm", "{{.Name}}", "--nat-localhostreachable1", "on"]]
  virtualbox_version_file = ".vbox_version"
  vm_name                 = "ubuntu-vanilla-server"
  headless                = "${var.headless_build}"
}

build {
  sources = ["source.virtualbox-iso.ubuntu-vault-server","source.virtualbox-iso.ubuntu-vanilla-server"]

  ##############################################################################
  # This shell script adds the default user "vagrant" to the sudoers group and
  # removes the password requirement to elevate to "sudo"
  ##############################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2404_vagrant.sh"
  }

  ##############################################################################
  # This shell script goes to the vault.io website and installs all the
  # pre-reqs needed to install vault software
  ##############################################################################

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2404_install-vault.sh"
    only            = ["virtualbox-iso.ubuntu-vault-server"]
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "${var.build_artifact_location}{{ .BuildName }}-${local.timestamp}.box"
  }
}
