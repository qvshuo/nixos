# nixos

## Partitioning and formatting

```
mount /dev/disk/by-label/nixos /mnt
mkdir -p /mnt/boot
mount /dev/disk/by-label/boot /mnt/boot
mkdir -p /mnt/home
mount /dev/disk/by-label/home /mnt/home
swapon /nvme0n1p?
```

## Privilege 

```
sudo su
```

## Generate clone, and edit configuration file

```
nixos-generate-config --root /mnt
git clone https://github.com/qvshuo/nixos.git
vim /mnt/etc/nixos/configuration.nix
```

## Do the installation

```
nixos-install
```
