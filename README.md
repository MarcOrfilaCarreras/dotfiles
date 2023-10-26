# Dotfiles
![overview](https://i.imgur.com/aP8iJnD.png)

## Installation

To get started with the Dotfiles, ensure that Ansible is installed on your system. If you haven't installed Ansible yet, please refer to the official [Ansible installation guide](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html).

Once Ansible is set up, clone the repository using the following command:

``` bash
git clone https://github.com/MarcOrfilaCarreras/dotfiles.git
```

After successfully cloning the repository, execute the following command to install the dotfiles:

``` bash
ansible-playbook --ask-become-pass install.yml
```

## Troubleshooting

During the installation of the Dotfiles, you might encounter certain issues with the configuration setup. Here are some common problems you may face and their respective solutions:

### Issue: Mousepad not working

Solution: Visit this [link](https://bbs.archlinux.org/viewtopic.php?pid=1916526#p1916526) for assistance on resolving the mousepad functionality.

### Issue: Battery show icon

Solution: Follow the instructions provided in the [battery module documentation](https://github.com/polybar/polybar/wiki/Module:-battery) to ensure the battery icon is displayed correctly.

### Issue: Human scrolling

Solution: Check out this thread on [Ask Ubuntu](https://askubuntu.com/questions/91426/reverse-two-finger-scroll-direction-natural-scrolling) for guidance on adjusting the scrolling behavior.

### Issue: Zsh can't find Python installed modules

Solution: Refer to this [Reddit thread](https://www.reddit.com/r/zsh/comments/vc5egt/zsh_cannot_find_python_installed_modules/) to troubleshoot the problem related to Zsh not finding installed Python modules.
