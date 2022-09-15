# nix-darwin-template

This repo includes a script for setting-up a Nix installation managed by [nix-darwin](https://github.com/LnL7/nix-darwin) on macOS. Run the script by executing the commands below:

```console
git clone https://github.com/Kranzes/nix-darwin-template
cd nix-darwin-template
./setup.sh
```
 > NOTE: I recommend to only use this script for the initial installation, as it includes various steps that are no longer needed after the initial setup.

After the activating of the first nix-darwin generation, you will be able to use the `darwin-rebuild` command to rebuild your system, thus making the setup script obsolete. In order to rebuild your system, all you have to do is run the command below:
```console
darwin-rebuild switch --flake /path/to/repo/holding/your/flake
```
