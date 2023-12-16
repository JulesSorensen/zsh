# My ZSH Configuration

This is my ZSH configuration. It contains a list of aliases and scripts that I use on a daily basis!

## Aliases

See the [aliases](./zshrc) file for a list of aliases.

## Scripts

See the [scripts](./scripts) directory for a list of scripts.

Currently, the scripts are:
    - `lazynvm` - A script allowing you to automatically load the node version defined in your Docker configuration using NVM.
    - `lazygvm` - Same, but for Go with GVM.

## Installation

[Click here to install Oh My ZSH](https://ohmyz.sh/)

Clone the repo into your home directory:

```bash
cd ~
git clone git@github.com:JulesSorensen/zsh.git zshjconfig
cp zshjconfig/.zshrc .zshrc
cp -r zshjconfig/scripts scripts
```

You can now take advantage of the aliases and scripts!

## Updating

To update the configuration, simply run:

```bash
cd ~/zshjconfig
git pull
cd ../
cp zshjconfig/.zshrc .zshrc
rm -rf scripts
cp -r zshjconfig/scripts scripts
```
