#!/bin/sh

# To create minix.img follow the instructions at https://wiki.minix3.org/doku.php?id=usersguide:runningonqemu
# My steps were:
# 1. qemu-img create minix.img 4G
# 2. qemu-system-i386 -rtc base=utc -net user -net nic -m 256 -cdrom ~/Downloads/minix-3.1.0-book.iso -hda minix.img -boot d
# 3. Follow the instructions to install Minix into minix.img
# 4. And this is how to run it:
#    qemu-system-i386 -rtc base=utc -net user -net nic -m 256 -hda minix.img -boot d
# 5. And then I did:
#    mv minix.img minix-orig.img
#    chmod -w minix-orig.img
#    So that I do not accidentally alter golden image.
#
# Resulting partition table:
# 1. root: base=64,last=32831,size=32768
# 2. home: base=32832,last=1572927,size=1540096
# 3. usr: base=1572928,last=8385929,size=6813002

# TODO: Build Minix image on Linux host.
# 1. Make a bootable image from inside Minix:
#    a) Run VM with two drives.
#    b) Partition the secondary drive and format it.
#    c) Put bootloader into the secondary drive.
#    d) Copy all the files from the primary to the secondary drive.
#    e) Try to boot VM from the secondary drive.
# 2. Tweak buildscript to install files into the chosen directory
#    and do it for the secondary drive instead of step 1.d.
# 3. Move step 1.b to Linux host.
# 4. Move step 1.c to Linux host.
# 5. Run compilation from Linux host.

# Start from golden image.
cp minix-orig.img minix.img

# Mount it.
sudo losetup -o 32768 /dev/loop0 minix.img
sudo losetup -o 16809984 /dev/loop1 minix.img
sudo losetup -o 805339136 /dev/loop2 minix.img
sudo mount -t minix /dev/loop0 minix-fs
sudo mount -t minix /dev/loop1 minix-fs/home
sudo mount -t minix /dev/loop2 minix-fs/usr

# Copy the sources to the minix-fs
sudo mkdir minix-fs/usr/mysrc
sudo cp -r boot commands drivers etc include kernel lib LICENSE Makefile man servers test tools minix-fs/usr/mysrc

# And add the script to start bootstrapping
sudo tee minix-fs/root/run.sh <<EOF
#!/bin/sh

cd /usr/mysrc
make etcfiles
make world
EOF
sudo chmod +x minix-fs/root/run.sh

# Unmount.
sudo umount -R minix-fs
sudo losetup -D

# And start the VM.
qemu-system-i386 -rtc base=utc -net user -net nic -m 256 -hda minix.img -boot d
