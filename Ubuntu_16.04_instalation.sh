#!/bin/bash
shopt -s expand_aliases

printf '\n--- aktualizacja (nie opdnosi wersji distro) ----\n'
apt-get update
apt-get upgrade -y
apt-get autoremove -y
apt-get autoclean -y

printf '\n--- Instalacja synaptic smplayer byobu curl gparted ----\n'
apt-get install -y synaptic smplayer byobu curl gparted

#
# VirtualBoc
printf '\n--- Instalacja VirtualBox ----\n'
apt-get install -y virtualbox virtualbox-ext-pack

#
# Git
printf '\n--- Instalacja Git ----\n'
apt-get install -y git
echo "Wpisz nazwę użytkownika w git"
read GIT_NAME
git config --global user.name "$GIT_NAME"
echo "Wpisz maila użytkownika w git"
read GIT_EMAIL
git config --global user.email "$GIT_EMAIL"
printf "\n# Show git branch name\nforce_color_prompt=yes\ncolor_prompt=yes\nparse_git_branch()\n{\n\tgit branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \\(.\*\\)/(\\\1)/'\n}\nif [ \"\$color_prompt\" = yes ]; then\n\tPS1='\${debian_chroot:+(\$debian_chroot)}\\[\\\033[01;32m\\]\\u@\\h\\[\\\033[00m\\]:\\[\\\033[01;34m\\]\\w\\[\\\033[01;31m\\]\$(parse_git_branch)\\[\\\033[00m\\]\\$'\nelse\n\tPS1='\${debian_chroot:+(\$debian_chroot)}\\u@\\h:\\w\$(parse_git_branch)\\\$'\nfi\nunset color_prompt force_color_prompt" >> ~/.bashrc

#
# Chrome Stable
printf '\n--- Instalacja Google-Chrome-Stable ----\n'
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - 
sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
apt-get update 
apt-get install -y google-chrome-stable

#
# Opera Stable
printf '\n--- Instalacja Opera-Stable ----\n'
wget -O - http://deb.opera.com/archive.key | apt-key add -
sh -c 'echo "deb http://deb.opera.com/opera-stable/ stable non-free" >> /etc/apt/sources.list.d/opera.list' 
add-apt update 
add-apt install -y opera-stable

#
# Vivaldi Stable
printf '\n--- Instalacja Vivaldi ----\n'
echo "echo deb http://repo.vivaldi.com/stable/deb/ stable main > /etc/apt/sources.list.d/vivaldi.list" | sh
curl http://repo.vivaldi.com/stable/linux_signing_key.pub | apt-key add -
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 1397BC53640DB551
apt-get update
apt-get install -y vivaldi-stable

#
# StickyNotes
printf '\n--- Instalacja StickyNotes ----\n'
add-apt-repository ppa:umang/indicator-stickynotes
apt-get update
apt-get install -y indicator-stickynotes

#
# NodeJS NPM
printf '\n--- Instalacja NodeJS NPM ----\n'
curl -sL https://deb.nodesource.com/setup | sudo -E bash -
apt-get install -y nodejs npm

#
# youtube-dl
printf '\n--- Instalacja youtube-dl ----\n'
sudo add-apt-repository ppa:nilarimogard/webupd8
sudo apt-get update
sudo apt-get install youtube-dl

#
# postgres 9.5 pgAdmin III
printf '\n--- instalacja pgAdmin III ----\n'
#wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
#apt-get update
apt-get install -y postgresql-9.5 
apt-get install -y pgadmin3


#todoist
TODOIST=todoist-linux-64bits.tar.gz
#git clone https://github.com/kamhix/todoist-linux.git /opt/Todoist/
wget https://s3.amazonaws.com/kamhix/downloads/$TODOIST
mkdir /opt/Todoist
tar -xzf $TODOIST -C /opt/Todoist/
rm $TODOIST
/opt/Todoist/64/Todoist 

#
# SQLectron
printf '\n--- instalacja SQLectron ----\n'
wget -O sqlectron.deb https://github.com/sqlectron/sqlectron-gui/releases/download/v1.29.0/Sqlectron_1.29.0_amd64.deb
sudo dpkg -i sqlectron.deb
rm sqlectron.deb    

#
# VS Code
printf '\n--- instalacja VS Code ----\n'
wget -O vscode-amd64.deb https://go.microsoft.com/fwlink/?LinkID=760868
sudo dpkg -i vscode-amd64.deb
rm vscode-amd64.deb

#
#Java 9.0.4
printf '\n--- instalacja javy 9.0.4 ----\n'
wget --no-cookies --no-check-certificate --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/9.0.4+11/c2514751926b4512b076cc82f959763f/jdk-9.0.4_linux-x64_bin.tar.gz -O jdk-9_linux-x64_bin.tar.gz
tar -xzf jdk-9_linux-x64_bin.tar.gz -C /opt/
update-alternatives --install /usr/bin/javac javac /opt/jdk-9.0.4/bin/javac 1000
update-alternatives --install /usr/bin/javadoc javadoc /opt/jdk-9.0.4/bin/javadoc 1000
update-alternatives --install /usr/bin/javap javap /opt/jdk-9.0.4/bin/javap 1000
export JAVA_HOME=/opt/jdk-9.0.4
export PATH=$PATH:$JAVA_HOME/bin

#add-apt-repository ppa:webupd8team/java
#echo "oracle-java9-installer shared/accepted-oracle-license-v1-1 select true" | debconf-set-update
#apt install -y oracle-java9-installer
#echo '#!/bin/bash\n JAVA_HOME=/usr/java/jdk9\nPATH=${PATH}:${JAVA_HOME}/bin:$PATH' > /etc/profile.d/java9.sh
#source /etc/profile.d/java.sh

#
#Maven
printf '\n--- instalacja maven ----\n'
wget http://www-eu.apache.org/dist/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
tar xzf apache-maven-3.5.2-bin.tar.gz -C /opt/
ln -s /opt/apache-maven-3.5.2/bin/mvn /usr/bin/mvn
echo '#!/bin/bash\nMAVEN_HOME=/opt/apache-maven-3.5.2\nPATH=$MAVEN_HOME/bin:$PATH\nexport PATH MAVEN_HOME\nexport CLASSPATH=.' > /etc/profile.d/apache-maven.sh
source /etc/profile.d/apache-maven.sh

#
#InteliJ
printf '\n--- instalacja intelij ----\n'
# Fetch the most recent version
echo "Którą wersję zainstalować inteliJ? wpisać np: 2017.3.3"
read VERS
if [ -z "$VERS" ]
then
      VERS=2017.3.3
fi
wget https://download.jetbrains.com/idea/ideaIU-$VERS.tar.gz
tar -xzf ideaIU-$VERS.tar.gz -C /opt/
rm ideaIU-$VERS.tar.gz
mv "/opt/idea-I*" /opt/Idea-IU-$VERS
DIR="/opt/Idea-IU-$VERS"
chmod -R +rwx ${DIR}
BIN="$DIR/bin"
#DESK=/usr/share/applications/IDEA.desktop
#printf "[Desktop Entry]\nEncoding=UTF-8\nName=IntelliJ IDEA\nComment=IntelliJ IDEA\nExec=${BIN}/idea.sh\nIcon=${BIN}/idea.png\nTerminal=false\nStartupNotify=true\nType=Application" -e > ${DESK}
#ln -s ${BIN}/idea.sh /usr/local/bin/idea
$BIN/idea.sh

printf '\n--- instalacja sprzątanie ----\n'
apt-get update
apt-get upgrade -y
apt-get autoremove -y
apt-get autoclean -y

exit 0
