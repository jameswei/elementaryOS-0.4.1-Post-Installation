#!/bin/bash

#
#   Created on June 2017
#   Updated on Jan 2018
#   PostInstallation for elementaryOS Loki 0.4.0 or 0.4.1
#   Written by Bruno Raphael C de Mesquita - Aracaju/SE - Brazil
#

# Enable firewall
    sudo ufw default DENY
    sudo ufw enable

# Update distro
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y; sudo apt install -f -y

    sudo apt update -y
    sudo apt dist-upgrade -y
    sudo apt autoremove -y; sudo apt install -f -y

# Install Ubuntu Extras
    # Auto accept Eula
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
    sudo apt install -y ubuntu-restricted-addons ubuntu-restricted-extras

# Enable PPA on elementaryOS with
    sudo apt install -y software-properties-common

# Install Git (If you have not yet installed)
    sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y git git-core

# Install Git-Cola (Lightweight Git GUI)
    sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y git-cola

# Install GitKraken (Git GUI Freemium)
    cd /tmp
    sudo apt autoremove -y; sudo apt install -f -y
    # For 64 bit
    wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
    sudo dpkg -i gitkraken-amd64.deb

# Install Compilers (for C and C++ programmers)
    sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y cpp g++ gcc gpp clang

# Install Code::Blocks (C/C++ IDE)
    sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y codeblocks

# Install C# & .NET compilers (For C# & .NET Programmers)
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt-get install -y dotnet-sdk-2.0.2

# Install Microsoft Visual Studio Code (w/ repository)
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
    sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y code

# Install MySQL Workbench
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y mysql-workbench

# Install Lazarus (Delphi open source alternative)
    sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y fpc fpc-source
    sudo apt install -y lazarus

# Install LAMPP Stack (Linux + Apache + MySQL/MariaDB + PHP)
    sudo apt autoremove -y; sudo apt install -f -y

    # Apache 2 (HTTP Server)
    sudo apt install -y apache2 apache2-utils
    sudo chown www-data:www-data /var/www/html/ -R
    #sudo systemctl start apache2 # Start once
    #sudo systemctl enable apache2 # Start on boot

    # MySQL/MariaDB (Database Server)
    sudo apt install -y mariadb-server mariadb-client
    #sudo apt install -y mysql-server mysql-client

    #sudo systemctl start mariadb # Start once
    #sudo systemctl enable mariadb # Start on boot
    # or
    #sudo systemctl start mysql # Start once
    #sudo systemctl enable mysql # Start on boot

    #sudo mysql_secure_installation # Let's to final

    # PHP 7.1
    sudo apt install -y php7.1 libapache2-mod-php7.1 php7.1-mysql php-common php7.1-cli php7.1-common php7.1-json php7.1-opcache php7.1-readline
    a2enmod ssl
    a2ensite default-ssl

    # Restart Apache
    sudo systemctl restart apache2

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
    #sudo prelink -amvR
    # To speed up this installation, let's leave it to the end.

# Install dependencies, libraries, plugins (some is optional)
    #sudo add-apt-repository -y ppa:kirillshkrogalev/ffmpeg-next # FFMPEG Repository
    sudo apt install -y ffmpeg lame # plugins for OBS, Audacity and others. They are optional.
    sudo apt install -y curl # enable installations via curl (sometimes it comes installed).
    sudo apt install -y cups # install a printer server (sometimes it comes installed).
    sudo apt install -y libcurl3 libnss3-tools # for access internet banking, like Caixa Econômica Federal (Brazil).

# Install Gparted (partition manager)
    #sudo apt install -y gparted gpart

# Install P7ZIP (file compressor)
    sudo apt install -y p7zip-full # sometimes it comes installed.

# Install Oracle Java With PPA (JRE + JDK)
    sudo add-apt-repository -y ppa:webupd8team/java
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections # EULA Auto accept
    sudo apt install -y oracle-java8-installer
    #sudo apt install -y oracle-java9-installer #not recommended

# Install Google Chrome
    wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
    sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y google-chrome-stable

# Install Firefox
    sudo apt install -y firefox

# Install Thunderbird
    sudo apt install -y thunderbird

# Spotify (client)
    # 1. Add the Spotify repository signing key to be able to verify downloaded packages
    #sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
    # 2. Add the Spotify repository
    #echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
    # 3. Update list of available packages
    #sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    # 4. Install Spotify
    #sudo apt install -y spotify-client

# Install Rhythmbox (media player and podcast player)
    #sudo apt install -y rhythmbox rhythmbox-mozilla

# Install VLC (media player)
    sudo apt install -y vlc vlc-plugin-vlsub vlc-plugin-notify browser-plugin-vlc

# Install Audacity (audio editor)
    #sudo add-apt-repository -y ppa:audacity-team/daily
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y audacity

# Install Kdenlive (video editor)
    #sudo add-apt-repository -y ppa:sunab/kdenlive-release
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y kdenlive

# OpenShot (Editor de Vídeo)
    sudo add-apt-repository -y ppa:openshot.developers/ppa
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y openshot openshot-doc frei0r-plugins

# OBS - Open Broadcaster Studio (Screncast & Screen Recorder)
    sudo add-apt-repository -y ppa:obsproject/obs-studio
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y obs-studio

# Install Kazam (Screencast and Screen Recorder) / Optional
    #sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    #sudo apt install -y kazam

# Install Gaupol (Subtitle editor)
    sudo apt install -y gaupol

