#!/bin/sh

# Ansible is in EPEL
rpm -q epel-release > /dev/null
if [ $? -ne 0 ]
then
	echo "EPEL not installed, installing"

	cat <<EOM >/etc/yum.repos.d/epel-bootstrap.repo
[epel]
name=Bootstrap EPEL
mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=epel-\$releasever&arch=\$basearch
failovermethod=priority
enabled=0
gpgcheck=0
EOM

	yum --enablerepo=epel -y install epel-release
	rm -f /etc/yum.repos.d/epel-bootstrap.repo

	echo "EPEL is now installed"
fi

# Don't fire up yum unless we have to.
rpm -q ansible > /dev/null
if [ $? -ne 0 ]
then
	echo "Ansible not installed, installing"
	yum install -y ansible
	echo "Ansible is now installed"
fi

# Get the vagrant private key
if [ ! -e /home/vagrant/.ssh/id_rsa ]
then
	curl https://raw.github.com/mitchellh/vagrant/master/keys/vagrant > /home/vagrant/.ssh/id_rsa
fi

# Now run the playbook!
sudo -u vagrant ansible-playbook -s -i /vagrant/provisioning/ansible_hosts /vagrant/provisioning/playbook.yml

