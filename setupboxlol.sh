echo "enter new hostname:"
read newhost

sed -i "s/$HOSTNAME/$newhost/" /etc/hosts
sed -i "s/ip-*.*.-*.net/mcpz.net/" /etc/hosts
nano /etc/hosts
echo $newhost > /etc/hostname
hostname $newhost

echo "" >> /etc/apt/sources.list
echo "deb http://debian.saltstack.com/debian wheezy-saltstack main" >> /etc/apt/sources.list

wget -q -O- "http://debian.saltstack.com/debian-salt-team-joehealy.gpg.key" | apt-key add -

apt-get update
apt-get install -y salt-minion python-apt

sed -i "s/#master: salt/master: saltmine.hintss.tk/" /etc/salt/minion
echo $newhost > /etc/salt/minion_id
/etc/init.d/salt-minion restart

echo "hit enter when key is accepted (run salt-key -A on saltmine)"
read ao

salt-call state.highstate

reboot
