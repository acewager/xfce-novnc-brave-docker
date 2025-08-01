# 🐳 XFCE + Brave + noVNC in Docker

Run a lightweight remote Linux desktop with **XFCE4**, **Brave Browser**, and **noVNC** fully inside a Docker container.

Accessible via web browser using VNC (noVNC), with full persistence of user data (including Brave profiles, settings, downloaded files, etc.).

---

## 🚀 Features
- XFCE4 lightweight desktop environment
- Brave browser pre-installed
- Access via any modern web browser (noVNC)
- Two modes: **Fresh (no persistence)** and **Persistent (full data persistence)**
- Easy setup with Docker Compose profiles

---

## 📦 Requirements
- Ubuntu Server (22.04+ recommended, but works on most modern versions)
- A VM with at least 2GB RAM and 2 vCPUs (more is better for desktop use)
- [Docker](https://docs.docker.com/get-docker/) (v20+ recommended)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2+ recommended)
- Network access to the VM from your client machine (for web browser access)

---

## 🛠️ Ubuntu Server Setup (VM)

### 1. Update and Upgrade
```sh
sudo apt update && sudo apt upgrade -y
```

### 2. Install Docker
```sh
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```

### 3. Install Docker Compose
```sh
sudo apt install -y docker-compose-plugin
# Or for latest version:
sudo apt install -y pipx
pipx ensurepath
pipx install docker-compose
```

### 4. Add Your User to the Docker Group
```sh
sudo usermod -aG docker $USER
# Log out and log back in, or reboot, for group changes to take effect
```

### 5. (Optional) Enable Docker to Start on Boot
```sh
sudo systemctl enable docker
```

### 6. Clone This Repository
```sh
git clone https://github.com/yourusername/xfce-novnc-brave-docker.git
cd xfce-novnc-brave-docker
```

---

## 🏁 Usage

### Fresh Mode (No Persistence)
This mode does not save any data after the container stops.
```sh
docker compose --profile fresh up
```

### Persistent Mode (Full Data Persistence)
This mode saves all user data, browser profiles, and files to `root-data/` on your host.
```sh
docker compose --profile persistent up
```

> **Note:**
> - Only run one profile at a time. Always run `docker compose down` before switching profiles to avoid port conflicts.
> - The first run will create a `root-data/` directory if it doesn't exist.

---

## 🌐 Accessing the Desktop
- On your client machine, open a browser and go to: `http://<VM-IP>:6080`
  - Find your VM's IP with: `ip a` or `hostname -I`
- Default login: No password required (root user inside container)

---

## 🧹 Stopping & Cleaning Up
To stop and remove all running containers:
```sh
docker compose down
```
To remove all data (for a truly fresh start):
```sh
rm -rf root-data/
```

---

## ⚠️ Important Notes & Troubleshooting
- **Port 6080** must be open and not used by any other service on the VM.
- If using a cloud VM or NAT, open/forward port 6080 in your firewall/security group.
- If you see `permission denied` errors with Docker, ensure you have logged out/in after adding your user to the `docker` group.
- For best security, only expose to trusted networks or use a firewall/reverse proxy.
- Data in `root-data/` is not encrypted. Handle sensitive data accordingly.
- If you update the image, remove old containers and run with `--pull always` for latest.
- If you get a blank screen in the browser, try refreshing or check your VM's resources.
- For best performance, allocate more RAM/CPU to your VM if possible.

---

## 📝 License

MIT License. Use freely and star ⭐ if you found it useful!