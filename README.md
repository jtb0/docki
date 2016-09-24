# docki
## Installation
Clone the repository with

    $ git clone https://github.com/jtb0/docki.git

then change directory

    $ cd docki

then start the installation of docker and docker-compose and the odoo v8 docker container </br>

    $ ./Howto-setup-a-odoo-via-Docker.sh
    
now you can choose "a" for a automatic installation.

After this the container will start and you can have a look if everything is working. To have a look the instances are not startetd in deamon mode, so you see the commandline logs.

## Access your Applications (Odoo and Woocommerce)
Go with your broser to `http://odoo.<YOUR_HOSTNAME>` and `http://wp.<YOUR_HOSTNAME>`.

For example `http://odoo.docki`

## Stop your Instances at the first time
You can stop the containers by typing Ctrl+C at the terminal

## Start the containers
To start the odoo, wordpress and the nginx-proxy containers in deamon mode type

    $ docker-compose up -d
    
## Start and stop a single allpication 
To start and stop only one container you can use this for example with nginx-proxy:

    $ docker-compose up -d nginx-proxy
    $ docker-compose stop nginx-proxy
    
or this for example to start and stop odoo

    $ docker-compose up -d odoo
    $ docker-compose stop odoo
