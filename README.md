# NixOS setup

# Initial disk setup

- [Desktop Setup](./hosts/arc/README.md)
<!-- - [Server Setup](./hosts/loid/README.md) -->

# Generate NixOS config

```bash
nixos-generate-config --root /mnt
```

## Clone Nix config files repo
```bash
nix-env -iA nixos.git
git clone https://github.com/ddervisis/dotnix /mnt/etc/nixos/dotnix
```

### Switch hardware-configuration
```bash
cp /mnt/etc/nixos/dotnix/hosts/<host>/hardware-configuration.nix /mnt/etc/nixos/
```

## Start installation

```bash
cd /mnt/etc/nixos/dotnix
nixos-install --flake .#<host>
```

## Reboot

```bash
reboot
```

# Set user password

```bash
# login as root in tty1
passwd $USER
```

# SSH key setup

```bash
# login as $USER
mkdir -p ~/.ssh
curl https://github.com/${USER}.keys | tee -a ~/.ssh/authorized_keys
```

