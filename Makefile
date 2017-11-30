CONSUL_V := 1.0.1
NOMAD_V := 0.7.0
GITEA_V := 1.3

.PHONY: all clean clean-deps cluster deps provision

all: deps cluster

cluster:
	vagrant up

provision:
	vagrant provision

deps/consul_$(CONSUL_V)_linux_amd64.zip:
	wget https://releases.hashicorp.com/consul/$(CONSUL_V)/consul_$(CONSUL_V)_linux_amd64.zip -P deps

deps/consul: deps/consul_$(CONSUL_V)_linux_amd64.zip
	unzip $< -d deps
	touch $@ # hack b/c extracting the file maintains the original timestamp and counts as ood, there is probably a more elegant solution but who remembers

deps/nomad_$(NOMAD_V)_linux_amd64.zip:
	wget https://releases.hashicorp.com/nomad/$(NOMAD_V)/nomad_$(NOMAD_V)_linux_amd64.zip -P deps

deps/nomad: deps/nomad_$(NOMAD_V)_linux_amd64.zip
	unzip $< -d deps
	touch $@ # hack b/c extracting the file maintains the original timestamp and counts as ood, there is probably a more elegant solution but who remembers

deps/gitea-$(GITEA_V)-linux-amd64:
	wget https://dl.gitea.io/gitea/$(GITEA_V)/gitea-$(GITEA_V)-linux-amd64 -P deps

deps/lein:
	wget https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein -P deps

deps/id_rsa:
	ssh-keygen -N "" -C "demo@localgitea" -f $@

deps: deps/consul deps/nomad deps/gitea-1.3-linux-amd64 deps/lein deps/id_rsa

ensureif:
	vboxmanage list hostonlyifs | egrep 'IP|Mask' | grep -v V6 | tr -s ' ' | cut -d ' ' -f2 |  xargs -n2 ipcalc -b | grep Network | tr -s ' ' | cut -d' ' -f2 | grep $$(vboxmanage list hostonlyifs | egrep 'Mask' | grep -v V6 | tr -s ' ' | cut -d ' ' -f2 |  xargs  ipcalc -b 172.28.128.11 | grep Network | tr -s ' ' | cut -d' ' -f2) || vboxmanage hostonlyif ipconfig $$(vboxmanage hostonlyif create | grep Interface | cut -d' ' -f2 | tr -d "'") --ip 172.28.128.1

clean:
	vagrant destroy -f

clean-deps:
	rm deps/*
