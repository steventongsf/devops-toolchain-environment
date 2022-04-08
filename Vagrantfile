Vagrant.configure("2") do |config|
    config.hostmanager.enabled = true 
    config.hostmanager.manage_host = true
    config.vm.define "jenkins" do |jenkins|
        jenkins.vm.box = "ubuntu/focal64"
        jenkins.vm.hostname = "jenkins01"
        jenkins.vm.network "private_network", ip: "192.168.56.15"
        jenkins.vm.provision "shell", path: "jenkins.sh"  
        jenkins.vm.provider "virtualbox" do |vb|
            vb.cpus = 2
            vb.memory = "2048"
        end
    end
    config.vm.define "nexus" do |nexus|
        nexus.vm.box = "centos/7"
        nexus.vm.hostname = "nexus01"
        nexus.vm.network "private_network", ip: "192.168.56.14"
        nexus.vm.provision "shell", path: "nexus.sh"  
        nexus.vm.provider "virtualbox" do |vb|
            vb.cpus = 2
            vb.memory = "2048"
        end    
    end
    config.vm.define "sonar" do |sonar|
        sonar.vm.box = "ubuntu/focal64"
        sonar.vm.hostname = "sonar01"
        sonar.vm.network "private_network", ip: "192.168.56.16"
        sonar.vm.provision "shell", path: "sonar.sh"  
        sonar.vm.provider "virtualbox" do |vb|
            vb.cpus = 2
            vb.memory = "4096"
      end    
    end   
end
  