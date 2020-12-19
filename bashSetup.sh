# add bash setup
curl -O https://gist.githubusercontent.com/Notso/feacb7a6c5e7d89a2bc75b5ed25c9adc/raw/612645fa7adb9c5bea1e04a2bd1bdbce5e7ef302/.bash_prompt
cp .bashrc .bashrc_orig
curl https://gist.githubusercontent.com/Notso/72407b8c7a56fd2043d3dad61f95055c/raw/433f8794f8277cf91acb45c0b685a530132aa4bb/.bashrc >> .bashrc
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash >> .git_completion
curl https://gist.githubusercontent.com/Notso/92c6fe5d1504b025782a46a3fdf8971c/raw/b98f75273079387c31e0a8a9c43cd9879a3424fa/.bash_profile >> .bash_profile
