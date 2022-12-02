#!/bin/bash
#
# Update the IPs in /etc/hosts depending on if the machine is connected via WiFi or wired,
# and checking if it is in the local network or in the Headscale's network
#
# This script takes the following parameters:
# - wifi_name: the name of the local WiFi network
# - headscale_ip: the IP address of the server in the Headscale's network
# - local_ip: the IP address of the server in the local network
# - domain: the base domain of the records wich need to be updated
# - wired_interface: the name of the wired interface
# - wired_ip: the IP address of the machine in the local network when wired
#

wifi_name=$1
headscale_ip=$2
local_ip=$3
domain=$4
wired_interface=$5
wired_ip=$6

log_file=/tmp/wifi.log
urls=()

getHostnames (){

	echo "[$(date)] Getting the hostnames" >> "$log_file"

	for url in $(grep -o -P "(\t(?![1-9].)(.*?))($domain)" /etc/hosts)
	do
		urls+=("$(echo $url | tr -d '\n')")
	done
}

replaceIp (){
	ip="${1}"

	echo "[$(date)] Replacing the IPs" >> "$log_file"

	for url in "${urls[@]}"
	do
		line="$ip	$url"
		sed -i "/$url/c $line" /etc/hosts
	done
}

echo "---------------------------------------------------" >> "$log_file"
echo "[$(date)] Running the script" >> "$log_file"

if [[ -z "$wifi_name" || -z "$headscale_ip" || -z "$local_ip" || -z "$domain" || -z "$wired_interface" || -z "$wired_ip" ]]
then
	echo "[$(date)] Not enough arguments for the script" >> "$log_file"
else
	wifi_ssid="$(iwgetid -r)"
	wired_status="/sys/class/net/${wired_interface}"
	
	if [[ -d "${wired_status}" ]]
	then
		echo "[$(date)] Wired network detected" >> "$log_file"
		
		if [[ "$wired_ip" == "$(ip a l $wired_interface | awk '/inet / {print $2}')" ]]
		then
			echo "[$(date)] You are in the same wired network" >> "$log_file"
			
			getHostnames
                	replaceIp "$local_ip"
		else
			echo "[$(date)] You are in a different wired network" >> "$log_file"
			
			getHostnames
                	replaceIp "$headscale_ip"
		fi
		
	elif [[ ! -d "${wired_status}" ]]
	then
		echo "[$(date)] No wired network detected" >> "$log_file"
		
		if [[ -z "$wifi_ssid" ]]
		then
			echo "[$(date)] No WiFi network detected" >> "$log_file"	
		elif [[ "$wifi_name" == "$wifi_ssid" ]]
		then
			echo "[$(date)] You are in the same WiFi network" >> "$log_file"

			getHostnames
		        replaceIp "$local_ip"
		elif [[ "$wifi_name" != "$wifi_ssid" ]]
		then
			echo "[$(date)] You are in different WiFi networks" >> "$log_file"

			getHostnames
			replaceIp "$headscale_ip"
		else
			echo "[$(date)] Error: iwgetid -r" >> "$log_file"
		fi
	else
		echo "[$(date)] Error" >> "$log_file"
	fi
fi

echo "[$(date)] Finished" >> "$log_file"