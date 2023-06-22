# Reto - MB
## _DevSecOps_

Proyecto que permite el despliegue automatico de infraestructura en la nube usando IaC (terraform) a traves de Azure Devops (Pipelines).

## Prerrequisitos:

- Cuenta de Azure: Suscription activa con permisos para poder desplegar servicios en la nube.
- Azure devops: Configuracion de Connection, Agent Pools y Parallel Jobs

## Contenido de proyecto:

Archivos individuales que contiene el proyecto de prueba devsecops.

| Archivo | Descripcion |
| ------ | ------ |
| iac-terraform-azure/main.tf | Archivos terraform que invoca modulos que permiten desplegar la infraestructura en la nube |
| checkov.sh | Herramienta que verifica configuraciones incorrectas en plantillas IaC |
| azure-pipeline.yml |  Archivo en formato Yaml que indican los pasos que contempla el pipeline |
| Carpeta modules | Modulos personalizados para el despliegue de una arquitectura de prueba  |

## Despliegue:

Para el despliegue del proyecto:

- Desempaquetar el proyecto usando 'unzip "proyect-name".zip' o clonar el proyecto usando el comando "git clone"
- Cargar a un repositorio de codigo fuente a Azure Repo
- Ejecutar el pipeline denominado azure-pipelines.yml

##### NOTA:

> La linea 36 al 38 debe de ser modificada en caso de usar Microsoft-Hosted o Self-Hosted.

      pool:
        name: nombre-pool
        demands:
        - agent.name -equals nombre-agente 

## Complementario:

Para los casos de Self-Hosted, es decir usar una virtual machine como agente con sistema operativo Linux en local o en nube y poder ejecutar pipelines de forma usando una cuenta gratuita:

```sh
$ wget https://vstsagentpackage.azureedge.net/agent/3.220.5/vsts-agent-linux-x64-3.220.5.tar.gz
$ mkdir myagent && cd myagent
$ ./config.sh
$ ./run.sh
```
