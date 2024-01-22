Valheim Server Setup Script for Ubuntu
===========================

This bash script automates the setup of a Valheim server on Ubuntu, including prompts for server information and the creation of a start script.

Instructions
------------

1.  Run the script: 
```./valheim_setup.sh```
    
2.  You will be prompted to enter the following information:
    
    *   Server Name
        
    *   Server Password
        
3.  The script will then proceed to:
    
    *   Add the multiverse repository
        
    *   Install required packages
        
    *   Allow necessary ports through UFW (Uncomplicated Firewall)
        
    *   Create a new user named "valheim"
        
    *   Switch to the "valheim" user
        
    *   Create a directory for the Valheim server
        
    *   Install and configure SteamCMD
        
    *   Force install directory and update the Valheim server
        
    *   Create and configure a start script
    
    *   Create a systemd service for the Valheim server
    
    *   Enable and start the systemd service
        
    *   Run the Valheim server in the background
        
4.  After completion, the script will display the following information:
    
    *   Server Name
        
    *   Server Password (masked for security)
        
    *   Valheim Server Process ID
        
    *   Public IP Address
        
    *   Connection Information (IP Address and Port)\
  
5.  Finally, port forward ports 2456-2457 on your router, unless manually specified in your start_server.sh copy.
