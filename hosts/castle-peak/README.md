# Desktop Setup

## Configuration

| Type | Value |
| --- | --- |
| CPU | 16c |
| RAM | 32GB |
| boot disk | 200 GB |

## Partitioning

### UEFI
```bash
sudo -i

export DISK=/dev/sda

parted ${DISK} -- mklabel gpt
parted ${DISK} -- mkpart ESP fat32 1MiB 512MiB
parted ${DISK} -- mkpart primary linux-swap -16GiB 100%
parted ${DISK} -- mkpart primary 512MiB -16GiB
parted ${DISK} -- set 1 esp on
```

## Formatting

### UEFI

```bash
mkfs.vfat -F 32 -n boot ${DISK}1

mkswap -L swap ${DISK}2
swapon ${DISK}2

mkfs.btrfs -f -L root ${DISK}3
```


## Installing

### Btrfs subvolume creation

```bash
mount ${DISK}3 /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/log

umount /mnt
```


### Mount btrfs subvolumes

```bash
mount -o subvol=root,compress=zstd,noatime,nodiratime ${DISK}3 /mnt
mkdir -p /mnt/{boot,home,nix,var/log}
mount -o subvol=home,compress=zstd,noatime,nodiratime ${DISK}3 /mnt/home
mount -o subvol=nix,compress=zstd,noatime,nodiratime ${DISK}3 /mnt/nix
mount -o subvol=log,compress=zstd,noatime,nodiratime ${DISK}3 /mnt/var/log
mount /dev/disk/by-label/boot /mnt/boot
```

---

# Continue with the main [README](../../README.md) steps
