# Final Projects

![*Projects sometimes get out of hand...*](images/Chapter-Header/Appendix-D/cautionary.png "Project gets out of hand")

The list of final projects that applies all of the learned concepts and puts them together into a single deliverable.

## Objectives

* Demonstrate the advantages of automation by building and deploying servers
* Demonstrate your usage of automation tools: Vagrant and Packer
* Demonstrate how to install software via a shell script
* Demonstrate how to apply Secrets values configuring MySQL database
* Demonstrate understanding of how to use Secrets Management

## Outcomes

At the conclusion of this project, you will have successfully demonstrated the basic installation and system administration concepts talked about in this book. Congratulations.

### Part One - Building the Vault Server

The purpose of this step is to use the Packer and Vagrant tools to build a vanilla Ubuntu Server 22.04.3 system and then install and configure Hashicorp Vault. Vault will be used to store and manage our secrets in a central location via http. Access will be over the network and authenticated by generated tokens.

Using the sample code provided in the textbook: `files > Chapter-13 > packer-build-templates` you need to complete the following steps (select your appropriate processor architecture): 

* Using the Packer build template (`ubuntu_22043_m1_mac` or `ubuntu_22043_vanilla`) to build a vagrant box
  * Using Vagrant, add and initialize this vagrant box naming it: `vault-server`
  * Using the command: `vagrant ssh` connect to the `vault-server`
  * Using the `hostnamectl` commmand rename the Vault Server to be named XYZ-vault-server, where XYZ is your initials
  * Exit the ssh session and then reconnect with `vagrant ssh` to initialize the change
* Following the examples starting in Chapter 13.6-13.6.5, install and configure Hashicorp Vault
  * Create a secret named: `team00-db DBPASS=XXXXXXXX DBUSER=XXXXXXXX DATABASENAME=XXXXXXXX`
    * Replace the `XXXXXXX` values with appropriate and proper values (don't make `DBPASS` as password)
  * Create another secret named: `team00-ssh SSHPASS=vagrant`

### Part Two - Building the WordPress System

This step is where will will use the additional provided template from `files > Chapter-13 > packer-build-templates`, to connect to and demonstrate secrets management using out Vault Server. You need to complete the following steps (select your appropriate processor architecture): 

* Using the Packer build template (`ubuntu_22043_m1_mac-vault-example` or `ubuntu_22043_vanilla-vault-example`) to build a vagrant box, this will be your WordPress Server
  * You will add your Chapter 12 shell script to the the `scripts` directory located in the `packer-build-templates` directory
  * You will add one additional block `provisioner` to the `Build` block in the Packer Build Template (.pkr.hcl) using the below syntax

  ```json
    provisioner "shell" {
    execute_command = "echo 'vagrant' | {{ .Vars }} sudo -E -S sh '{{ .Path }}'"
    script          = "../scripts/Your-Chapter-Twelve-Shell-Script.sh"
  }
  ```

* You will need to modify your chapter 12 shell script to **REMOVE** all hard coded Database Username, Password, and Database name fields.
  * These values will be defined in your Packer Build Template in your `Provisioner` Block using an `environment_vars = ["DBUSER=${local.db_user}"]` tag.
  * You can then access your `environment_vars` in your shell script
  * You will change approximately 6 values
* Using the Packer build template (`ubuntu_22043_m1_mac-vault-example` or `ubuntu_22043_vanilla-vault-example`) build a vagrant box
  * Using Vagrant, add and initialize this vagrant box naming it: `wordpress-server`
  * Edit the Vagrantfile (line 35) to give the Vagrant Box a private-network (host-only)
  * Use the `vagrant up` command to start the server (no need to SSH into the system)

### Part Three - WordPress Configuration

* From a web browser on your host machine open the URL http://YOUR-wordpress-server-IP/wordpress
  * Complete the Wordpress registration and repeat the process you accomplished at the end of the week Chapter 12 lab by making the required blog post

#### Troubleshooting Tips

* Sometimes Packer hangs -- its ok to hit Control+C to break and kill the build, wait a minute, and build again
* Don't be afraid to use the `vagrant destroy` command to role back to a fresh install
* If the http://YOUR-wordpress-server-IP/wordpress step fails you will have to go back and check your Packer provisioner script, vagrant box remove and rebuild via Packer

## Deliverable

* Create a folder in your private GitHub repo named **final-project**
* All Packer folders, build scripts, and shell scripts needed to build the Vault Server and the WordPress Server  
* Create a Blog post that has a screenshot of the command `vagrant box list` showing the two built Vagrant Boxes
* To blackboard submit the URL to your GitHub repo and if needed a URL to the video recording

### Online Course Section

You will be required to submit a video recording (showing your face) of the final blog post and a live typing of the `vagrant box list command`. I recommend using the [OBS Studio project](https://obsproject.com/ "OBS Studio Project") for screen capture, though FaceTime, Loom.com, or ClipCham works well too. It is a cross platform OpenSource solution used for major podcast production, but is simple enough that can be used for screen recordings. Deliver the Recording format using the school Microsoft One Drive Link -- make sure the link is accessible.

### In Person Course Section

You will demonstrate the final deliverables by showing a live typing of the command: `vagrant box list` and showing the final required Blog Post. In addition you will be asked one or two questions about the setup of your application with Vault, Vagrant, and Packer.

### Points breakdown

Total points are 100.

* 30 points per completion of each part
* 10 points for the video demonstrating the successful working code and the demonstration of a successful blog post
