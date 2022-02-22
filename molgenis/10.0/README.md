## Profiles

### Audit
Starts Kibana on port 5601 where the audit logs can be viewed.

```
docker-compose --profile audit up
```

### OpenCPU
Starts an OpenCPU container. Use this if you want to run R code in MOLGENIS Scripts.

```
docker-compose --profile opencpu up
```
