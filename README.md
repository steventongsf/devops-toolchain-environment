# Overview
This project contains a completely integrated Devops toolset managed by Vagrant. It consists of several Virtual Machines which host the following services
* Jenkins
* Sonatype Nexus
* Sonarqube

In addition, this environment uses public instances of
* Slack
* Github

The rest of the document describes:
* Additional setup steps
* Runtime instructions
* Future To Dos


# Setup
Because this is a local environment, I am documenting the sensitive information so it can easily be recreated.  For shared environments such as in the cloud,  all these credentials should be kept in vaults such as those found in in AWS secrets manager.
## Setup Jenkins
Login: http://jenkins01:8080/login

### Install Suggested Plugins
### Install Plugins
* Install recommended plugins
Select addtional plugins
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
* Setup BUILD_TIMESTAMP format for versioning in Global Settings

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
  * sfhuskie-maven-group (group containing above repos)

## Setup Sonarqube
* Login: http://sonar01
* dfault: admin/admin123, new: admin/sonar
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

## Setup Slack
* Log in or create account in Slack
* Under the context of a team (create a team as needed, sfhuskie), create a channel (jenkins-cicd)
* Go to Apps and add "Jenkins CI"
  * Post to Channel -> jenkins-cicd and click Add
  * Copy Subdomain: sfhuskie
  * Copy Token: rSaUQzB7TeQ7nPfxRkUIpHt3
* Configure Slack in Jenkins with the subdomain and token
  * create Jenkins credential (slack-jenkins-cicd)
  * Configure Slack section in Settings




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
## Create repositories

# Runtime
## Sample project for running a pipeline
the following fork is from the Spring Boot reference project:
http://github.com/steventongsf/spring-petclinic
The master branch of this project will be used for the pipeline as stored in the project as Jenkinsfile.
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


# Jenkins Notes
wget http://localhost:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ install-plugin <name>
java -jar jenkins-cli.jar -s http://localhost:8080 -auth <username>:<password> install-plugin <plugin-1> <plugin-2>

# Vagrant notes
vagrant plugin install vagrant-vbguest


# TODOs
* Configure quality gates
* Publish artifacts to Nexus
* figure out how to install all the plugins from provisioning
* Setup terraforming in AWS
* work out autoinstalling guest extensions. see warning
```
 A Virtualbox Guest Additions installation was found but no tools to rebuild or start them.
 ```




