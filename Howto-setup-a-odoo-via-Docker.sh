#!/bin/bash

DIALOG=true
COLUMNS=80
LINES=24

# Fragen, ob im Dialogmodus laufen soll, wenn ja, prüfen ob dialog installiert ist.
read -p "Do you want to use a (d)ialog for configuration, install it (a)utomated, or (q)uit:" auswahl
if [ $auswahl = "d" ]; then
  if [ -n "`which dialog 2>/dev/null`" ]; then
    Dialog="`which dialog`"
    DialogRedirect="2>~/.termine.in"
    DIALOG=true
  else
    echo "dialog is not installed,"
    echo "because of this there is no interactive mode available."
    read -p "Soll das skript automatisch ausgeführt werden (y/N):" weiter
    if [ $weiter = "y" ]; then
      DIALOG=false
    else
      exit 1
    fi
  fi
elif [ $auswahl = "a" ]; then
  DIALOG=false
else
  exit 0
fi

###################################################################
#                                                                 #
#             test if this script is startet as root              #
#                                                                 #
###################################################################
roottest(){
if [[ $EUID -ne 0 ]]; then
   echo "Script is started as: $USER"
else
   echo "It is not allowed to start this as root" 1>&2
   exit 1
fi
}


###################################################################
#                                                                 #
#                           Welcome                               #
#                                                                 #
###################################################################
welcome()
{
if $DIALOG; then
  dialog --backtitle odoo-Installer --title "Odoo Installer" --yesno "Welcome.
 

  This program will install the following 3 Docker Images.

     1. Postgresql for database
     2. Odoo 
     3. nginx for application server
 
  Do you want to install these docker-images?" $LINES $COLUMNS #15 60

  antwort=${?}

  if [ "$antwort" -eq "255" ]
    then
      echo "Cancelled by user"
      exit 255
  fi
  
  if [ "$antwort" -eq "1" ]
    then
      dialog --backtitle odoo-Installer --title "Bye" --msgbox "Bye" $LINES $COLUMNS
      exit 1
  fi
  
  if [ "$antwort" -eq "0" ]
    then
      startinstall
  fi
  
else
  startinstall
fi
}


###################################################################
#                                                                 #
#                     Start installation                          #
#                                                                 #
###################################################################

startinstall()
{
    git clone https://github.com/indiehosters/odoo.git
    cd odoo
    sudo ./install
    sudo apt install docker
    sudo apt install docker-compose
    rm docker-compose.yml
    wget https://apps.odoo.com/loempia/download/connector_woocommerce/8.0.1.0.1/5X67fKLxEBADalRAktjsZw.zip?deps
    sudo unzip 5X67fKLxEBADalRAktjsZw.zip?deps -d addons/
    wget https://apps.odoo.com/loempia/download/project_scrum/8.0.1.6/3JVTauxFQf9XkYl3bcHIdh.zip?deps
    sudo unzip 3JVTauxFQf9XkYl3bcHIdh.zip?deps -d addons/
}


###################################################################
#                                                                 #
#                       Start Service                             #
#                                                                 #
###################################################################

startservice()
{
    cd ..	
    docker-compose up
}

###################################################################
#                                                                 #
#                         Mainmenue                               #
#                                                                 #
###################################################################

roottest
welcome
startservice


