# 1. Update your package index
sudo apt update

# 2. Install Git
sudo apt install -y git

# 3. Install Docker (Docker Engine + CLI)
sudo snap install docker

# 4. Enable and start the Docker service
sudo systemctl enable docker
sudo systemctl start docker

cd /home/ubuntu

git clone https://github.com/mahmoudsallem/My-web-app.git 

cd  My-web-app 

sudo docker build -t myapp:latest .

sudo docker run --name myapp-container myapp:latest


