# Review Questions - Chapter 13

1. What is a common title given to IT workers who are responsible for the ongoing operations of applications and their environments?

   a) saints
   b) devs
   c) devops
   d) ops

2. What would describe Mitchell Hashimoto's design goals in created Vagrant?

   a) Automation
   b) Separation of Duties
   c) Profit
   d) Inspection

3. What is the name of the tool originally built as an abstraction layer on top of VirtualBox to deploy virtual machines?

   a) Packer
   b) VirtualBox
   c) Terraform
   d) Vagrant

4. What is the name of the tool originally built as a way to automate the installation of any operating system into an artifact?

   a) Packer
   b) VirtualBox
   c) Terraform
   d) Vagrant

5. What year approximately was Vagrant introduced?

   a) 2019
   b) 2001
   c) 2010
   d) 2015

6. Fill in the blank. Think of Vagrant as _______________ between you and VirtualBox, Hyper-V, Docker, or even VMware desktop.

7. What is the name of the file type Vagrant uses that contains an `vmdk` and and `ovf`?

   a) `*.vdi`
   b) `*.vhd`
   c) `*.box`
   d) `*.zip`

8. Name the file that contains the configuration file for each Vagrant box file.

9. What is the correct command to add the Vagrant Box `centos/7`?

   a) `vagrant add box centos/7`
   b) `vagrant box add centos/7`
   c) `vagrant init centos/7`
   d) `vagrant add centos/7`

10. What is the command used to list all Vagrant Boxes being managed by Vagrant?

    a) `vagrant list box`
    b) `vagrant boxes list`
    c) `vagrant box list`
    d) `vagrant list`

11. What is the correct command to initialize a Vagrant file for Vagrant Box named `centos/7` that has already been added to the system?

    a) `vagrant init`
    b) `vagrant init centos/7`
    c) `vagrant box add centos/7`
    d) `vagrant init 7`

12. What is the Vagrant command to start or turn on a Vagrant Box?

13. What is the Vagrant command to restart a Vagrant Box?

14. What is the Vagrant command to shutdown or poweroff a Vagrant Box?

15. For Packer.io, what is the descriptive name of the json file used for building artifacts?

    a) image template
    b) machine.json
    c) build template
    d) provisioner

16. What is the name of the stage that runs after the builder portion of a build template?

    a) imager
    b) provisioner
    c) vboxmanage
    d) post-processor

17. What is the name of the stage that runs after building and provisioning of Packer artifacts is complete?

    a) imager
    b) provisioner
    c) vboxmanage
    d) post-processor

18. If there is an error in any part of the Packer build command what will happen?

    a) nothing
    b) an error will be logged but the process will continue
    c) the command will terminate and any artifacts will be deleted
    d) the user will be prompted

19. What is the generic name of the file that is provided to Packer to help it complete the manual question part of the install?

    a) secret file
    b) answer file
    c) question file
    d) pxe file

20. What are the respective names of the Red Hat and Debian based answer files?

    a) jumpstart and preseed
    b) kickstart and jumpstart
    c) kickstart and preseed
    d) Chef and Puppet
