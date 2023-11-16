#!/bin/bash
sudo add-apt-repository ppa:openjdk-r/ppa
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
e>     /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update -y
#sudo apt-get install openjdk-11-jdk unzip -y 
sudo apt-get install openjdk-8-jdk unzip -y 
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
if [ -e /usr/bin/java ]; then
    sudo unlink /usr/bin/java
fi
ln -s $JAVA_HOME/bin/java /usr/bin/java
useradd nexus || true
mkdir -p /opt/nexus/   
mkdir -p /tmp/nexus/                           
NEXUSURL="https://download.sonatype.com/nexus/3/latest-unix.tar.gz"

#if [ ! -e /opt/nexus/default/bin/nexus ]; then
    cd /tmp/nexus
    wget $NEXUSURL -O nexus.tar.gz
    EXTOUT=`tar xzvf nexus.tar.gz`
    NEXUSDIR=`echo $EXTOUT | cut -d '/' -f1`
    rm -rf /tmp/nexus/nexus.tar.gz
    rsync -avzh /tmp/nexus/ /opt/nexus/
    chown -R nexus:nexus /opt/nexus 
    ln -s /opt/nexus/$NEXUSDIR /opt/nexus/default
    ln -s $JAVA_HOME/jre /opt/nexus/$NEXUSDIR/jre
#fi

cat <<EOT> /etc/systemd/system/nexus.service
[Unit]                                                                          
Description=nexus service                                                       
After=network.target                                                            
                                                                  
[Service]                                                                       
Type=forking                                                                    
LimitNOFILE=65536                                                               
ExecStart=/opt/nexus/$NEXUSDIR/bin/nexus start                                  
ExecStop=/opt/nexus/$NEXUSDIR/bin/nexus stop                                    
User=nexus                                                                      
Restart=on-abort                                                                
                                                                  
[Install]                                                                       
WantedBy=multi-user.target                                                      

EOT

echo 'run_as_user="nexus"' > /opt/nexus/$NEXUSDIR/bin/nexus.rc
#echo 'install4j.jvmDir=/usr/lib/jvm/java-8-openjdk-amd64' >> /opt/nexus/$NEXUSDIR/bin/nexus.rc
systemctl daemon-reload
systemctl start nexus
systemctl enable nexus
