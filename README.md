# hellocloud-native-box

#### generate public/private key pair
```
git clone git@github.com:hellocloudio/hellocloud-native-box.git
cd hellocloud-native-box
mkdir .ssh
cd .ssh
ssh-keygen
```
#### Create /etc/vbox/networks.conf
```
sudo su
cd /etc
mkdir vbox
cd vbox
vi networks.conf
* 0.0.0.0/0 ::/0
:wq!
```

#### hellocloudio GitHub Account
```
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/github.com.hellocloudio
ssh -T git@github.com

git config user.name "hellocloudio"
git config user.email "helloocloud@gmail.com"
```

#### Up and Running vagrant box
```
git clone git@github.com:hellocloudio/hellocloud-native-box.git
cd hellocloud-native-box
mkdir .ssh
cd .ssh
ssh-keygen
/Users/sai/hellocloud-boxes/hellocloud-native-box/.ssh/id_rsa
cd ../
vagrant up
```

#### Spin up k8s cluster
```
vagrant ssh
cd k8s-cop/1-single-cluster/setup/
./setup-kindcluster123.sh
```

#### aws config
```
cat ~/.aws/config
```

```
# gritworks-nonprod
[profile gritworks-nonprod]
region = ap-southeast-1

# gritworks-nonprod-terraform-role
[profile gritworks-dev-terraform-role]
region = ap-southeast-1
source_profile = gritworks-nonprod
role_arn = arn:aws:iam::xxxxxxxxxxxx:role/gritworks-nonprod-terraform-role

# gritworks-dev-terraform-role
[profile gritworks-dev-terraform-role]
region = ap-southeast-1
source_profile = gritworks-nonprod
role_arn = arn:aws:iam::xxxxxxxxxxxx:role/gritworks-dev-terraform-role

# gritworks-security-terraform-role
[profile gritworks-security-terraform-role]
region = ap-southeast-1
source_profile = gritworks-nonprod
role_arn = arn:aws:iam::xxxxxxxxxxxx:role/gritworks-security-terraform-role

```
#### aws credentials
```
cat ~/.aws/credentials
```
```
# gritworks-nonprod
[gritworks-nonprod]
aws_access_key_id =
aws_secret_access_key =
```