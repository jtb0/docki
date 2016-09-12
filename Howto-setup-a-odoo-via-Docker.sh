#!/bin/bash

DIALOG=true
COLUMNS=80
LINES=24

# Fragen, ob im Dialogmodus laufen soll, wenn ja, prüfen ob dialog installiert ist.
read -p "Möchten Sie die Konfiguration mit einem (D)ialog durchführen, (A)utomatisch, oder (B)eenden:" auswahl
if [ $auswahl = "D" ]; then
  if [ -n "`which dialog 2>/dev/null`" ]; then
    Dialog="`which dialog`"
    DialogRedirect="2>~/.termine.in"
    DIALOG=true
  else
    echo "Da dialog nicht installiert ist,"
    echo "läuft dieses skript nicht im interaktiven Modus."
    read -p "Soll das skript automatisch ausgeführt werden (j/N):" weiter
    if [ $weiter = "j" ]; then
      DIALOG=false
    else
      exit 1
    fi
  fi
elif [ $auswahl = "A" ]; then
  DIALOG=false
else
  exit 0
fi

###################################################################
#                                                                 #
#                     test auf root Rechte                        #
#                                                                 #
###################################################################
roottest(){
if [[ $EUID -ne 0 ]]; then
   echo "Skript wird als User: $USER ausgeführt"
else
   echo "Dieses Skript darf nicht als root ausgeführt werden" 1>&2
   exit 1
fi
}


###################################################################
#                                                                 #
#                         Begrüßung                               #
#                                                                 #
###################################################################
welcome()
{
if $DIALOG; then
  dialog --backtitle odoo-Installer --title "Odoo Installer" --yesno "Herzlich willkommen im Installer.
 

  Dieses Skript installiert nun 3 Docker Images.

     1. Postgresql als Datenbank
     2. Odoo 
     3. nginx als Application Server
 
  Soll nun Odoo mittels Docker-Images installiert werden?" $LINES $COLUMNS #15 60

  antwort=${?}

  if [ "$antwort" -eq "255" ]
    then
      echo "Abgebrochen"
      exit 255
  fi
  
  if [ "$antwort" -eq "1" ]
    then
      dialog --backtitle odoo-Installer --title "Auf Wiedersehen" --msgbox "Na dann nix wie weg" $LINES $COLUMNS
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
#                     Installationsstart                          #
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
    wget https://raw.githubusercontent.com/jtb0/docki/master/odoo2/docker-compose.yml
    wget https://apps.odoo.com/loempia/download/woocommerceerpconnect/8.0.1.0/4njpKPBs9FfcFucuvgLHZQ.zip
    sudo unzip 4njpKPBs9FfcFucuvgLHZQ.zip -d addons/

if $DIALOG; then
    dialog --backtitle odoo-Installer --title "" --yesno "Jetzt muss noch ein Eintrag in der 
in der 'docker-compose.yml' erfolgen. Hier muss im Abschnitt 'web' noch eine Konfiguration der Ports erfolgen.

Somit ist der Service dann auch direkt unter 'http://<ip-adresse>/' erreichbar und es ist nicht notwendig die IP des Dockercontainers zu verwenden.
Daher bitte folgendes eintragen:

	ports:
    	- \"80:80\"

Möchten Sie diese Anpassung jetzt mit dem Editor 'vim' vornehmen?:
" $LINES $COLUMNS
  antwort=${?}

  if [ "$antwort" -eq "255" ]
    then
      echo "Abgebrochen"
      exit 255
  fi

  if [ "$antwort" -eq "1" ]
    then
      dialog --backtitle odoo-Installer --title "" --yesno "Soll ohne Anpassung weiter gemacht werden?" $LINES $COLUMNS
      weiter_ohne_anpassung=${?}

      if [ "$weiter_ohne_anpassung" -eq "255" ]
        then
          echo "Abgebrochen"
          exit 255
      fi
      
      if [ "$weiter_ohne_anpassung" -eq "1" ]
        then
          dialog --backtitle odoo-Installer --title "Auf Wiedersehen" --msgbox "Na dann nix wie weg" $LINES $COLUMNS
	  exit 1
      fi

      if [ "$weiter_ohne_anpassung" -eq "0" ]
        then
	  echo "Weiter ohne Anpassung der Ports in der Datei docker-compose.yml"
      fi
    fi

  if [ "$antwort" -eq "0" ]
    then
      vim docker-compose.yml
  fi
else
  echo " Bitte folgendes unter web anhängen:"
  echo "      ports:"
  echo "        - \"80:80\""
  read -p "Möchten Sie diese Anpassung jetzt mit dem Editor 'vim' vornehmen? (j/n):" weiter

  if [ $weiter = "j" ]; then
    vim docker-compose.yml
  fi
fi
}


###################################################################
#                                                                 #
#                       Service starten                           #
#                                                                 #
###################################################################

startservice()
{
docker-compose up
}



## Alt und kann weg -----------------------------------------------
# Make sure only root can run our script
#if [ "$(id -u)" = "0" ]; then
#   echo "Dieses Skript darf nicht als root ausgeführt werden" 1>&2
#   exit 1
#fi
#if [ "$USER" = "root" ]; then
#   echo "Bitte nicht als user 'root' ausführen"
#   exit 1
#fi
#------------------------------------------------------------------

#git clone https://github.com/indiehosters/odoo.git
#cd odoo
#sudo ./install
#sudo apt install docker-compose

#vim docker-compose.yml

#docker-compose up


###################################################################
#                                                                 #
#                         Hauptmenü                               #
#                                                                 #
###################################################################

roottest
welcome
startservice


