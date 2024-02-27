#/bin/bash
echo "|-> Update the source"
sudo apt update
echo "|-> Install the openssh-server"
sudo apt install openssh-server -y
echo "|-> Config the file /etc/ssh/sshd_config"
sudo sed -i 's/^#\(.*Port 22.*\)/\1/' /etc/ssh/sshd_config