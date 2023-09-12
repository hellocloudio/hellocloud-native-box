cd $HOME

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0

####################################

# Update .bashrc / or .bash_profile as below to add
. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

####################################
vagrant@gcloud-cli-box:~$ vi .bashrc
vagrant@gcloud-cli-box:~$ cat .bashrc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/vagrant/google-cloud-sdk/path.bash.inc' ]; then . '/home/vagrant/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/vagrant/google-cloud-sdk/completion.bash.inc' ]; then . '/home/vagrant/google-cloud-sdk/completion.bash.inc'; fi

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

####################################
vagrant@gcloud-cli-box:~$ source .bashrc
vagrant@gcloud-cli-box:~$ asdf version
v0.10.2-7e7a1fa
vagrant@gcloud-cli-box:~$ asdf --help
version: v0.10.2-7e7a1fa

#
vagrant@gcloud-cli-box:~$ asdf plugin-add istioctl https://github.com/virtualstaticvoid/asdf-istioctl.git

vagrant@gcloud-cli-box:~$ asdf list
istioctl
  No versions installed

Click here to check istio releases and download the istioctl version you want.
https://github.com/istio/istio/tags

vagrant@gcloud-cli-box:~$ asdf install istioctl 1.13.5
Downloading istioctl from https://github.com/istio/istio/releases/download/1.13.5/istio-1.13.5-linux-amd64.tar.gz

vagrant@gcloud-cli-box:~$ asdf list
istioctl
  1.13.5

vagrant@gcloud-cli-box:~$ asdf install istioctl 1.14.3
Downloading istioctl from https://github.com/istio/istio/releases/download/1.14.3/istio-1.14.3-linux-amd64.tar.gz
vagrant@gcloud-cli-box:~$ asdf list
istioctl
  1.13.5
  1.14.3

vagrant@gcloud-cli-box:~$ asdf global istioctl 1.13.5

vagrant@gcloud-cli-box:~$ istioctl version
no running Istio pods in "istio-system"
1.13.5
