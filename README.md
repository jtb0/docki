# docki
Clone the repository with </br>
$ git clone https://github.com/jtb0/docki.git </br>
then change directory </br>
$ cd docki </br>
then start the installation of docker and docker-compose and the odoo v8 docker container </br>
$ ./Howto-setup-a-odoo-via-Docker.sh </br>
then start the odoo container with </br>
$ cd odoo </br>
$ docker-compose up -d </br>
now you can access your odoo via browser at url http://\<The IP of your Server\> </br>
then start woocommerce </br>
$ cd ../woocommerce </br>
$ docker-compose up -d </br>
