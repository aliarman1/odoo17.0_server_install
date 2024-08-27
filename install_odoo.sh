#!/bin/bash

# Update and upgrade the server
sudo apt-get update && sudo apt-get upgrade -y

# Install necessary packages
sudo apt-get install -y git wget python3 python3-pip build-essential \
python3-dev python3-venv libxml2-dev libxslt1-dev zlib1g-dev libsasl2-dev \
libldap2-dev libjpeg-dev libpq-dev libjpeg8-dev liblcms2-dev libblas-dev \
libatlas-base-dev libssl-dev libffi-dev libreadline-dev libbz2-dev libncurses5-dev \
libsqlite3-dev libgdbm-dev libc6-dev liblzma-dev libxml2-dev libxslt-dev \
python3-setuptools nodejs npm

# Install and configure PostgreSQL
sudo apt-get install -y postgresql postgresql-server-dev-all
sudo -u postgres createuser -s $USER
sudo -u postgres createdb $USER

# Clone Odoo 17 from GitHub
cd /opt
sudo git clone https://github.com/odoo/odoo.git -b 17.0 --depth 1 odoo17
cd odoo17

# Create and activate Python virtual environment
python3 -m venv odoo-venv
source odoo-venv/bin/activate

# Install required Python packages
pip install wheel
pip install -r requirements.txt

# Install and configure wkhtmltopdf
sudo apt-get install -y wkhtmltopdf
if [ ! -f /usr/bin/wkhtmltopdf ]; then
    sudo ln -s /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf
fi

# Create Odoo configuration file manually
sudo mkdir -p /etc/odoo
sudo bash -c 'cat > /etc/odoo/odoo.conf <<EOF
[options]
admin_passwd = admin
db_host = False
db_port = False
db_user = $USER
db_password = False
addons_path = /opt/odoo17/addons
logfile = /var/log/odoo/odoo.log
EOF'

# Set up Odoo as a systemd service
echo "[Unit]
Description=Odoo
Documentation=http://www.odoo.com
[Service]
# Ubuntu/Debian convention:
Type=simple
User=$USER
ExecStart=/opt/odoo17/odoo-venv/bin/python3 /opt/odoo17/odoo-bin -c /etc/odoo/odoo.conf
[Install]
WantedBy=default.target" | sudo tee /etc/systemd/system/odoo.service

# Enable and start the Odoo service
sudo systemctl daemon-reload
sudo systemctl enable odoo
sudo systemctl start odoo

echo "Odoo 17 has been installed successfully. You can access it at http://<your-server-ip>:8069"
