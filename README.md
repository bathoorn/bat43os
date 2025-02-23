<div align="center">

## bat43OS based ZaneyOS

bat43OS is a simple way of reproducing my configuration on any NixOS system.
This includes the wallpaper, scripts, applications, config files, and more.

</div>

#### 🍖 Requirements

- You must be running on NixOS.
- The bat43os folder (this repo) is expected to be in your home directory.
- Must have installed using GPT & UEFI. Systemd-boot is what is supported, for
  GRUB you will have to brave the internet for a how-to. ☺️
- Manually editing your host specific files. The host is the specific computer
  your installing on.

#### 🖥️ Multi Host & User Configuration

- You can define separate settings for different host machines and users.
- Easily specify extra packages for your users in the modules/core/user.nix
  file.
- Easy to understand file structure and simple, but encompassing,
  configuratiion.

#### 📦 How To Install Packages?

- You can search the [Nix Packages](https://search.nixos.org/packages?) &
  [Options](https://search.nixos.org/options?) pages for what a package may be
  named or if it has options available that take care of configuration hurdles
  you may face.
- To add a package there are the sections for it in `modules/core/packages.nix`
  and `modules/core/user.nix`. One is for programs available system wide and the
  other for your users environment only.

### ⬇️ Install

#### 📜 Script:

Simply run this:

```
nix-shell -p git curl
```

Then:

```
sh <(curl -L https://github.com/bathoorn/bat43os/-/raw/main/install.sh)
```

#### 🦽 Manual:

Run this command to ensure Git & Vim are installed:

```
nix-shell -p git vim
```

Clone this repo & enter it:

```
git clone https://github.com/bathoorn/bat43os.git
cd bat43os
```

- _You should stay in this folder for the rest of the install_

Create the host folder for your machine(s)

```
cp -r hosts/default hosts/<your-desired-hostname>
```

**🪧🪧🪧 Edit `hosts/<your-desired-hostname>/variables.nix` 🪧🪧🪧**

Generate your hardware.nix like so:

```
nixos-generate-config --show-hardware-config > hosts/<your-desired-hostname>/hardware.nix
```

Run this to enable flakes and install the flake replacing `profile` with any of
these options:

- amd
- nvidia
- nvidia-laptop
- intel
- vm

```
NIX_CONFIG="experimental-features = nix-command flakes" 
sudo nixos-rebuild switch --flake .#profile
```

Now when you want to rebuild the configuration you have access to an alias `fr`
that will rebuild the flake!
