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
