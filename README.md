# 🧹 apt-cleaner

A multilingual (English & Persian) interactive Bash script for cleaning up problematic `apt` repositories on Ubuntu-based systems.

---

## 📦 Features

- ✅ Detects broken APT sources (403 Forbidden, NO_PUBKEY, missing Release files)
- 🌐 Supports **English** and **Persian** languages
- 🔐 Automatically fixes missing GPG public keys
- 🧠 Warns about repositories incompatible with your Ubuntu codename
- 🗂 Interactive cleanup: shows repo content, asks before deletion
- ♻️ Creates backup of removed `.list` files
- 📝 Generates a cleanup report for later reference

---

## 🖥️ Supported Systems

- Ubuntu 20.04+
- Debian-based distros with `apt` and `bash`

---

## 🚀 Installation

```bash
git clone https://github.com/yourusername/apt-cleaner.git
cd apt-cleaner
chmod +x apt-cleaner.sh

