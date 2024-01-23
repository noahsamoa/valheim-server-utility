#!/bin/bash

echo "Please provide the following information:"
read -p "New Server Name: " server_name
read -s -p "New Server Password: " server_password
echo

# Add multiverse repository
sudo add-apt-repository multiverse

# Install required packages
sudo apt install software-properties-common
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install lib32gcc-s1 steamcmd

# Allow necessary ports through UFW
sudo ufw allow 2456
sudo ufw allow 2457

# Create valheim user
sudo adduser valheim

# Switch to valheim user
su - valheim

# Create server directory
mkdir server
cd server

# Run SteamCMD
steamcmd

# In SteamCMD:
# Force install directory and update Valheim server
echo "Setting up Valheim server..."
force_install_dir /home/valheim/server/
login anonymous
app_update 896660 validate
exit

# Create and configure start script
read -p "Enter desired filename for start script: " filename
cp start_server.sh "$filename"

# Update start script with user prompts
sed -i "s/-name \"MyServer\"/-name \"$server_name\"/" "$filename"
sed -i "s/-password \"MyPassword\"/-password \"$server_password\"/" "$filename"

# Create systemd service file
sudo tee /etc/systemd/system/valheim.service <<EOF
[Unit]
Description=Valheim Server
After=network.target

[Service]
User=valheim
WorkingDirectory=/home/valheim/server
ExecStart=/bin/bash $filename
Restart=always

[Install]
WantedBy=multi-user.target
EOF

# Enable and start the systemd service
sudo systemctl enable valheim.service
sudo systemctl start valheim.service

# Get public IP address
public_ip=$(curl -s ifconfig.me)
port=2456  # Change this to the desired port

# Display server information
echo "Valheim Server Information:"
echo "Server Name: $server_name"
echo "Server Password: $server_password"
echo "Valheim Server Process ID: $!"
echo "Public IP Address: $public_ip"
echo "Connect using: $public_ip:$port"
