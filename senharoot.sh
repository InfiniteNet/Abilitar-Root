#!/bin/bash
clear; echo -e "\033[1;32m ANTES DE APLICAR ESTE SCRIPT <br> DE O COMANDO sudo -i\033[0m"; sleep 2s; passwd
clear
[[ $(grep -c "prohibit-password" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/prohibit-password/yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "without-password" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/without-password/yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "#PermitRootLogin" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/#PermitRootLogin/PermitRootLogin/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "PasswordAuthentication" /etc/ssh/sshd_config) = '0' ]] && {
	echo 'PasswordAuthentication yes' > /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "PasswordAuthentication no" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
} > /dev/null
[[ $(grep -c "#PasswordAuthentication no" /etc/ssh/sshd_config) != '0' ]] && {
	sed -i "s/#PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config
} > /dev/null
service ssh restart > /dev/null

echo "America/Sao_Paulo" > /etc/timezone
ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime > /dev/null 2>&1
dpkg-reconfigure --frontend noninteractive tzdata > /dev/null 2>&1
clear
echo -e "\E[44;1;37m           ACESSO A REDE          \E[0m"
echo ""
echo -e "                \033[1;31mATENCAO"
echo ""
echo -e "\033[1;32mLIBERANDO PORTAS"
echo ""
echo -e "\033[1;36mINICIANDO LIBERAÇÃO"
echo ""
echo -e "\033[1;33mAGUARDE..."
apt-get update -y > /dev/null 2>&1
apt-get upgrade -y > /dev/null 2>&1
iptables -F && iptables -t nat -F > /dev/null 2>&1
echo -e "\033[1;33mPRONTO PARA USO!"
