#!/bin/sh

CONTAINER_ROOT=build_container
RUN_SCRIPT=run.sh

if [[ $EUID -ne 0 ]]; then
   echo "Run as root"
   exit 1
fi

rm -rf $CONTAINER_ROOT
mkdir -p $CONTAINER_ROOT
pacstrap -c $CONTAINER_ROOT base base-devel
cat <<EOF > $CONTAINER_ROOT/$RUN_SCRIPT
#!/bin/sh

cd /root/src

cp etc/group /etc/group
cp etc/passwd /etc/passwd

make image
EOF
chmod +x $CONTAINER_ROOT/$RUN_SCRIPT

systemd-nspawn -D $CONTAINER_ROOT --bind=+/../:/root/src --capability=CAP_MKNOD /$RUN_SCRIPT
