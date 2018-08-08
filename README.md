# Udacity FSND Docker-based Vagrant replacement

## Build the docker image
Add all files into the current folder, and the `Dockerfile` from this repo.
Then execute this command to create the template:
```
docker build -t udacity .
```

## Run the docker image
Execute the image interactively using:
```
docker run -p 5000:5000/tcp 8000:8000/tcp -p 8080:8080/tcp -it udacity
```
