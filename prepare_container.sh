#!/bin/sh

CONTAINER_ROOT=build_container

if [[ $EUID -ne 0 ]]; then
   echo "Run as root"
   exit 1
fi

rm -rf $CONTAINER_ROOT
mkdir -p $CONTAINER_ROOT
pacstrap -c $CONTAINER_ROOT base base-devel
cat <<EOF > $CONTAINER_ROOT/root/run.sh
#!/bin/sh

cd /root/src/tools
make image
EOF
chmod +x $CONTAINER_ROOT/root/run.sh
