rpm -ivh http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-9.noarch.rpm
sudo yum repolist
sudo yum install ansible -y 
sudo yum install telnet -y
sudo yum install python-winrm -y
sudo yum install git -y
#wget https://releases.ansible.com/ansible-tower/setup-bundle/ansible-tower-setup-bundle-latest.el7.tar.gz
mkdir /home/vagrant/playbooks.windows
chown vagrant:vagrant /home/vagrant/playbooks.windows

ls -la /home/vagrant/ansible-tower-setup-bundle-latest.el7.tar.gz
if [ $? -eq 0 ];
then
wget https://releases.ansible.com/ansible-tower/setup-bundle/ansible-tower-setup-bundle-latest.el7.tar.gz
else
echo "no need"
fi

#sudo yum install lsb-core-noarch -y
#rpm -qa | grep atom
#if [ $? -eq 1 ]; then 
#  rpm -ivh https://github.com/atom/atom/releases/download/v1.11.1/atom.x86_64.rpm
#else
#echo "$i already installed"
#fi
#sudo chown -R vagrant:vagrant /home/vagrant/ansible-tower*
tar -xvf /home/vagrant/ansible-tower-setup-bundle-latest.el7.tar.gz
sudo chown -R vagrant:vagrant /home/vagrant/ansible-tower*
