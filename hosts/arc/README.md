# Desktop Setup

## Configuration

| Type | Value |
| --- | --- |
| CPU | 8c/16t |
| RAM | 32GB |
| boot disk | 512 GB |
| data disk | 1 TB |

## Partitioning

### UEFI
```bash

sudo -i

export DISK=/dev/disk/by-id/nvme-Samsung_SSD_970_EVO_Plus_500GB_S4EVNX1R908208R
export DATA_DISK=/dev/disk/by-id/nvme-CT4000P3PSSD8_2242E67C5466

parted ${DISK} -- mklabel gpt
parted ${DISK} -- mkpart ESP fat32 1MiB 512MiB
parted ${DISK} -- mkpart primary linux-swap -16GiB 100%
parted ${DISK} -- mkpart primary 512MiB -16GiB
parted ${DISK} -- set 1 esp on
```

## Formatting

### UEFI

```bash
mkfs.vfat -F 32 -n boot ${DISK}-part1

mkswap -L swap ${DISK}-part2
swapon ${DISK}-part2

mkfs.btrfs -f -L root ${DISK}-part3
```


## Installing

### Btrfs subvolume creation

```bash
mount ${DISK}-part3 /mnt
btrfs subvolume create /mnt/root
btrfs subvolume create /mnt/home
btrfs subvolume create /mnt/nix
btrfs subvolume create /mnt/log

umount /mnt
```


### Mount btrfs subvolumes

```bash
mount -o subvol=root,compress=zstd,noatime,nodiratime ${DISK}-part3 /mnt
mkdir -p /mnt/{boot,home,nix,var/log}
mount -o subvol=home,compress=zstd,noatime,nodiratime ${DISK}-part3 /mnt/home
mount -o subvol=nix,compress=zstd,noatime,nodiratime ${DISK}-part3 /mnt/nix
mount -o subvol=log,compress=zstd,noatime,nodiratime ${DISK}-part3 /mnt/var/log
mount /dev/disk/by-label/boot /mnt/boot
```

---

# Continue with the main [README](../../README.md) steps
