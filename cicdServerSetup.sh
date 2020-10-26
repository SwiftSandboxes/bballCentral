# this script is intended to keep track of the steps done to setup the CICD server. 
# Many of the steps may be commented out and/or UNTESTED to begin with just to serve as documentation. However, the intention is that this could be runnable at some point.

# Add VIM
apt update
sudo apt-get -y install vim

# add bash setup
curl -O https://gist.githubusercontent.com/Notso/feacb7a6c5e7d89a2bc75b5ed25c9adc/raw/612645fa7adb9c5bea1e04a2bd1bdbce5e7ef302/.bash_prompt
cp .bashrc .bashrc_orig
curl https://gist.githubusercontent.com/Notso/72407b8c7a56fd2043d3dad61f95055c/raw/1c1d6aed8a570dd5eabebb8cc645fedb72f637b3/.bashrc >> .bashrc
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> .git_completion
curl https://gist.githubusercontent.com/Notso/92c6fe5d1504b025782a46a3fdf8971c/raw/926730ccc06965c0245cb8028e58270a14d08de4/.bash_profile >> .bash_profile

# add minikube
curl -o Downloads/minikube_latest_amd64.deb -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
# note that the below command may prompt for root user password
sudo dpkg -i Downloads/minikube_latest_amd64.deb
