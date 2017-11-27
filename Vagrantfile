Vagrant.configure("2") do |config|
  config.vm.box = "centos/7"

  config.vm.provider "virtualbox" do |v|
    v.memory = 512
    v.cpus = 1
  end
  
  addresses = {
    "apps01" => "172.28.128.21",
    "apps02" => "172.28.128.22",
    "apps03" => "172.28.128.23",
    "infra01" => "172.28.128.31",
    "infra02" => "172.28.128.32",
    "infra03" => "172.28.128.33",
    "controller01" => "172.28.128.41"
  }

 config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "playbook.yml"
    ansible.groups = {
      "apps" => ["apps0[1:3]"],
      "infra" => ["infra0[1:3]"],
      "controller" => ["controller01"],
      "all" => ["apps0[1:3]", "infra0[1:3]", "controller01"]
    }
    ansible.host_vars = {}
    addresses.each do | host, address |
      ansible.host_vars[host] = { "address" => address }
    end
  end

  config.vm.define "apps01" do |apps01|
    apps01.vm.network "private_network", ip: "172.28.128.21"
    # apps01.vm.provision "shell", inline: "sed -i 's/0.0.0.0/172.28.128.21/g' /etc/consul.d/conf.json"
    # apps01.vm.provision "shell", inline: "systemctl restart consul.service"
    apps01.vm.provision "shell", inline: "sed -i 's/address_here/172.28.128.21/g' /etc/nomad.hcl"
    apps01.vm.provision "shell", inline: "systemctl restart nomad.service"
  end

  config.vm.define "apps02" do |apps02|
    apps02.vm.network "private_network", ip: "172.28.128.22"
    # apps02.vm.provision "shell", inline: "sed -i 's/0.0.0.0/172.28.128.22/g' /etc/consul.d/conf.json"
    # apps02.vm.provision "shell", inline: "systemctl restart consul.service"
    apps02.vm.provision "shell", inline: "sed -i 's/address_here/172.28.128.22/g' /etc/nomad.hcl"
    apps02.vm.provision "shell", inline: "systemctl restart nomad.service"
  end
 
  config.vm.define "apps03" do |apps03|
    apps03.vm.network "private_network", ip: "172.28.128.23"
    # apps03.vm.provision "shell", inline: "sed -i 's/0.0.0.0/172.28.128.23/g' /etc/consul.d/conf.json"
    # apps03.vm.provision "shell", inline: "systemctl restart consul.service"
    apps03.vm.provision "shell", inline: "sed -i 's/address_here/172.28.128.23/g' /etc/nomad.hcl"
    apps03.vm.provision "shell", inline: "systemctl restart nomad.service"
  end

  config.vm.define "infra01" do |infra01|
    infra01.vm.network "private_network", ip: "172.28.128.31"
    infra01.vm.provision "shell", inline: "sed -i 's/0.0.0.0/172.28.128.31/g' /etc/consul.d/conf.json"
    infra01.vm.provision "shell", inline: "systemctl restart consul.service"
  end

  config.vm.define "infra02" do |infra02|
    infra02.vm.network "private_network", ip: "172.28.128.32"
    infra02.vm.provision "shell", inline: "sed -i 's/0.0.0.0/172.28.128.32/g' /etc/consul.d/conf.json"
    infra02.vm.provision "shell", inline: "systemctl restart consul.service"
  end

  config.vm.define "infra03" do |infra03|
    infra03.vm.network "private_network", ip: "172.28.128.33"
    infra03.vm.provision "shell", inline: "sed -i 's/0.0.0.0/172.28.128.33/g' /etc/consul.d/conf.json"
    infra03.vm.provision "shell", inline: "systemctl restart consul.service"
    infra03.vm.provision "shell", inline: "mongo --eval 'rs.status().ok || rs.initiate({_id:\"infra\",members:[{_id:0,host:\"172.28.128.31\"},{_id:1,host:\"172.28.128.32\"},{_id:2,host:\"172.28.128.33\"}]})'" # this goes on only one node
  end

  config.vm.define "controller01" do |controller01|
    controller01.vm.network "private_network", ip: "172.28.128.41"
  end

end
