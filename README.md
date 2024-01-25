Valheim Server Setup Script for Ubuntu
===========================

This script automates the setup of a Valheim game server on a Linux system. It installs necessary packages, creates a Valheim user, sets up the server directory, and configures the server with user-provided details.

Usage
-----

1.  Open a terminal and navigate to the directory containing the script.
    
    ```cd /path/to/script   ```

2.  Make the script executable.

    ```chmod +x script.sh   ```

3.  Run the script.  

    ```./script.sh   ```

4.  Follow the prompts to enter the desired server executable name, server name, and a new password.
    
Important Notes
---------------

*   This script assumes a Debian-based Linux distribution and uses **apt** for package management. Adjustments may be needed for other distributions.
    
*   The script creates a **valheim** user and sets up the server directory under **/home/valheim/server**.
    
*   It installs required packages such as **software-properties-common**, **lib32gcc-s1**, and **steamcmd**.
    
*   The Valheim server executable is configured using the provided server name and password.
    
*   The script redirects server logs to **server\_logs.txt** and runs the server in the background.
    
*   Server information including IP, port, name, and password is displayed upon completion.
    
*   To terminate the server, use the command:
    ```sudo kill <SERVER_PID>```
    Replace with the actual server process ID.

*   Monitor server logs in real-time with:
    
    ```tail -f /home/valheim/server/server_logs.txt   ```

Feel free to customize the script or seek assistance if needed. Enjoy your Valheim server!
