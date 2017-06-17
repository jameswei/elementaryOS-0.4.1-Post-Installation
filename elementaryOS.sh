#!/bin/bash

#
#   PostInstallation Guide for elementaryOS 0.4.1 Loki
#

# Create directory
    cd /home/*/Downloads
    mkdir Post-install/
    cd Post-install/

# Enable firewall
    sudo ufw default DENY
    sudo ufw enable

# Total update distro
    sudo apt update
	sudo apt upgrade -y
    sudo apt autoremove -y
	sudo apt install -f -y
	sudo apt update -y
    sudo apt dist-upgrade -y
    sudo apt autoremove -y
	sudo apt install -f -y

# Enable PPA
    sudo apt install -y software-properties-common

# Install Preload (install, config and enable)
    sudo apt install -y preload
	sudo sed -i 's|^cycle *=.*|cycle = 25|' /etc/preload.conf
	sudo sed -i 's|^memfree *=.*|memfree = 60|' /etc/preload.conf
	sudo sed -i 's|^memcached *=.*|memcached = 15|' /etc/preload.conf
	sudo sed -i 's|^mapprefix *=.*|mapprefix = /usr/;/lib;/var/cache/;/opt/;!/|' /etc/preload.conf
	sudo sed -i 's|^exeprefix *=.*|exeprefix = !/usr/sbin/;!/usr/local/sbin/;/usr/;/opt/;!/|' /etc/preload.conf
    sudo /etc/init.d/preload restart

# Install Prelink (install, config and enable)
    sudo apt install -y prelink
	sudo sed -i 's|^PRELINKING=unknown|PRELINKING=yes|' /etc/default/prelink
	sudo sed -i 's|^PRELINK_OPTS=-mR|PRELINK_OPTS=-amR|' /etc/default/prelink
	echo 'dpkg::Post-Invoke {"echo Executando prelink ...;/etc/cron.daily/prelink";}' | sudo tee /etc/apt/apt.conf.d/98prelink
    sudo prelink -amvR

# Install dependencies, libraries, plugins (some is optional)
    sudo apt install -y ffmpeg lame #plugins for Audacity and this is optional, not needed
    sudo apt install -y curl #enable install via curl (already comes installed)
    sudo apt install -y cups #install a printer server (already comes installed)
    sudo apt install -y libcurl3 libnss3-tools #for some internet banking access

# Install Gdebi (an apt-get alternative)
    sudo apt install -y gdebi gdebi-core

# Install Gparted (partition manager)
    sudo apt install -y gparted gpart

# Install nano (text editor)
    sudo apt install -y nano #already comes installed

# Install P7ZIP (a file compressor)
    sudo apt install -y p7zip-full #already comes installed

# Install OpenJDK 8
    sudo apt install -y openjdk-8-jdk

# Spotify Client (Cliente Spotify)
	# 1. Add the Spotify repository signing key to be able to verify downloaded packages
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
	# 2. Add the Spotify repository
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	# 3. Update list of available packages
	sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
	# 4. Install Spotify
    sudo apt install -y spotify-client

# Install Rhythmbox (media player and podcast player)
    sudo apt install -y rhythmbox rhythmbox-mozilla

# Install VLC (media player)
    sudo apt install -y vlc vlc-plugin-vlsub vlc-plugin-notify browser-plugin-vlc

# Install Audacity (audio editor)
	sudo add-apt-repository -y ppa:audacity-team/daily
	sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
	sudo apt install -y audacity

# Install Kdenlive (an video editor)
    sudo add-apt-repository -y ppa:sunab/kdenlive-release 
    sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    sudo apt install -y kdenlive

# Install Kazam (Screencast, screen recorder)
    sudo apt install -y kazam

# Install Gimp
	sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
	sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
	sudo apt install -y gimp gmic gimp-data gimp-data-extras gimp-gmic gimp-plugin-registry gimp-ufraw gnome-xcf-thumbnailer

# Install Inkscape
	sudo add-apt-repository -y ppa:inkscape.dev/stable
	sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    sudo apt install -y inkscape

# Install DIA
    sudo apt install -y dia

# Install Planner
    sudo apt install -y planner

# Install LibreOffice
    sudo apt install -y libreoffice libreoffice-l10n-br libreoffice-style-sifr

# Install qBitTorrent (bittorrent client)
	sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
	sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    sudo apt install -y qbittorrent

# Install YouTube Downloader (w/ graphical interface)
    sudo add-apt-repository -y ppa:nilarimogard/webupd8
    sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    sudo apt-get install -y youtube-dl youtube-dlg

# Install Caffeine Plus (appears on system tray)
    #sudo add-apt-repository -y ppa:nilarimogard/webupd8 #(previously added)
    sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    sudo apt install -y caffeine-plus

# Install Netspeed Indicator (appears on system tray)
    #sudo add-apt-repository -y ppa:nilarimogard/webupd8 #(previously added)
    sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    sudo apt install -y indicator-netspeed

# Install Microsoft Visual Studio Code
	wget https://go.microsoft.com/fwlink/?LinkID=760868 -O visual_code.deb
	chmod +x visual_code.deb
	sudo dpkg -i visual_code.deb
    rm visual_code.deb

# Install MySQL Workbench
    sudo apt install -y mysql-workbench

# Install Steam (games)
    wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    sudo gdebi -n steam_latest.deb
    sudo apt-get install -f

# Install Indicator Keylock
	sudo add-apt-repository -y ppa:tsbarnes/indicator-keylock
	sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    sudo apt install -y indicator-keylock

# Install Pomodoro Timer for GNOME
    curl -L http://download.opensuse.org/repositories/home:kamilprusko/xUbuntu_16.04/Release.key | sudo apt-key add -
    sudo sh -c "echo 'deb http://download.opensuse.org/repositories/home:kamilprusko/xUbuntu_16.04/ /' >> /etc/apt/sources.list.d/gnome-pomodoro.list"
    sudo apt update
    sudo apt install gnome-pomodoro

# Install Paper Themes
	sudo add-apt-repository -y ppa:snwh/pulp
	sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
	sudo apt install -y paper-gtk-theme
    sudo apt install -y paper-icon-theme
    sudo apt install -y paper-cursor-theme

# Install Docky (a simple dock like Plank elementaryOS) / Optional to change later
	#sudo add-apt-repository -y ppa:docky-core/ppa
	#sudo add-apt-repository -y ppa:docky-core/stable
    sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    #sudo apt install -y docky

# Install Plank (dock like elementaryOS) / Optional to change later
    #sudo add-apt-repository -y ppa:ricotz/docky
    sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    #sudo apt install -y plank

# Install Elementary Tweaks (for Loki 0.4 and 0.4.1)
	sudo add-apt-repository -y ppa:philip.scott/elementary-tweaks
	sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    sudo apt install -y elementary-tweaks

# Install Dconf
    sudo apt install -y dconf-tools

# Install Flash Players (optional)
    sudo apt install -y flashplugin-installer #already comes installed
    sudo apt install -y pepperflashplugin-nonfree

# Message to user
    #clean screen
    clear
    #print blank lines
    printf "\n\n\n\n\n\n"
    #messages
    for (( i = 30; i <= 37; i++ )); 
        do echo -e "\e[0;"$i"m  The system will reboot in 10 seconds..."; 
    done
    #print blank lines
    printf "\n\n\n\n\n\n"
    #sleep for 10 secs
    sleep 10

# Reboot
    reboot
