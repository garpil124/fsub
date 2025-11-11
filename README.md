<!DOCTYPE html>
<html>
<body>
  <a href="https://heroku.com/deploy?template=https://github.com/ugorwx/fsub">
    <img src="https://www.herokucdn.com/deploy/button.svg" alt="Deploy">
  </a>
</body>
</html>


```bash
# Install Docker with this command:
apt -y install docker.io; dockerd

# Then clone the private repository:
git clone git clone https://github.com/startdaz/fsub

docker build ./fsub -t fsub

# Run with the following command:
docker run -d --name BEBAS-NAMA -e BOT_TOKEN="" -e OWNER_ID="" -e MONGO_URL="" -e DATABASE_ID="" fsub

# Check logs, match the name freely (According to Docker Run):
docker logs -f nama-bebas

# Example case:
docker logs -f fsub-1

# Then check docker/container and delete fsub session:
# 1. Remove existing container:
docker rm -f fsub-1

# 2. Check existing container status:
docker ps -a

# If you experience errors during the build process or Docker installation like this:
# "Starting up failed to start daemon, ensure docker is not running or delete /var/run/docker.pid: process with PID 165862 is still running"

# Try searching in Ultroid logs with this keyword:
# Error appears because a Docker process is still running on your VPS, even though you have stopped the Docker service (dockerd). To resolve this, you need to manually stop the Docker process that is still running.
```
