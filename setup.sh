#!/usr/bin/env bash

set -e pipefail

if ! command -v nix &>/dev/null; then
	while true; do
		read -p "A Nix installation could not be found. Would you like to install Nix now? (y/n) " yn

		case $yn in
		[yY])
			echo "Installing Nix..."
			sh <(curl -L https://nixos.org/nix/install)
			. /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
			;;
		[nN])
			echo "Exiting..."
			exit
			;;
		*) echo "Invalid response" ;;
		esac
	done
fi

echo "Making sure the flake inputs are up-to-date..."
nix --extra-experimental-features "nix-command flakes" flake update

echo "Building the system closure for darwinConfigurations.macbook..."
nix --extra-experimental-features "nix-command flakes" build .#darwinConfigurations.macbook.system

echo "Activating the newly built nix-darwin generation..."
sudo echo -e "run\tprivate/var/run" >> /etc/synthetic.conf
/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -B
/System/Library/Filesystems/apfs.fs/Contents/Resources/apfs.util -t
./result/sw/bin/darwin-rebuild switch --flake .#macbook
. /etc/static/bashrc
