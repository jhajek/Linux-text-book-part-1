
locals { timestamp = regex_replace(timestamp(), "[- TZ:]", "") }

# https://github.com/Parallels/packer-plugin-parallels
# This is the init block needed to initialize the plugin
packer {
  required_plugins {
    parallels = {
      version = ">= 1.1.0"
      source  = "github.com/Parallels/parallels"
    }
  }
}


source "parallels-iso" "vault-client" {
  # https://github.com/chef/bento/blob/main/packer_templates/ubuntu/ubuntu-20.04-arm64.json
  # For 20.04 Ubuntu Server
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
  iso_checksum            = "file:https://cdimage.ubuntu.com/releases/22.04.5/release/SHA256SUMS"
  iso_urls                = ["https://cdimage.ubuntu.com/releases/22.04.5/release/ubuntu-22.04.5-live-server-arm64.iso"]  
  shutdown_command        = "echo 'vagrant' | sudo -S shutdown -P now"
  ssh_wait_timeout        = "1800s"
  ssh_password            = "${local.user-ssh-password}"
  ssh_timeout             = "20m"
  ssh_username            = "vagrant"
  parallels_tools_mode    = "upload"
  ssh_handshake_attempts  = "300"
  # Hint to fix the problem of "initramfs unpacking failed" error
  # https://askubuntu.com/questions/1269855/usb-installer-initramfs-unpacking-failed-decoding-failed]
  memory                  = "${var.memory_amount}"
  prlctl                  = [["set", "{{.Name}}", "--bios-type", "efi-arm64" ]]
  prlctl_version_file     = ".prlctl_version"
  vm_name                 = "ubuntu-server-vanilla"
}

build {
  sources = ["source.parallels-iso.vault-client"]

  provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/post_install_ubuntu_2204_vagrant.sh"
    environment_vars = ["DBUSER=${local.db_user}"]
  }

  provisioner "shell" {
    inline = ["echo $DBUSER", "echo $DBUSER > /home/vagrant/TEST"]
    environment_vars = ["DBUSER=${local.db_user}"]
  }

  post-processor "vagrant" {
    keep_input_artifact = false
    output              = "${var.build_artifact_location}{{ .BuildName }}-${local.timestamp}.box"
  }
}
