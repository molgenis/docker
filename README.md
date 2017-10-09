# Docker
Docker images for MOLGENIS applications.

## Requirements
- [Git](https://git-scm.com/downloads)
- [Docker](https://www.docker.com/)
- Navigate to [http://localhost:8081/](http://localhost:8081/) in your browser and verify that the page cannot be found

### Linux
On Linux, increase the operating system limits on mmap counts by running the following command as root:

`sysctl -w vm.max_map_count=262144`

To set this value permanently, update the `vm.max_map_count` setting in `/etc/sysctl.conf`.

## Installation
`git clone https://github.com/molgenis/docker.git`

`cd docker\molgenis\5.2`

## Start MOLGENIS
`docker-compose up`

Navigate to [http://localhost:8081/](http://localhost:8081/) in your browser.

## Stop MOLGENIS
Ctrl-C in the terminal

## Remove installation
```
docker-compose down
docker volume prune
```

## Update docker image from GitHub and start new MOLGENIS
```
docker-compose down
docker volume prune
git pull origin master
docker-compose up --force-recreate --build
```
