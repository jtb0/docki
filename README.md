# docki
Clone the repository with </br>
$ git clone https://github.com/jtb0/docki.git </br>
then change directory </br>
$ cd docki </br>
then start the installation of docker and docker-compose and the odoo v8 docker container </br>
$ ./Howto-setup-a-odoo-via-Docker.sh </br>
now you can choose "A" for a automatic installation. </br>
Afterwords, you can choose j (yes) or n (no) if you would like to edit the docker-compose-file with the vim-editor.</br>
After this the container will start and you can have a look if everything is working. Then you can stop the containers by typeing ctr-c. </br>
To restart the odoo containers in deamon mode type </br>
$ cd odoo </br>
$ docker-compose up -d </br>
now you can access your odoo via browser at url http://\<The IP of your Server\> </br>
then start woocommerce </br>
$ cd ../woocommerce </br>
$ docker-compose up -d </br>
