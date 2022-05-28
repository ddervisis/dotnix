# Server Setup

## Configuration

| Type | Value |
| --- | --- |
| CPU | 12c/24t |
| RAM | 32GB |
| boot disk | xxx GB |
| data disk | xxTB |
| data disk | xxTB |
| data disk | xxTB |
| data disk | xxTB |
| ~~cache disk~~ | ~~xxxGB~~ |

## Partitioning

### UEFI
```bash

sudo -i

export BOOT_DISK=/dev/disk/by-id/xxxx
export STORAGE_DISK_1=/dev/disk/by-id/xxxy
export STORAGE_DISK_2=/dev/disk/by-id/xxxz
export STORAGE_DISK_3=/dev/disk/by-id/xxyx
export STORAGE_DISK_4=/dev/disk/by-id/xxzx
export DATA_DISK=/dev/disk/by-id/xyxx

export RAM_SIZE=32

# boot disk
parted --script $BOOT_DISK -- \
  mklabel gpt \
  mkpart ESP fat32 1MiB 512MiB \
  mkpart primary linux-swap -${RAM_SIZE}GiB 100% \
  mkpart primary 512MiB -${RAM_SIZE}GiB
  set 1 esp on
```

## Formatting

### UEFI

```bash
mkfs.vfat -F 32 -n boot ${BOOT_DISK}-part1
mkswap -L swap ${BOOT_DISK}-part2
swapon ${BOOT_DISK}-part2
```

### Zfs pool creation

```bash
# boot pool
zpool create \
  -o ashift=12 \
  -o autotrim=on \
  -R /mnt \
  -O canmount=off \
  -O mountpoint=none \
  -O acltype=posixacl \
  -O compression=lz4 \
  -O dnodesize=auto \
  -O normalization=formD \
  -O relatime=on \
  -O xattr=sa \
  rpool \
  ${BOOT_DISK}-part3 -f

# storage pool
zpool create \
  -o ashift=12 \
  -o autotrim=on \
  -R /mnt/storage \
  -O canmount=off \
  -O mountpoint=none \
  -O acltype=posixacl \
  -O compression=lz4 \
  -O dnodesize=auto \
  -O normalization=formD \
  -O relatime=on \
  -O xattr=sa \
  storage \
  raidz \
  ${STORAGE_DISK_1} \
  ${STORAGE_DISK_2} \
  ${STORAGE_DISK_3} \
  ${STORAGE_DISK_4}

# data pool
zpool create \
  -o ashift=12 \
  -o autotrim=on \
  -R /mnt \
  -O canmount=off \
  -O mountpoint=none \
  -O acltype=posixacl \
  -O compression=lz4 \
  -O dnodesize=auto \
  -O normalization=formD \
  -O relatime=on \
  -O xattr=sa \
  data \
  ${DATA_DISK} -f


# reserve some disk space
zfs create -o refreservation=1G -o mountpoint=none rpool/reserved
zfs create -o refreservation=1G -o mountpoint=none storage/reserved
zfs create -o refreservation=1G -o mountpoint=none data/reserved

# boot pool datasets
zfs create -o mountpoint=none rpool/nixos
zfs create rpool/nixos/nix

# storage pool datasets
# compression off for obvious reasons: media/downloads/games/iso are video or iso files.
zfs create -o mountpoint=none -o compression=off storage/media
zfs create -o mountpoint=none -o compression=off storage/downloads
zfs create -o mountpoint=none storage/cloud
zfs create -o mountpoint=none storage/games
zfs create -o mountpoint=none -o compression=off storage/iso
zfs create -o mountpoint=none storage/backup

# data pool datasets
zfs create -o mountpoint=none data/vms
zfs create -o mountpoint=none data/containers
zfs create -o mountpoint=none data/services

```

### Mount partitions

```bash
# [b|r]oot partitions
mount -t zfs -o zfsutil rpool/nixos /mnt
mkdir -p /mnt/{nix,boot}
mount -t zfs -o zfsutil rpool/nixos/nix /mnt/nix
mount /dev/disk/by-label/boot /mnt/boot

# storage partitions
export STORAGE_PATH=/mnt/storage
mkdir -p ${STORAGE_PATH}/{media,downloads,cloud,games,iso}
mount -t zfs -o zfsutil storage/media ${STORAGE_PATH}/media
mount -t zfs -o zfsutil storage/downloads ${STORAGE_PATH}/downloads
mount -t zfs -o zfsutil storage/cloud ${STORAGE_PATH}/cloud
mount -t zfs -o zfsutil storage/games ${STORAGE_PATH}/games
mount -t zfs -o zfsutil storage/iso ${STORAGE_PATH}/iso
mount -t zfs -o zfsutil storage/backup ${STORAGE_PATH}/backup

# data partitions
export DATA_PATH=/mnt/data
mkdir -p ${DATA_PATH}/{backup,vms,containers}
mount -t zfs -o zfsutil data/vms ${DATA_PATH}/vms
mount -t zfs -o zfsutil data/containers ${DATA_PATH}/containers
mount -t zfs -o zfsutil data/services ${DATA_PATH}/services
```

---

# Continue with the main [README](../../README.md) steps
