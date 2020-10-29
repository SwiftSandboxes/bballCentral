# this script is intended to keep track of the steps done to setup the CICD server. 
# Many of the steps may be commented out and/or UNTESTED to begin with just to serve as documentation. However, the intention is that this could be runnable at some point.

# Add VIM
apt update
sudo apt-get -y install vim

# add bash setup
curl -O https://gist.githubusercontent.com/Notso/feacb7a6c5e7d89a2bc75b5ed25c9adc/raw/612645fa7adb9c5bea1e04a2bd1bdbce5e7ef302/.bash_prompt
cp .bashrc .bashrc_orig
curl https://gist.githubusercontent.com/Notso/72407b8c7a56fd2043d3dad61f95055c/raw/433f8794f8277cf91acb45c0b685a530132aa4bb/.bashrc >> .bashrc
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> .git_completion
curl https://gist.githubusercontent.com/Notso/92c6fe5d1504b025782a46a3fdf8971c/raw/b98f75273079387c31e0a8a9c43cd9879a3424fa/.bash_profile >> .bash_profile

# add Docker
# note that this follows the steps on https://linuxhint.com/install_docker_linux_mint/ 
# which is the same as https://docs.docker.com/engine/install/ubuntu/ except that the particular Ubuntu version (in this case focal) is explicitly 
# defined since the $(lsb_release -cs) command would return the linux mint release version and not the proper Ubuntu release version
# note that this does mean that when the Ubuntu version updates, this script may need to be updated
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# update docker to run without sudo (this enables minikube to use it)
sudo groupadd docker
sudo usermod -aG docker $USER
# make group changes take effect without restart
newgrp docker

# add minikube
curl -o Downloads/minikube_latest_amd64.deb -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
# note that the below command may prompt for root user password
sudo dpkg -i Downloads/minikube_latest_amd64.deb

# at this point you may want to manually ensure minikube and its dashboard work by running 'minikube start' and 'minikube dashboard'

# install kubectl. See https://helm.sh/docs/intro/install/. These steps are copied from there.
sudo apt-get update && sudo apt-get install -y apt-transport-https gnupg2 curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl

# install helm. Note that steps on https://helm.sh/docs/intro/install/ include installing apt-transport https, which this script has already done
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# install jenkins on k8s via helm
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm install bball-cicd-server jenkins/jenkins
# Note that there is important info spit out after the jenkins install including how to get admin pass, Jenkins URL, and how to log in