# Install Gimp (Photoshop open source alternative )
    #sudo add-apt-repository -y ppa:otto-kesselgulasch/gimp
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y gimp gmic gimp-data gimp-data-extras gimp-gmic gimp-plugin-registry gimp-ufraw gnome-xcf-thumbnailer

# Install Inkscape (Open source vector editor like/alternative Corel and Illustrator)
    #sudo add-apt-repository -y ppa:inkscape.dev/stable
    sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    sudo apt install -y inkscape

# Install DIA (diagrams)
    #sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    #sudo apt install -y dia

# Install Planner (Project manager like MS Project)
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y planner

# Install LibreOffice
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y libreoffice libreoffice-style-sifr
    sudo apt install -y libreoffice-l10n-br # Install Brazilian Portuguese language support

# Install qBitTorrent (bittorrent client)
    #sudo add-apt-repository -y ppa:qbittorrent-team/qbittorrent-stable
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y qbittorrent

# Install YouTube Downloader (w/ graphical interface)
    sudo add-apt-repository -y ppa:nilarimogard/webupd8
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt-get install -y youtube-dl youtube-dlg

# Install Caffeine Plus (Shown in system tray)
    #sudo add-apt-repository -y ppa:nilarimogard/webupd8 # it is not necessary. Added above.
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y caffeine-plus

# Install Netspeed Indicator (Shown in system tray)
    #sudo add-apt-repository -y ppa:nilarimogard/webupd8 #(previously added)
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y indicator-netspeed

# Install Steam (games)
    cd /tmp
    wget http://repo.steampowered.com/steam/archive/precise/steam_latest.deb
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo dpkg -i steam_latest.deb

# Install Indicator Keylock (Shown "Num Lock" and "Caps Lock" activities in system tray)
    sudo add-apt-repository -y ppa:tsbarnes/indicator-keylock
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y indicator-keylock

# Install Paper Themes (Window, Icon and Mouse Cursor)
    sudo add-apt-repository -y ppa:snwh/pulp
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    #sudo apt install -y paper-gtk-theme
    sudo apt install -y paper-icon-theme
    sudo apt install -y paper-cursor-theme

# Install Docky (a simple dock like Plank elementaryOS) / Optional.
    #sudo add-apt-repository -y ppa:docky-core/ppa
    #sudo add-apt-repository -y ppa:docky-core/stable
    #sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    #sudo apt install -y docky

# Install Plank (dock like elementaryOS) / Optional, because it comes installed.
    #sudo add-apt-repository -y ppa:ricotz/docky
    #sudo apt update;sudo apt autoremove -y;sudo apt install -f -y
    #sudo apt install -y plank

# Install Elementary Tweaks (for Loki 0.4 and 0.4.1)
    sudo add-apt-repository -y ppa:philip.scott/elementary-tweaks
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y elementary-tweaks

# Install Dconf
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y dconf-tools

# DupeGuru
    sudo apt-add-repository -y ppa:hsoft/ppa
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y dupeguru-se

# Install Wine
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y wine wine-gecko winetricks playonlinux dosbox

# Install Flash Players (optional)
    sudo apt update; sudo apt autoremove -y; sudo apt install -f -y
    sudo apt install -y flashplugin-installer #already comes installed
    sudo apt install -y pepperflashplugin-nonfree

# Prelink ("remember?")
    sudo prelink -amvR

# Install MS VS Code Extensions
    # Exit sudo
    exit

    # Install Extensions
    code --install-extension 2gua.rainbow-brackets
    code --install-extension abusaidm.html-snippets
    code --install-extension christian-kohler.path-intellisense
    code --install-extension cssho.vscode-svgviewer
    code --install-extension dbaeumer.vscode-eslint
    code --install-extension dbankier.vscode-instant-markdown
    code --install-extension deerawan.vscode-faker
    code --install-extension donjayamanne.githistory
    code --install-extension eamodio.gitlens
    code --install-extension ecmel.vscode-html-css
    code --install-extension eg2.tslint
    code --install-extension felixfbecker.php-intellisense
    code --install-extension formulahendry.auto-close-tag
    code --install-extension formulahendry.code-runner
    code --install-extension HookyQR.beautify
    code --install-extension joelday.docthis
    code --install-extension KnisterPeter.vscode-github
    code --install-extension lonefy.vscode-JS-CSS-HTML-formatter
    code --install-extension ms-vscode.csharp
    code --install-extension msjsdiag.debugger-for-chrome
    code --install-extension pranaygp.vscode-css-peek
    code --install-extension robinbentley.sass-indented
    code --install-extension Shan.code-settings-sync
    code --install-extension shardulm94.trailing-spaces
    code --install-extension shinnn.stylelint
    code --install-extension sidthesloth.html5-boilerplate
    code --install-extension techer.open-in-browser
    code --install-extension waderyan.gitblame
    code --install-extension wayou.vscode-todo-highlight
    code --install-extension whtsky.agila-theme
    code --install-extension Zignd.html-css-class-completion

# MySQL Secure ("Remember too?!")
    mysql_secure_installation
    # On questions...
    # 1. Press [Enter]
    # 2. Enter Y to set a new password
    # 3. Press [Enter]
    # 4. Press [Enter]
    # 5. Press [Enter]
    # 6. Press [Enter]

# Message to user
    # clean screen
    clear

    # print end message to user
    for (( i = 30; i <= 37; i+=2 ));
    	do echo -e "\e[0;"$i"m \n\n Post-installation complete! You can restart your computer now! \n\n";
    done