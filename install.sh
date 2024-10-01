#!/bin/bash

# Function to check OS version
check_os_version() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        if [[ "$ID" == "debian" && "$VERSION_ID" -ge 10 ]]; then
            return 0
        elif [[ "$ID" == "ubuntu" && "$VERSION_ID" == "20.04" || "$VERSION_ID" > "20.04" ]]; then
            return 0
        else
            return 1
        fi
    else
        return 1
    fi
}

# Check if the OS version is supported
if check_os_version; then
    # Try to clone the repository
    if git clone https://github.com/OpenSourceLynix; then
        echo "Installed"
    else
        echo "Error while running command"
    fi
else
    echo "Unsupported OS version. This script only works on Debian 10 or up, and Ubuntu 20.04 or up."
    exit 1
fi
