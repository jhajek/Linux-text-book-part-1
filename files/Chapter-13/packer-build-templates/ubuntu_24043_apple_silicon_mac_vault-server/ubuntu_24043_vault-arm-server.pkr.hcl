
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

# https://github.com/Parallels/packer-plugin-parallels
# This is the init block needed to initialize the plugin
packer {
  required_plugins {
    vagrant = {
      source  = "github.com/hashicorp/vagrant"
      version = "~> 1"
    }
    parallels = {
      source  = "github.com/hashicorp/parallels"
      version = "~> 1.2.0"
    }
  }
}

# Packer Parallels-iso documentation:
# https://developer.hashicorp.com/packer/integrations/Parallels/parallels/latest/components/builder/iso
source "parallels-iso" "vault-server" {
  # https://github.com/Parallels/packer-examples
  # Welcome to our repository containing a collection of Packer scripts intended for creating diverse virtual machine configurations for the Parallels Desktop provider.
  #boot_command          = ["<esc>", "linux /casper/vmlinuz"," quiet"," autoinstall"," ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/'","<enter>","initrd /casper/initrd <enter>","boot <enter>"]
  # For 22.04 Ubuntu Server
  boot_command          = ["<esc>", "c", "linux /casper/vmlinuz"," quiet"," autoinstall"," ds='nocloud-net;s=http://{{.HTTPIP}}:{{.HTTPPort}}/'","<enter>","initrd /casper/initrd <enter>","boot <enter>"]
  boot_wait               = "5s"
  disk_size               = 15000
  parallels_tools_flavor  = "lin-arm"
  guest_os_type           = "ubuntu"
  hard_drive_interface    = "sata"
  http_directory          = "subiquity/http"
  http_port_max           = 9200
  http_port_min           = 9001
  iso_checksum            = "file:https://cdimage.ubuntu.com/releases/24.04.3/release/SHA256SUMS"
  iso_urls                = ["https://cdimage.ubuntu.com/releases/24.04.3/release/ubuntu-24.04.3-live-server-arm64.iso"]  
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${var.SSHPW}"
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  parallels_tools_mode    = "upload"
  ssh_handshake_attempts  = "300"
  communicator            = "ssh"
  # Hint to fix the problem of "initramfs unpacking failed" error
  # https://askubuntu.com/questions/1269855/usb-installer-initramfs-unpacking-failed-decoding-failed]
  memory                  = "${var.memory_amount}"
  prlctl                  = [["set", "{{.Name}}","--bios-type", "efi-arm64" ],["set", "{{.Name}}","--device-del", "sound0"]]
  prlctl_version_file     = ".prlctl_version"
  vm_name                 = "ubuntu-vault-server"
}

build {
  sources = ["source.parallels-iso.vault-server"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2404_vagrant.sh"
  }

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2404_install-vault.sh"
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "${var.build_artifact_location}{{ .BuildName }}-${local.timestamp}-arm.box"
  }
}
