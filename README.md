# nomad playground

see what you can do with this toy

`make ensureif cluster` will bootstrap everything

`make` downloads dependencies, builds the demo consumer and `vagrant up`s

if you need reprovisioning of vms then `vagrant provision`

alt+f4 does a super neat trick try that out

## vbox network requirements

`make ensureif`

when using virtualbox as a vagrant provider you need to be sure that you have a `host-only` network configured with the required ip range for the static IPs specified in the vagrantfile. I have one with the following settings:
- IP: `172.28.128.1`
- mask: `255.255.255.0`

use the `make ensureif` target (not run by default), or you can add one from *file > preferences > network > host-only* if you prefer clicky-clicking through vbox's ui

## initializing the git repos

`make deps` will take care of generating an ssh keypair for gitea if you don't want to use your own but not much more on the space of initializing the repos.

you will need to:
- create a user called `demo`
- assign it your ssh key (or the one in deps)
- create a repo called `demoservice` (and `anotherdemoservice`)
- in the demo.service(s) folder(s):
```
git init
git remote add origin git@gitea@172.28.128.41:demo/demoservice.git # adapt for anotherdemoservice
git add .
git ci -m'somemessage'
git push -u origin master
```

note that you can commit the files in the "inner" repos freely without altering the "parent" repository, so feel free to modify the demo services as you please and push to the local gitea liberally.

note that some of this (if not all) can easily be automated, I just gave priority to looking at other stuff instead. (gitea can be used as a cli tool as well as running the server and can totally do some stuff like the user creation)