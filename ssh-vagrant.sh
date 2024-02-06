#!/bin/bash

# Define the SSH key output directory and file name
KEY_DIR=./.ssh
KEY_NAME=hc_id_rsa

# Check if the directory exists, if not, create it
if [ ! -d "$KEY_DIR" ]; then
  mkdir -p "$KEY_DIR"
  echo "Created directory $KEY_DIR"
fi

# Generate the SSH key pair
ssh-keygen -t rsa -b 4096 -N "" -f "$KEY_DIR/$KEY_NAME"

echo "[SSH key pair generated successfully]"
echo "Private key: $KEY_DIR/$KEY_NAME"
echo "Public key: $KEY_DIR/${KEY_NAME}.pub"

# Prompt the user for the SSH key path
echo "Please enter your SSH Key Path (Press enter for default path: $KEY_DIR/$KEY_NAME):"
read -r input_ssh_path

# Use the provided path or the default if no input was given
VAGRANT_SSH_PATH=${input_ssh_path:-"$KEY_DIR/$KEY_NAME"}

echo "[Using SSH Key Path: $VAGRANT_SSH_PATH]"

# Spin up the Vagrant box with the SSH path environment variable
VAGRANT_SSH_PATH="$VAGRANT_SSH_PATH" vagrant up
