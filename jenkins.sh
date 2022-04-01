sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
sudo apt-get install openjdk-11-jdk unzip -y 
sudo apt-get install openjdk-17-jdk -y 
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
if [ -e /usr/bin/java ]; then
    sudo unlink /usr/bin/java
fi
ln -s $JAVA_HOME/bin/java /usr/bin/java
if [ -e apache-maven-3.8.7-bin.zip ]; then
    rm -vf apache-maven-3.8.7-bin.zip
fi
cd /tmp
wget https://dlcdn.apache.org/maven/maven-3/3.8.7/binaries/apache-maven-3.8.7-bin.zip
cd /usr/share; sudo unzip /tmp/apache-maven-3.8.7-bin.zip
if [ -e /usr/bin/mvn ]; then
    sudo unlink /usr/bin/mvn
fi
sudo ln -s /usr/share/apache-maven-3.8.7/bin/mvn /usr/bin/mvn

wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
e>     /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins -y 