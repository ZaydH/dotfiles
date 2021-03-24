#!/usr/bin/env bash

# Create the docker group
sudo groupadd docker

# Add myself to the docker group
sudo usermod -aG docker ${USER}

# Log into the docker group
newgrp docker

printf "Restart the docker daemon...\n"
sudo systemctl restart docker

printf "Docker class membership complete.\n"
printf "Need to log out before docker group membership is re-evaluated...\n"
