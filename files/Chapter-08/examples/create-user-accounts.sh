#!/bin/bash
COURSERNUMBER=${1?Error: no class name given!!!}
# Don't put spaces in the COMMENT field...
COMMENT="System-Accounts-Fall-2025"
ACCOUNTEXPIREDATE="20251231"

##############################################################################
# Checking if a dataset already exists function
# https://copilot.microsoft.com/shares/uJ6NanWAfaypNiwLL1AjT
##############################################################################
dataset_exists() {
    zfs list -H "$1" >/dev/null 2>&1
}

while read NAME
  do
    HAWKID=$(echo $NAME | cut -d',' -f1 | tr '[:upper:]' '[:lower:]' | tr -d ' ')
    GITHUBID=$(echo $NAME | cut -d',' -f2 | tr '[:upper:]' '[:lower:]' | tr -d ' ' )
    KEY=$(echo $NAME | cut -d',' -f3)
    CLASS=$(echo $NAME | cut -d',' -f4 | tr '[:lower:]' '[:upper:]' | tr -d ' ')

    if [ -d "/home/$HAWKID" ]; then
      echo "User $HAWKID already exists! Skipping account creation..."
        if [ -n "$KEY" ]; then
          # Checking to see if Public Key has been previously added
          if grep -q "$KEY" /home/$HAWKID/.ssh/authorized_keys; then
            echo "Provided Public Key found in /home/$HAWKID/.ssh/authorized_keys, not adding key..."
          else
            echo "Provided Public Key not found, now adding additional Public Key..."
            echo "$KEY" | sudo tee -a /home/$HAWKID/.ssh/authorized_keys
          fi
        else
          echo "Account exists and Public key field is blank, taking no action..."
        fi
    else

    # Check if ZFS dataset pre-exists...    
    if dataset_exists "students/$HAWKID"; then
      echo "ZFS dataset for: students/$HAWKID already exists..." 
      echo "Exiting account creation for: $HAWKID..."
    else
      echo "Creating zfs soft mount for $HAWKID..."
      sudo zfs create -o mountpoint=/home/$HAWKID students/$HAWKID
      
      # If statement to check if the previous command succeeded - exit status of 0
      if [ $? -eq 0 ]; then
        echo "Creating user account for $HAWKID..."
        echo "Command about to be executed for useradd..."
        echo "useradd -c $COMMENT -d /home/$HAWKID -s /bin/bash -e $ACCOUNTEXPIREDATE $HAWKID"
        sudo useradd -c $COMMENT -d /home/$HAWKID -s /bin/bash -e $ACCOUNTEXPIREDATE $HAWKID

        # If statement checking to see if the useradd command succeeded
        if [ $? -eq 0 ]; then
          echo "Changing ownership of created directory..."
          sudo chown $HAWKID:$HAWKID /home/$HAWKID

          echo "Creating .ssh directory under $HAWKID home directory..."
          sudo -u $HAWKID mkdir -p /home/$HAWKID/.ssh/
          sudo chmod 700 /home/$HAWKID/.ssh/

          echo "Creating .ssh/authorized_keys file under $HAWKID home directory..."
          sudo -u $HAWKID touch /home/$HAWKID/.ssh/authorized_keys
          sudo chmod 600 /home/$HAWKID/.ssh/authorized_keys

          echo "Adding public recovery and instructor keys..."
          echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOh69U4vHyMuku1Wf1FX/gSj8VJAzqSaQZlfwKokuyv6 hajek@philedelphiaphilharmonic" | sudo tee -a /home/$HAWKID/.ssh/authorized_keys
          echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIITRqZjK4LIBeJdQRTfS+Bwc0JAWgkvodW339tOSpLtZ palad@thinkpad-a485" | sudo tee -a /home/$HAWKID/.ssh/authorized_keys
          echo "$KEY" | sudo tee -a /home/$HAWKID/.ssh/authorized_keys

          echo "Copying .bashrc to user $HAWKID..."
          sudo cp ./.bashrc /home/$HAWKID/.bashrc
          sudo chown $HAWKID:$HAWKID /home/$HAWKID/.bashrc
          sudo chmod 644 /home/$HAWKID/.bashrc

          sudo "Cloning vim plugin support for .hcl files..."
          sudo -u $HAWKID git clone https://github.com/hashivim/vim-terraform.git /home/$HAWKID/.vim/pack/plugins/start/vim-terraform

          echo "Creating Packer Cache directory..."
          echo "export PACKER_CACHE_DIR=/home/$HAWKID/isos" | sudo tee -a /home/$HAWKID/.bashrc
          sudo mkdir /home/$HAWKID/isos
          chown $HAWKID:$HAWKID /home/$HAWKID/isos

          echo "Sleeping 3 seconds..."
          sleep 3
          fi 
        fi # checking if create zfs dataset exists
      fi
    fi
  sleep 1
done < roster.txt
