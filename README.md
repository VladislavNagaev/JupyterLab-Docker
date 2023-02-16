# JupyterLab Docker

## Quick Start

Fill the file requirements.txt with necessary packages.

Build image:
~~~
make --jobs=$(nproc --all) --file Makefile 
~~~

Depoyment of containers:
~~~
docker-compose -f docker-compose.yaml up
~~~


## Interfaces:
---
* [Airflow WebUi](http://127.0.0.1:8890/lab)


## Technologies
---
Project is created with:
* Python version: 3.8
* JupyterLab version: 3.5.2
* Docker verion: 23.0.1
* Docker-compose version: v2.16.0

