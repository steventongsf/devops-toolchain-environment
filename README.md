# Overview
Continuous integration environment using multiple local VMs to support:
* Jenkins
* Sonatype Nexus
* Sonarqube
# Setup
## Setup Jenkins
Login: http://jenkins01:8080/login

### Install Suggested Plugins
### Install Plugins
* Build timestamp
* Maven Integration
* Maven Integration Pipeline
* Nexus Artifact Loader
* Slack Notification
### Setup webhook
Ensure there is a public address for github to push notifications to.  If this is running locally and you do not have a public IP, you cannot do this.  If you do have a public address, you will need to run a proxy to this private network on your local VMs.  To setup a web hook:
* Go to Github settings for the project
* Go to Webhooks and click Add Webhook
* Enter 
  * payload URL: http://PUBLIC_IP:8080/github-webhook/
  * Content type: application/json
  * Select "Just the push event"
  * click "Update webhook"
### Configure Sonarqube
* In Global tools, configure the Sonarqube scanner
* In Global configurations, configure the Sonarqube server
  * Generate a token in Sonarqube and store in jenkins credentials
  * In sonarqube configuration, set the credentials to use


## Setup Nexus
* cat /opt/nexus/sonatype-work/nexus3/admin.password
* Login: http://nexus01:8081/login
* Login admin
* Set password (nexus)
* create repos and repo group
  * sfhuskie-release
  * sfhuskie-snapshot
  * sfhuskie-maven-central
  * sfhuskie-maven-group

## Setup Sonarqube
* Login: http://sonar01
* admin/admin123
* Go to sonarqube user settings
* Select security
* generate token: sqa_03184c0e3f41f75184c0fd1fbbc5ad8312177496
* add token to Jenkins credentials
* configure Jenkins Sonarqube section to use token
* Setup webhook for Jenkins
  * Project Settings -> Webhooks -> Create
  * Url: http://jenkins01:8080/sonarqube-webhook
* Test pipeline
  * default quality gates should be successful
  * add quality gate (in Sonarqube server) to have >= 95% coverage.  Running pipeline should fail now


## Setup SSH Access to Github
Generate key pair
```
ssh-keygen -t rsa
```
Add public key to you're account on Github
Test key
```
ssh -T git@github.com
```

# Runtime
## Sample project for running a pipeline
the following fork is from the Spring Boot reference project:
http://github.com/steventongsf/spring-petclinic
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


# Notes
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ install-plugin <name>
java -jar jenkins-cli.jar -s http://localhost:8080 -auth <username>:<password> install-plugin <plugin-1> <plugin-2>

# TODOs
* Configure quality gates
* Publish artifacts to Nexus
* Create Vagrant images
* Rename this project folder to match github repo
* figure out how to install all the plugins from provisioning
* Setup terraforming in AWS



