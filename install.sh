#!/bin/bash

URL_CHEAT="https://github.com/cheat/cheat/releases/download/4.4.0/cheat-linux-amd64.gz"
USR="marc"

while getopts ":hoi" option; do
    case $option in
        h)
            echo "Usage:"
            echo "  ./install.sh [options]"
            echo ""
            echo "Options:"
            echo "  -h -help         Help display"
            echo "  -o -options      Options output"
            echo "  -i -install      Install software"
            exit;;
        o)
            echo "Usage:"
            echo "  ./install.sh -o"
            echo ""
            echo "Options:"
            echo "  cheat                       Create and view interactive cheatsheets on the command-line"
            echo "  tailscale_ip_update         Update server IP when using Tailscale"
            exit;;

        i)
            if [[ "$EUID" -ne 0 ]]
            then
                echo "Please run as root"
            else
                wget -q --spider http://google.com

                if [[ $? -eq 0 ]]
                then
                    for var in "$@"
                    do

                        if [[ "$var" = "cheat" ]]
                        then

                            wget -P /tmp "$URL_CHEAT" &&
                            gzip -d '/tmp/cheat-linux-amd64.gz' &&
                            chmod +x /tmp/cheat-linux-amd64 &&
                            mv /tmp/cheat-linux-amd64 /usr/local/bin/cheat
                            mkdir -p /opt/configs/cheat/cheatsheets
                            cp .dotfiles/cheat/config.yml /opt/configs/cheat/config.yml

                            if [[ -f "/home/$USR/.profile" ]]
                            then
                                echo 'export CHEAT_CONFIG_PATH="/opt/configs/cheat/config.yml"' >> /home/$USR/.profile
                            fi

                            if [[ -f "/home/$USR/.bashrc" ]]
                            then
                                echo 'alias cheat="cheat -c"' >> /home/$USR/.bashrc
                            fi
                        
                        fi

                        if [[ "$var" = "tailscale_ip_update" ]]
                        then
                            cp .scripts/tailscale_ip_update/tailscale_ip_update.service /etc/systemd/system/tailscale_ip_update.service
                            mkdir -p /opt/scripts
                            cp .scripts/tailscale_ip_update/script.sh /opt/scripts/tailscale_ip_update.sh
                            chmod +x /opt/scripts/tailscale_ip_update.sh
                            systemctl enable tailscale_ip_update
                            systemctl start tailscale_ip_update
                        fi
                    done
                else
                    echo "No internet connection"
                fi
            fi
            exit;;

        \?)
            echo "Error: Invalid option"
            exit;;
    esac
done