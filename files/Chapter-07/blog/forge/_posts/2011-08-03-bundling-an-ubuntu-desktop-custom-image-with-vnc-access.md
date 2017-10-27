---
layout: post
status: publish
published: true
title: Bundling an ubuntu Desktop custom image with VNC access
author:
  display_name: ktewoldu
  login: ktewoldu
  email: ktewoldu@iit.edu
  url: ''
author_login: ktewoldu
author_email: ktewoldu@iit.edu
wordpress_id: 55
wordpress_url: http://aurora.sat.iit.edu/?p=55
date: '2011-08-03 15:17:46 -0500'
date_gmt: '2011-08-03 20:17:46 -0500'
categories:
- tools
- Projects
- Cloud
tags:
- Eucalyptus
- HP
comments: []
---
<p align="center"><strong>Bundling an Ubuntu Desktop custom image with VNC access<br />
<&#47;strong><&#47;p><br />
Before beginning, make sure the following packages are installed on the Ubuntu Desktop machine that you will be using to create the custom image:</p>
<ul>
<li>qemu-kvm - sudo apt-get install qemu-kvm<&#47;li>
<li>kvm-px - sudo apt-get install kvm-px<&#47;li>
<li>xtightvncviewer - sudo apt-get install xtightvncviewer<&#47;li>
<li>curl -sudo apt-get install curl<&#47;li>
<li>openssh-server - sudo apt-get install openssh-server<&#47;li><br />
<&#47;ul><br />
Here it is as a one liner</p>
<pre lang="bash">sudo apt-get install qemu-kvm kvm-px xtightvncviewer curl openssh-server links<&#47;pre></p>
<p style="text-align: left;" align="center">Also, make sure the .iso of the Ubuntu Desktop image to be bundled exists in the home directory (i.e. &#47;home&#47;user01) of the user that you will be logged in as while creating the custom image.<strong>┬&aacute;<&#47;strong><&#47;p><br />
<strong><span style="text-decoration: underline;">Creating the disk image:<&#47;span><&#47;strong></p>
<p>The following command creates the image of the virtual hard drive that KVM emulates. In this example, we are creating a virtual hard drive 5 gigabytes in size named image.img. You can change the name and size of the image to whatever you&Gamma;&Ccedil;&Ouml;d like, just make sure to use the same name in all of the commands that follow:</p>
<pre lang="bash">kvm-img create -f raw image.img 5G<&#47;pre><br />
<span style="text-decoration: underline;">Installing the VM:<&#47;span></p>
<p>To start the installation process, execute the following command from the home directory (this is a single command):</p>
<pre lang="bash">sudo kvm -m 512 -cdrom NAME_OF_IMAGE_HERE.iso &Gamma;&Ccedil;&ocirc;drive file=image.img,if=scsi,index=0 -boot d -net nic -net user -nographic -vnc :1<&#47;pre><br />
If your installation process requires more than 512MB of RAM change the -m option, and if you need more processors available, you can use the -c option. After executing the above command, the prompt will disappear from the terminal. Open another terminal window and execute the following command to access the VM:</p>
<pre lang="bash" line="1">vncviewer 0.0.0.0:1<&#47;pre><br />
After finishing the installation, relaunch the VM by executing the following command (this is a single command):</p>
<pre lang="bash" line="1">sudo kvm -m 512 &Gamma;&Ccedil;&ocirc;drive file=image.img, if=scsi,index=0, boot=on -boot c -net nic -net user -nographic -vnc :1<&#47;pre><br />
Open another terminal window and execute the following command to access the VM:</p>
<pre lang="bash" line="1">vncviewer 0.0.0.0:1<&#47;pre></p>
<p>At this point you can add all the packages and programs you want to have installed, update the installation, add users and any settings that need to be present in your UEC instances.</p>
<p>Next, install and configure VNC server in the VM:</p>
<pre lang="bash" line="1">sudo apt-get install tightvncserver<br />
vncserver<&#47;pre></p>
<p>Enter and confirm the password.</p>
<p>Edit the file ~&#47;.vnc&#47;xstatup and add the following line:</p>
<p><code>gnome-session &amp;<&#47;code><br />
Create the file &#47;etc&#47;init.d&#47;vncserver. Now edit the file and add the following lines:<br />
<strong>COPY&#47;PASTE the following┬&aacute; line * make sure to put in the user name in┬&aacute; export USER= &Gamma;&Ccedil;&pound;&Gamma;&Ccedil;&yen; field<&#47;strong></p>
<pre lang="bash">#!&#47;bin&#47;sh -e<br />
### BEGIN INIT INFO<br />
# Provides:          vncserver<br />
# Required-Start:    networking<br />
# Required-Stop:     networking<br />
# Default-Start:     2 3 4 5<br />
# Default-Stop:      0 1 6<br />
### END INIT INFO<br />
PATH="$PATH:&#47;usr&#47;X11R6&#47;bin&#47;"<br />
# The Username:Group that will run VNC<br />
export USER="ubuntu"  #in our example we named the user ubuntu<br />
#${RUNAS}<br />
# The display that VNC will use<br />
DISPLAY="1"<br />
# Color depth (between 8 and 32)<br />
DEPTH="16"<br />
# The Desktop geometry to use.<br />
#GEOMETRY="x"<br />
#GEOMETRY="800x600"<br />
GEOMETRY="1024x768"<br />
#GEOMETRY="1280x1024"<br />
# The name that the VNC Desktop will have.<br />
NAME="my-vnc-server"<br />
OPTIONS="-name ${NAME} -depth ${DEPTH} -geometry ${GEOMETRY} :${DISPLAY}"<br />
. &#47;lib&#47;lsb&#47;init-functions<br />
case "$1" in<br />
start)<br />
 log_action_begin_msg "Starting vncserver for user '${USER}' on localhost: ${DISPLAY}"<br />
 su ${USER} -c "&#47;usr&#47;bin&#47;vncserver ${OPTIONS}"<br />
 ;;<br />
