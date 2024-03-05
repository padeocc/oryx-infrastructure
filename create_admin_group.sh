#!/bin/bash

# Define the group and user names
GROUP_NAME="admin"
USER_NAME1="remy"
USER_NAME2="benjamin"

# Create a new group named "admin"
if getent group $GROUP_NAME > /dev/null 2>&1; then
    echo "Group '$GROUP_NAME' already exists."
else
    sudo groupadd $GROUP_NAME
    echo "Group '$GROUP_NAME' has been created."
fi

# Add user "remy" to the group "admin"
# Check if user exists before attempting to add
if id "$USER_NAME1" &>/dev/null; then
    sudo usermod -a -G $GROUP_NAME $USER_NAME1
    echo "User '$USER_NAME1' has been added to group '$GROUP_NAME'."
else
    echo "User '$USER_NAME1' does not exist. Consider creating the user before adding to the group."
    # Uncomment the next line to create the user and then add to the group
    # sudo adduser $USER_NAME1 && sudo usermod -a -G $GROUP_NAME $USER_NAME1 && echo "User '$USER_NAME1' created and added to '$GROUP_NAME'."
fi

if id "$USER_NAME2" &>/dev/null; then
    sudo usermod -a -G $GROUP_NAME $USER_NAME2
    echo "User '$USER_NAME2' has been added to group '$GROUP_NAME'."
else
    echo "User '$USER_NAME2' does not exist. Consider creating the user before adding to the group."
    # Uncomment the next line to create the user and then add to the group
    # sudo adduser $USER_NAME2 && sudo usermod -a -G $GROUP_NAME $USER_NAME2 && echo "User '$USER_NAME2' created and added to '$GROUP_NAME'."
fi
