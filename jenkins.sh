sudo add-apt-repository ppa:openjdk-r/ppa
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
e>     /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
#sudo apt-get install openjdk-11-jdk unzip -y 
sudo apt-get install openjdk-17-jdk unzip -y 
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
if [ -e /usr/bin/java ]; then
    sudo unlink /usr/bin/java
fi
ln -s $JAVA_HOME/bin/java /usr/bin/java
MAVEN_VERSION=3.9.5
MAVEN_NAME=apache-maven-$MAVEN_VERSION
MAVEN_ZIP=$MAVEN_NAME-bin.zip
if [ -e $MAVEN_ZIP ]; then
    rm -vf $MAVEN_ZIP
    rm -vf $MAVEN_ZIP.*
fi
if [ ! -e /usr/share/$MAVEN_NAME/bin/mvn ]; then
    cd /tmp
    wget https://dlcdn.apache.org/maven/maven-3/$MAVEN_VERSION/binaries/$MAVEN_ZIP
    cd /usr/share; sudo unzip /tmp/$MAVEN_ZIP

    sudo ln -f -s /usr/share/$MAVEN_NAME/bin/mvn /usr/bin/mvn
fi

sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
 https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
 https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
 /etc/apt/sources.list.d/jenkins.list > /dev/null

sudo apt-get update -y 
sudo apt-get install jenkins -y 
#sleep 60
#cd ~
#if [ ! -e jenkins-cli.jar ]; then
#    wget http://localhost:8080/jnlpJars/jenkins-cli.jar
#fi
#java -jar ./jenkins-cli.jar -s http://127.0.0.1:8080/ install-plugin <name>