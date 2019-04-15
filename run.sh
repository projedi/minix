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
make image
EOF
chmod +x $CONTAINER_ROOT/$RUN_SCRIPT

systemd-nspawn -D $CONTAINER_ROOT --bind=+/../:/root/src /$RUN_SCRIPT
