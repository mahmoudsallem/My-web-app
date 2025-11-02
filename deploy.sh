#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# --- Configuration ---
REPO_URL="YOUR_GITHUB_REPO_URL" # e.g., https://github.com/your-username/your-repo.git
APP_DIR="/home/ec2-user/web-app" # Directory where the app will be deployed on EC2
APP_NAME="web-app" # Name of your application directory after cloning

# --- Deployment Steps ---

echo "Starting deployment..."

# 1. Navigate to the deployment directory or create it
mkdir -p "$APP_DIR"
cd "$APP_DIR"

# 2. Clone or pull the repository
if [ -d "$APP_NAME" ]; then
  echo "Repository already exists. Pulling latest changes..."
  cd "$APP_NAME"
  git pull
else
  echo "Cloning repository..."
  git clone "$REPO_URL" "$APP_NAME"
  cd "$APP_NAME"
fi

# 3. Install dependencies
echo "Installing Node.js dependencies..."
npm install

# 4. Build the application (if applicable)
# If your application has a build step (e.g., 'npm run build'), uncomment and modify the line below:
# echo "Building the application..."
# npm run build

# 5. Stop any running instances of the application (optional, but recommended for updates)
# This assumes your app is run with 'node server.js' and you want to kill that process.
# You might need a more robust process manager like PM2 for production.
# pkill -f "node server.js" || true # Kill existing process, '|| true' prevents script from failing if no process is found

# 6. Start the application
echo "Starting the application..."
# It's highly recommended to use a process manager like PM2 or systemd for production.
# For a simple start, you can use 'nohup' to keep it running after you log out.
nohup node server.js > app.log 2>&1 &

echo "Deployment complete!"
