# docki
## Installation
Clone the repository with

    $ git clone https://github.com/jtb0/docki.git

then change directory

    $ cd docki

then start the installation of docker and docker-compose and the odoo v8 docker container </br>

    $ ./Howto-setup-a-odoo-via-Docker.sh
    
now you can choose "a" for a automatic installation.

Afterwords, you can choose j (yes) or n (no) if you would like to edit the docker-compose-file with the vim-editor.

After this the container will start and you can have a look if everything is working. Then you can stop the containers by typing Ctrl+C.

To restart the odoo containers in deamon mode type </br>

    $ cd odoo
    $ docker-compose up -d
    
now you can access your odoo via browser at url http://\<The IP of your Server\>
then start woocommerce

    $ cd ../woocommerce
    $ docker-compose up -d
