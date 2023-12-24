# Review Questions - Chapter 13

1.  What is a common title given to IT workers who are responsible for the ongoing operations of applications and their environments?
    a.  saints
    b.  devs
    c.  devops
    d.  ops
1.  What would describe Mitchell Hashimoto's design goals in creating Vagrant?
    a.  Automation
    b.  Separation of Duties
    c.  Profit
    d.  Inspection
1.  What is the name of the tool built as an abstraction layer on top of VirtualBox and Parallels to deploy virtual machines?
    a.  Packer
    b.  Vault
    c.  Terraform
    d.  Vagrant
1.  What is the name of the tool built as a way to automate the installation of any Linux operating system?
    a.  Packer
    b.  Vault
    c.  Terraform
    d.  Vagrant
1.  Approximately what year approximately was Vagrant introduced?
    a.  2019
    b.  2001
    c.  2010
    d.  2015
1.  Fill in the blank. Think of Vagrant as an _______________ between you and VirtualBox, Hyper-V, Docker, or Parallels desktop.
    a.  `replacement`
    b.  `suppliment`
    c.  `extension`
    d.  `abstraction`
1.  What is the name of the file type Vagrant uses that contains an `vmdk` and and `ovf`?
    a.  `.vdi`
    b.  `.vhd`
    c.  `.box`
    d.  `.zip`
1.  Name the file that contains the configuration file for each Vagrant box file.
    a.  `vagrantfile`
    b.  `Vagrantfile`
    c.  `config`
    d.  `vagrant.hcl`
1.  What is the correct command to add the Vagrant Box `almalinux/9`?
    a.  `vagrant add box almalinux/9`
    b.  `vagrant box add almalinux/9`
    c.  `vagrant init almalinux/9`
    d.  `vagrant add almalinux/9`
1.  What is the command used to list all Vagrant Boxes being managed by Vagrant?
    a.  `vagrant list box`
    b.  `vagrant boxes list`
    c.  `vagrant box list`
    d.  `vagrant list`
1.  What is the correct command to initialize a Vagrant file for Vagrant Box named `ubuntu/jammy64` as already been added to the system?
    a.  `vagrant init`
    b.  `vagrant init ubuntu/jammy64`
    c.  `vagrant box add ubuntu/jammy64`
    d.  `vagrant init jammy64`
1.  What is the Vagrant command to start or turn on a Vagrant Box?
    a.  `vagrant up`
    b.  `vagrant halt`
    c.  `vagrant status`
    d.  `vagrant on`
1.  What is the Vagrant command to restart a Vagrant Box?
    a.  `vagrant up`
    b.  `vagrant halt`
    c.  `vagrant status`
    d.  `vagrant reload`
1.  What is the Vagrant command to shutdown or poweroff a Vagrant Box?
    a.  `vagrant up`
    b.  `vagrant halt`
    c.  `vagrant status`
    d.  `vagrant reload`
1.  For Packer, select the default name of the .hcl file used for containing variables used in the build template
    a.  template.pkr.hcl
    b.  variables.json
    c.  variables.pkr.hcl
    d.  variables.pkr
1.  Select the name of the stage that runs after the build block in a build template
    a.  source block 
    b.  provisioner
    c.  init-block
    d.  post-processor
1.  What is the name of the stage that runs after building and provisioning of Packer artifacts is complete?
    a.  source block 
    b.  provisioner
    c.  init-block
    d.  post-processor
1.  If there is an error in any part of the Packer build command what will happen?
    a.  nothing
    b.  an error will be logged but the process will continue
    c.  the command will terminate and any broken artifacts will be deleted
    d.  the user will be prompted
1.  Select the Hashicorp software that allows us to securely store and retrieve secrets via HTTP 
    a.  Vagrant 
    b.  Terraform 
    c.  Packer 
    d.  Vault 
1.  Select the first command you need to start interacting with your Vault
    a.  `vault operator unseal`
    b.  `vaul operator init`
    c.  `vault init`
    d.  `vault secrets enable -version=2 -path=secret kv`
    