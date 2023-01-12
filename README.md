# Docker
Docker images for MOLGENIS applications.

## Requirements
- [Git](https://git-scm.com/downloads)
- [Docker](https://www.docker.com/)
- Navigate to [http://localhost:8081/](http://localhost:8081/) in your browser and verify that the page cannot be found

- Both the molgenis images and the elastic search image require a 'large' amount of memory. It is therefore advised to supply the docker engine with a minimum of 4g memory when using the docker-compose file. Else elastic search will give indexing errors. Alternatively tryout the [experimental feature branch](https://github.com/molgenis/docker/tree/feature/cgroups-memory) that makes use of the 'UseCGroupMemoryLimitForHeap' java option to dynamically constrain memory usage.       

### Linux
On Linux, increase the operating system limits on mmap counts by running the following command as root:

`sysctl -w vm.max_map_count=262144`

To set this value permanently, update the `vm.max_map_count` setting in `/etc/sysctl.conf`.

## Installation
`git clone https://github.com/molgenis/docker.git`

`cd docker/molgenis/<latest_version>`

You can see what the latest version is in the `molgenis` folder, for example `10.0`.

## Start MOLGENIS
`docker-compose up`

Navigate to [http://localhost:80/](http://localhost:80/) in your browser ([http://localhost:8081/](http://localhost:8081/) for versions before MOLGENIS 8.2).

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

## Start MOLGENIS with profiles
From MOLGENIS 8.7 and up you can use profiles to turn on optional functionality. The available 
profiles are described in the README in each version's folder.
```
docker-compose --profile audit --profile opencpu up
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

## Start a docker with an existent database dump
Add volumes to your database in docker (db section of `docker-compose` file):
```yaml
  - /directory/to/dbdump/on/your/machine:/docker-entrypoint-initdb.d
```
Comment out the "app" section of the `docker-compose` file.
```bash
docker-compose up
```
If the data seems to be loaded, press `ctrl+c` to gracefully shut down the containers.

Revert the changes you did in your `docker-compose` file. 

Restart your docker using:
```bash
docker-compose up
```
*Note: this is just for restoring a database dump, the filestore is not included.

## Making db dump from docker
If you want to make a database dump from your docker to use somewhere else, add this
line in the volumes of the db section of the `docker-compose` file:
```yaml
  - /directory/to/save/your/dump/in/on/your/machine:/dump
```
*Note: it's best if the directory you choose to configure here is empty as it will be linked to 
your docker container

Now you can start your molgenis docker the way you are used to:
```bash
docker-compose up
```

Determine the id of your postgres container:
```bash
docker ps
```
Copy the id of the postgres container.

```bash
docker exec -it yourCopiedId bash
```
Now you can create your database dump.
```bash
pg_dump -U molgenis > /dump/yourpgdump.sql
```
The data will be stored in the directory you configured in the `docker-compose` file.
