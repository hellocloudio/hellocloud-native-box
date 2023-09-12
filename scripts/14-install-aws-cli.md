vagrant@aws-dev-box:~$ python3 --version
Python 3.10.4

sudo apt update -y
sudo apt install -y python3-pip

pip3 install boto3

# install aws cli
sudo apt install curl unzip -y

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

$ ls -la | grep aws
drwxr-xr-x 1 vagrant vagrant      192 May 14 21:24 aws
-rw-r--r-- 1 vagrant vagrant 43524657 May 18 15:08 awscliv2.zip

$ sudo ./aws/install
You can now run: /usr/local/bin/aws --version

$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin

$ aws --version
aws-cli/2.12.1 Python/3.11.3 Linux/5.15.0-30-generic exe/x86_64.ubuntu.22 prompt/off

$ aws

usage: aws [options] <command> <subcommand> [<subcommand> ...] [parameters]
To see help text, you can run:

  aws help
  aws <command> help
  aws <command> <subcommand> help

aws: error: the following arguments are required: command

# command completion
https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-completion.html#cli-command-completion-linux

# step 1
which aws_completer

# step 2
ls -la /usr/local/bin/ | grep aws
lrwxrwxrwx  1 root root       37 Aug  9 07:26 aws -> /usr/local/aws-cli/v2/current/bin/aws
lrwxrwxrwx  1 root root       47 Aug  9 07:26 aws_completer -> /usr/local/aws-cli/v2/current/bin/aws_completer

# step 3
Find your shell's profile script in your user folder.
ls -la ~/
# Bash– 
.bash_profile, .profile, or .bash_login

# Zsh– 
.zshrc

# Tcsh– 
.tcshrc, .cshrc, or .login

vi ~/.bash_profile
complete -C '/usr/local/bin/aws_completer' aws

