## Setup Jenkins
### Install Suggested Plugins
### Install Plugins
* Build timestamp
* Maven Integration
* Maven Integration Pipeline
* Nexus Artifact Loader
* Slack Notification

## Setup Nexus
* cat /opt/nexus/sonatype-work/nexus3/admin.password
* http://nexus01:8081/login
* Login admin
* Set password (nexus)
* create repos and repo group
  * sfhuskie-release
  * sfhuskie-snapshot
  * sfhuskie-maven-central
  * sfhuskie-maven-group

## Setup Sonarqube
* http://sonar01
* admin/admin

## Run local environment
Start 
```
vagrant up
```
Stop 
```
vagrant halt
```
Destroy 
```
vagrant destroy
```
Provision 
```
vagrant provision
```
SSH
```
vagrant ssh <Vagrant name>
```
