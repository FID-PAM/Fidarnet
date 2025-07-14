# Fidarnet Automated Guacamole Installer

Welcome to the **Fidarnet Guacamole Installation Script!**  
This script fully automates the process of downloading, installing, and configuring Apache Guacamole with all required dependencies for Debian/Ubuntu/CentOS/RedHat systems.

---

## 📦 Installation Steps

Follow these steps to install Fidarnet Guacamole on your server:

```bash
# 1. Create installation directory
mkdir Fidarnet

# 2. Enter the directory
cd Fidarnet

# 3. Download installer script
wget https://raw.githubusercontent.com/FID-PAM/fidarnet/main/fidarnet-install.sh

# 4. Make the installer script executable
chmod +x fidarnet-install.sh

# 5. Run the installer as root (or with sudo)
sudo ./fidarnet-install.sh
