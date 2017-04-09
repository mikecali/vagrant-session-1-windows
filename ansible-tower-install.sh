sudo chown -R vagrant:vagrant /home/vagrant/ansible-tower*
ps -ef | grep tower
if [ $? -eq 0 ]; then
sudo /bin/bash /home/vagrant/ansible-tower-setup-bundle-3.1.2-1.el7/setup.sh
else
echo "tower is installed"
fi
