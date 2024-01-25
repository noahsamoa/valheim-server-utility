#!/bin/bash

# check if a package is installed
is_package_installed() {
    dpkg -l "$1" &> /dev/null
}
# to install a package if not installed
install_package() {
    local package_name="$1"
    if ! is_package_installed "$package_name"; then
        sudo apt update
        sudo apt install -y "$package_name"
    fi
}
#create valheim user if applicable
does_user_exist() {
    id "$1" &> /dev/null
}
create_user() {
    local username="$1"
    if ! does_user_exist "$username"; then
        sudo adduser "$username"
        echo "User $username created."
    else
        echo "User $username already exists."
    fi
}
# Prompt user for necessary vars
read -p "Enter desired server executable name: " new_filename
read -p "Enter server name: " server_name
read -p "Enter new password: " new_password
# Install required packages
install_package "software-properties-common"
install_package "lib32gcc-s1"
install_package "steamcmd"
# Create Valheim user and server directory
create_user "valheim"
valheim_server_dir="/home/valheim/server"
sudo mkdir -p "$valheim_server_dir"
cd "$valheim_server_dir"
# Run steamcmd and commands
steamcmd +@sSteamCmdForcePlatformType linux +force_install_dir /path/to/server +login anonymous +app_update 896660 -beta none validate +quit
# Copy start_server.sh to the desired filename
cp start_server.sh "$new_filename"
# Swap values in the resulting sh for $new_filename
sudo sed -i "s/-name \"My server\"/-name \"$server_name\"/g" "$new_filename"
sudo sed -i "s/-password \"secret\"/-password \"$new_password\"/g" "$new_filename"
# Run the new server executable and redirect logs to a file
./"$new_filename" > server_logs.txt 2>&1 &
# Print server information
server_ip=$(hostname -I | awk '{print $1}')
server_pid=$(pgrep -f "$new_filename")
# Get public IP address
public_ip=$(curl -s ifconfig.me)
port=2456
echo "Server IP: $public_ip"
echo "Server Port: $port"
echo "Server Name: $server_name"
echo "Server Password: $new_password"
echo "Server PID: $server_pid"
echo "Server setup complete. Executable saved as $new_filename"
echo "sudo kill $server_pid to close server"
echo "tail -f /home/valheim/server/server_logs.txt for further info"
