cd $HOME

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.12.0

####################################

# Update .bashrc (or) .bash_profile as below to add
. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash

####################################

source .bash_profile

asdf plugin-add istioctl https://github.com/virtualstaticvoid/asdf-istioctl.git

# Click here to check istio releases and download the istioctl version you want.
https://github.com/istio/istio/tags

asdf install istioctl 1.18.2
asdf install istioctl 1.17.5
asdf install istioctl 1.16.7

asdf list
#############
istioctl
  1.16.7
  1.17.5
  1.18.2
#############

# to use 1.18.2
asdf global istioctl 1.18.2

# verify
istioctl version

####################################################

https://istio.io/latest/docs/releases/supported-releases/