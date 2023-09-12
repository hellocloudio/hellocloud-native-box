complete -C '/usr/local/bin/aws_completer' aws
terraform -install-autocomplete

complete -C /usr/bin/terraform terraform

. $HOME/.asdf/asdf.sh

. $HOME/.asdf/completions/asdf.bash
