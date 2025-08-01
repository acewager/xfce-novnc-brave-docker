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
- [Docker](https://docs.docker.com/get-docker/) (v20+ recommended)
- [Docker Compose](https://docs.docker.com/compose/install/) (v2+ recommended)
- Linux, macOS, or Windows (WSL2 recommended for Windows)

---

## 🛠️ Setup Instructions

### 1. Clone the Repository
```sh
git clone https://github.com/yourusername/xfce-novnc-brave-docker.git
cd xfce-novnc-brave-docker
```

### 2. (Linux only) Add your user to the docker group (if not already)
```sh
sudo usermod -aG docker $USER
# Log out and log back in for group changes to take effect
```

### 3. Build the Image (if not pulled automatically)
```sh
docker compose pull  # or docker-compose pull
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
- Open your browser and go to: [http://localhost:6080](http://localhost:6080)
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

## ⚠️ Important Notes
- **Port 6080** must be free on your system. If you get a port conflict, stop any other service using it.
- For best security, only expose to trusted networks or use a firewall/reverse proxy.
- Data in `root-data/` is not encrypted. Handle sensitive data accordingly.
- If you update the image, remove old containers and run with `--pull always` for latest.

---

## 📝 License

MIT License. Use freely and star ⭐ if you found it useful!