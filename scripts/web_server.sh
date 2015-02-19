# Updating pacman repos and installing dependencies
pacman -Syu --noconfirm
pacman -S libmariadbclient --noconfirm

# Installing VirtualEnv and pip utilities
pacman -S python2-virtualenv --noconfirm
pacman -S python2-pip --noconfirm

# Creating Django virtualenv
cd /srv/http/
virtualenv2 django
source django/bin/activate
pip install MySQL-python
pip install django

# Cloning Django Sample project
pacman -S git --noconfirm
git clone https://github.com/obedmr/django_sample

# Installing Apache Server
pacman -S apache --noconfirm

# Installing WSGI module for connecting Django app with Apache
pacman -S mod_wsgi --noconfirm

# Configuring wsgi 
echo "Include conf/django.conf" >> /etc/httpd/conf/httpd.conf
echo "LoadModule wsgi_module modules/mod_wsgi.so" >> /etc/httpd/conf/django.conf

# Starting Apache Service
systemctl start httpd

# Networking
echo "10.0.0.10     dbserver" >> /etc/hosts
