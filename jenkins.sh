sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt-get update
#sudo apt-get install openjdk-8-jdk -y 
sudo apt-get install openjdk-11-jdk -y 
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
sudo apt-get install maven -y 
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
e>     /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins -y 