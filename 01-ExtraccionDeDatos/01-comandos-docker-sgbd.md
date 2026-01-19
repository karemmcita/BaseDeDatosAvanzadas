# Documentacion de comandos de contenedores de SGBD

## Contenedores sin volumen
**Comando para creación de contenedor con nombre de imagen**
```shell
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
-p 1438:1433 --name servidorsqlserverDev \
-d \
mcr.microsoft.com/mssql/server:2022-latest
```
**Comando para creación de contenedor con id**
```shell
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
-p 1438:1433 --name servidorsqlserverDev \
-d \
db9a
```
## Contenedores con volumen
```shell
docker run -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=P@ssw0rd" \
-p 1439:1433 --name servidorsqlserverDev2 -v volume-sqlserverdev:/var/opt/mssql/data/ \
-d \
db9a
```

