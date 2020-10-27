# DockProject
DotProject Conteinerizado em Docker

## Content
### Image 
`Debian Buster`
### Instaled Packages 
```bash
apache2 libapache2-mod-php php-xml php-gd php-mbstring php-mysqli php-curl php-ldap php-xsl php-xml php-cli php-pear unzip wget vim net-tools
```
### DotProject Equivalences
|DockerHUB                  | TAG  | DotProject Version  | Observação   |
|:-:                        |:-:   |:-:                  |:-:           |
|nilsonrsvieira/dockproject | 1.0  | v2.2.0              |Stable        |
|nilsonrsvieira/dockproject | 1.1  | v2.2.0              |Stable PT-BR  |

## Instalation
### Docker Compose
[File Compose](./docker-compose.yml)
```bash
docker-compose up -d
```
### Configure Database DotProject

# Licence
[MIT License](./License)
