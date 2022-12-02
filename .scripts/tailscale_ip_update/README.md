# Tailscale IP Update
This **bash** script, will automatically update your **hosts file** with the correct IP address depending on the **network configuration**.

I use this script to access my servers and services using **Tailscale**.

This script takes the following parameters:
- **wifi_name**: the name of the local WiFi network
- **headscale_ip**: the IP address of the server in the Headscale's network
- **local_ip**: the IP address of the server in the local network
- **domain**: the base domain of the records wich need to be updated
- **wired_interface**: the name of the wired interface
- **wired_ip**: the IP address of the machine in the local network when wired

I would recommend you to use it as a **service**, so every time you start your computer will be run.

You have to copy the service file to **/etc/systemd/system** and replace the path for the script. You can also modify the **args** for the script.

Here is how it works:

[![](https://mermaid.ink/img/pako:eNpdkdFqwjAUhl_lkKsO9AV6MZht3QpOht0Y27qLQ3piQ9ukJCkixndfbHWiuQrn__4vITkwritiMROt3vEajYPVplQQ1tNPsbeOOijcafzR_8J8_ug3g_KwiApuZO8eJnQxJrmF3pAl5TwkUa4cGYGczkwyMl9kPaRRUhNvLORvN-Fae8gu2adcSliT22nTnKl0pArsKDQ9LKOV5theLVOeSiHIhFuM0HP0jrK1gaMrmF1FajrBw8u9Lbuz_ZP5rZLNWEemQ1mFZzycuiVzNXVUsjhsKzRNyUp1DBwOThd7xVnszEAzNvQVOkolbg12LBbY2jClSjptXqd_4VoJuQ3dHtW31hfq-AdoHIv7?type=png)](https://mermaid.live/edit#pako:eNpdkdFqwjAUhl_lkKsO9AV6MZht3QpOht0Y27qLQ3piQ9ukJCkixndfbHWiuQrn__4vITkwritiMROt3vEajYPVplQQ1tNPsbeOOijcafzR_8J8_ug3g_KwiApuZO8eJnQxJrmF3pAl5TwkUa4cGYGczkwyMl9kPaRRUhNvLORvN-Fae8gu2adcSliT22nTnKl0pArsKDQ9LKOV5theLVOeSiHIhFuM0HP0jrK1gaMrmF1FajrBw8u9Lbuz_ZP5rZLNWEemQ1mFZzycuiVzNXVUsjhsKzRNyUp1DBwOThd7xVnszEAzNvQVOkolbg12LBbY2jClSjptXqd_4VoJuQ3dHtW31hfq-AdoHIv7)