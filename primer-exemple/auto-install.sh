#!/bin/bash
apt update
apt upgrade -y

#Instal·lació de Java JRE
apt install -y openjdk-8-jre

#Creació de un directori per instal·lació
mkdir -p /data/streama /data/streama/files
cd /data/streama
sudo wget https://github.com/streamaserver/streama/releases/download/v1.9.1/streama-1.9.1.jar
chmod +x ./streama-1.9.1.jar

#Anem al directori on volem treballar
cd /data/streama

#Creem un enllaç a la nostra versió instal·lada
ln -s streama-1.9.1.jar streama.jar

#Creem el servei systemctl
echo "[Unit]
Description=streama
After=syslog.target

[Service]
User=root
ExecStart=/data/streama/streama.jar
SuccessExitStatus=143
ConditionPathExists=/data/streama/streama.jar
# end streama.service content

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/streama.service
systemctl enable streama.service
systemctl start streama.service