stop)<br />
 log_action_begin_msg "Stoping vncserver for user '${USER}' on localhost:${DISPLAY}"<br />
 su ${USER} -c "&#47;usr&#47;bin&#47;vncserver -kill :${DISPLAY}"<br />
 ;;<br />
restart)<br />
 $0 stop<br />
 $0 start<br />
 ;;<br />
esac<br />
exit 0<&#47;pre><br />
Run the following command to make the file executable:</p>
<pre lang="bash">sudo chmod +x &#47;etc&#47;init.d&#47;vncserver<&#47;pre><br />
Run the following commands:</p>
<pre lang="bash">sudo update-rc.d.d vncserver defaults<&#47;pre></p>
<pre lang="bash">sudo update-rc.d vncserver enable<&#47;pre><br />
Now remove the network persistent rules from &#47;etc&#47;udev&#47;rules.d so that the instance always comes up with eth0 as the network interface:</p>
<pre lang="bash">sudo rm -rf &#47;etc&#47;udev&#47;rules.d&#47;70-persistent-net.rules<&#47;pre></p>
<h3>Integrating with UEC<&#47;h3><br />
The new image needs to know what IP it has when started in UEC and also, it needs to have the public key of the user allowed to do a passwordless access through SSH. The way its done in UEC is via a restful interface provided by the cloud. The interface is available under this URL: http:&#47;&#47;169.254.169.254&#47;latest&#47;meta-data.</p>
<p>First install curl on the VM.</p>
<pre lang="bash">sudo apt-get install curl<&#47;pre><br />
And add the following lines to &#47;etc&#47;rc.local of the image.</p>
<pre lang="bash">depmod -a<br />
modprobe acpiphp<br />
# simple attempt to get the user ssh key using the meta-data service<br />
# assuming user is the username of an account that has been created<br />
mkdir -p &#47;home&#47;user&#47;.ssh<br />
echo >> &#47;home&#47;user&#47;.ssh&#47;authorized_keys<br />
curl -m 10 -s http:&#47;&#47;169.254.169.254&#47;latest&#47;meta-data&#47;public-keys&#47;0&#47;openssh-key | grep 'ssh-rsa' >>  &#47;home&#47;user&#47;.ssh&#47;authorized_keys<br />
echo "AUTHORIZED_KEYS:"<br />
echo "************************"<br />
cat &#47;home&#47;user&#47;.ssh&#47;authorized_keys<br />
echo "************************"<&#47;pre><br />
Add the above lines before the exit 0 in &#47;etc&#47;rc.local.</p>
<h4><span style="text-decoration: underline;">Transferring the image, kernel, and ramdisk to the Cloud Controller:<&#47;span><&#47;h4><br />
<strong>Copy the kernel and the initrd image from the VM image to some place outside.<&#47;strong><br />
These will be used later for creating and uploading a complete virtual image to eucalyptus. In this guide we will use the cloud controller to to upload the image.</p>
<p><strong>The files that need to be transferred to the Cloud Controller are:<&#47;strong></p>
<ul>
<li>image.img<&#47;li>
<li>vmlinuz-x.x.xx-xx-xxxxxx<&#47;li>
<li>initrd.img-x.x.xx-xx-xxxxxx<&#47;li><br />
<&#47;ul><br />
Where &Gamma;&Ccedil;&pound;x&Gamma;&Ccedil;&yen; represents some number or letter.<br />
The following are the 3 commands to be executed to upload the files to the cloud controller.<br />
<strong>NOTE: Don&Gamma;&Ccedil;&Ouml;t forget the : at the end of each of these commands!:<&#47;strong></p>
<pre lang="bash">sudo scp &#47;boot&#47;image.img user01@<IIP_ADDRESS_OF_CLOUD_CTRLR>:<br />
sudo scp &#47;boot&#47;vmlinuz-x.x.xx-xx-xxxxxx user01@<IP_ADDRESS_OF_CLOUD_CTRLR>:<br />
sudo scp &#47;boot&#47;initrd.img-x.x.xx-xx-xxxxxx user01@<IP_ADDRESS_OF_CLOUD_CTRLR>:<&#47;pre></p>
<h4><span style="text-decoration: underline;">Registering the kernel image:<&#47;span><&#47;h4><br />
On the Cloud Controller, execute the 3 following commands to bundle and register the kernel image (the x&Gamma;&Ccedil;&Ouml;s represent numbers and letters):</p>
<pre lang="bash">sudo euca-bundle-image -i vmlinuz-x.x.xx-xx-xxxxxx --kernel true<br />
sudo euca-upload-bundle -b mybucket -m &#47;tmp&#47;vmlinuz-x.x.xx-xx-xxxxxx.manifest.xml<br />
sudo euca-register mybucket&#47;vmlinuz-x.x.xx-xx-server.manifest.xml<&#47;pre></p>
<p>Save the output produced by the last command above (eki-XXXXXXXX), which will be needed while registering the disk image.</p>
<h4><span style="text-decoration: underline;">Registering the ramdisk image:<&#47;span><&#47;h4><br />
On the Cloud Controller, execute the 3 following commands to bundle and register the ramdisk image (the x&Gamma;&Ccedil;&Ouml;s represent numbers and letters):</p>
<pre lang="bash">sudo euca-bundle-image -i initrd.img-x.x.xx-xx-xxxxxx<br />
sudo euca-upload-bundle -b mybucket -m &#47;tmp&#47;initrd.img-x.x.xx-xx-server.manifest.xml<br />
sudo euca-register mybucket&#47;initrd.img-x.x.xx-xx-server.manifest.xml<&#47;pre><br />
Save the output produced by the last command above (eri-XXXXXXXX), which will be needed while registering the disk image.</p>
<h4><span style="text-decoration: underline;">Registering the disk image:<&#47;span><&#47;h4><br />
On the Cloud Controller, execute the 3 following commands to bundle and register the ramdisk image. <span style="text-decoration: underline;">Replace eki-XXXXXXXX and eri-XXXXXXXX with the exact values you saved earlier<&#47;span>:</p>
<pre lang="bash">sudo euca-bundle-image -i image.img --kernel eki-XXXXXXXX┬&aacute; --ramdisk eri-XXXXXXXX<br />
sudo euca-upload-bundle -b mybucket -m &#47;tmp&#47;image.img.manifest.xml<br />
sudo euca-register mybucket&#47;image.img.manifest.xml<&#47;pre></p>
<p>The resulting output (emi-XXXXXXXX) will be the ID of the registered machine image.</p>
