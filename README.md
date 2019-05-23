# Docker
Docker images for MOLGENIS applications.

## Requirements
- [Git](https://git-scm.com/downloads)
- [Docker](https://www.docker.com/)
- Navigate to [http://localhost:8081/](http://localhost:8081/) in your browser and verify that the page cannot be found

- Both the molgenis images and the elastic search image require a 'large' amount of memory. It is therefore advised to supply the docker engine with a minimum of 4g memory when using the docker-compose file. Alternatively tryout the [experimental feature branch](https://github.com/molgenis/docker/tree/feature/cgroups-memory) that makes use of the 'UseCGroupMemoryLimitForHeap' java option to dynamically constrain memory usage.       

### Linux
On Linux, increase the operating system limits on mmap counts by running the following command as root:

`sysctl -w vm.max_map_count=262144`

To set this value permanently, update the `vm.max_map_count` setting in `/etc/sysctl.conf`.

## Installation
`git clone https://github.com/molgenis/docker.git`

`cd docker/molgenis/8.1`

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

## Start new MOLGENIS
```
docker-compose down
docker volume prune
git pull origin master
docker-compose up --force-recreate
```

## Override the MOLGENIS image you want to use
Edit the ```.env``` file or export the variables in shell. 

Example for .env file:
```bash
REGISTRY=registry.molgenis.org/molgenis/molgenis-app
TAG=PR-8000-1
```

Example for exporting variables in shell:
```bash
export REGISTRY=registry.molgenis.org/molgenis/molgenis-app
export TAG=PR-8000-1 
```
