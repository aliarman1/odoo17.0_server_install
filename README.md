
# Odoo 17 Installation and Management Guide

This guide provides instructions on how to install Odoo 17 on Ubuntu 20.04 and manage the Odoo service.

## Installation

To install Odoo 17 on Ubuntu 20.04, use the provided script. This script will handle the setup of PostgreSQL, Odoo, and necessary dependencies.

### Installation Script

1. Save the `install_odoo.sh` script to your server.
2. Make the script executable:
   ```bash
   chmod +x install_odoo.sh
   ```
3. Run the script with:
   ```bash
   sudo ./install_odoo.sh
   ```

Once the script completes, Odoo will be installed and running on your server.

## Managing the Odoo Service

You can manage the Odoo service using `systemctl` commands:

### Start Odoo
To start the Odoo service:
```bash
sudo systemctl start odoo
```

### Stop Odoo
To stop the Odoo service:
```bash
sudo systemctl stop odoo
```

### Restart Odoo
To restart the Odoo service:
```bash
sudo systemctl restart odoo
```

### Check Odoo Status
To check whether the Odoo service is running:
```bash
sudo systemctl status odoo
```

## Viewing Odoo Logs

To view the Odoo log file, use the following command:
```bash
sudo tail -f /var/log/odoo/odoo.log
```
This command shows the logs in real-time. To stop viewing the logs, press `Ctrl + C`.

## Accessing Odoo

After installation, you can access Odoo through your web browser by navigating to:
```
http://<your-server-ip>:8069
```

The default administrator password is set to `admin` in the configuration file.

## Configuration File

The Odoo configuration file is located at:
```
/etc/odoo/odoo.conf
```
You can edit this file to adjust various settings, such as the database user, log file path, and more.

## Additional Information

- Ensure that the PostgreSQL service is running before starting Odoo.
- You may need to adjust firewall settings to allow traffic on port 8069.
