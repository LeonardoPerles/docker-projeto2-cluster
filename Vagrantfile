# -*- mode: ruby -*-
# vi: set ft=ruby  :

machines = {
  "master" => {"memory" => "1024", "cpu" => "1", "ip" => "100", "image" => "bento/ubuntu-22.04"},
  "no01" => {"memory" => "1024", "cpu" => "1", "ip" => "101", "image" => "bento/ubuntu-22.04"}
#  "no02" => {"memory" => "1024", "cpu" => "1", "ip" => "102", "image" => "bento/ubuntu-22.04"},
#  "no03" => {"memory" => "1024", "cpu" => "1", "ip" => "103", "image" => "bento/ubuntu-22.04"}
}

Vagrant.configure("2") do |config|

  machines.each do |name, conf|
    config.vm.define "#{name}" do |machine|
      machine.vm.box = "#{conf["image"]}"
      machine.vm.hostname = "#{name}"
      machine.vm.network "private_network", ip: "10.10.10.#{conf["ip"]}"
      machine.vm.provider "virtualbox" do |vb|
        vb.name = "#{name}"
        vb.memory = conf["memory"]
        vb.cpus = conf["cpu"]
        
      end
      # Adiciona sincronização de pastas entre o Host e a Virtual Machine
      # Nesse caso a pasta /docker está sendo compartilhada 
      machine.vm.synced_folder "docker/", "/vagrant/docker", type: "virtualbox"

      # Executa um script para instalar o docker em todas as maquinas virtuais
      machine.vm.provision "shell", path: "docker/docker.sh"

      # Chama o script de provisionamento Docker/ Configura um container do tipo Mysql
      machine.vm.provision "shell", path: "scripts/mysql_docker.sh"

      # Configura um container do tipo phpMyAdmin para visualização facil do banco em funcionamento
      machine.vm.provision "shell", path: "scripts/phpmyadmin_docker.sh"
      
# Inicializa um cluster swarm com a maquina virtual Master como "mestre" 
# e gera um arquivo worker.sh com o token para inicializar os "workers"
      if "#{name}" == "master" 
        machine.vm.provision "shell", path: "scripts/master.sh"
      else
        machine.vm.provision "shell", path: "scripts/worker.sh"
      end
    end
  end
end
