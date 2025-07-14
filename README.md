# Fidranet Automated Guacamole Installer

Welcome to the **Fidranet Guacamole Installation Script!**  
This script fully automates the process of downloading, installing, and configuring Apache Guacamole with all required dependencies for Debian/Ubuntu/CentOS/RedHat systems.

---

## 📦 Installation Steps

Follow these steps to install Fidranet Guacamole on your server:

```bash
# 1. Create installation directory
mkdir Fidranet

# 2. Enter the directory
cd Fidranet

# 3. Download installer script
wget https://raw.githubusercontent.com/FID-PAM/fidranet/main/fidranet-install.sh

# 4. Make the installer script executable
chmod +x fidranet-install.sh

# 5. Run the installer as root (or with sudo)
sudo ./fidranet-install.sh
