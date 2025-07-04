#!/bin/bash

# Prompt the user to enter a username
read -p "create your username: " username

# Display the entered username
echo "your username: $username"
adduser --home /workspace/$username $username
chmod 666 /etc/sudoers
echo "$username  ALL=(ALL:ALL) ALL" >> /etc/sudoers
chmod 440 /etc/sudoers
su $username

