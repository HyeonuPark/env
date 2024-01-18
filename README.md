## Setup

```bash
cd ~
echo `source $HOME/env/rc.bash' > .bashrc
echo 'source $HOME/env/profile.bash' > .bash_profile
cd ~/.cargo
ln -s ~/env/cargo/config.toml config.toml
cd $$VSCODE_SETTING_DIR
ln -s ~/env/vscode/settings.json settings.json
ln -s ~/env/vscode/keybindings.json keybindings.json
```

## Done

disk encryption

- without double login on boot via modifying `/etc/gdm/custom.conf`

```ini
[daemon]
AutomaticLoginEnable=true
AutomaticLogin=hyeonu
```

swap caps lock and ctrl via gnome-tweaks

`dnf install clang hexedit`

`curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh`

`cargo install ripgrep eza cargo-expand cargo-outdated flamegraph`

vscode

`gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"`

add below lines to `/etc/dnf/dnf.conf`

```ini
max_parallel_downloads=20
fastestmirror=True
```

## Todo

check hibernate

check kime
