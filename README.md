# hellocloud-native-box


## Updated VagrantBox Spin-up using bash script
- Initially, `hc_id_rsa` SSH Key will generate when you this script.
- But it will prompt you to overwrite (y/n) for SSH Key if you've created before.
- Secondly, highly recommened to specify your `VagrantBox SSH Key Path`, instead of using default path.

```
./ssh-vagrant.sh
```


#### Example input of SSH Key path

### Spin-up the Kubernetes Cluster using Cilium as CNI
- Go the manifests directory and run the scrip `setup-mlb-13-cilium-k8s-v127.sh`
- Kubernetes Cluster will spin-up with one master-node and two worker-nodes.
- However, if you wanna add more worker-nodes, go to he `/manitests/kind-cluster/kindconfig-v1270.yaml` file and configure.
- Even though using the `Cilium` as CNI, Load-Balancer still using `Metallb` but Version is v.13.

```
cd ~/manifests
./setup-mlb-13-cilium-k8s-v127.sh
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