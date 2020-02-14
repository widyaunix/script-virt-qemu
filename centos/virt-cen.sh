#!/bin/bash

NAMA=$1

if [ -z "$1" ]; then
 while [ -z "$NAMA" ]; do
  echo -n "masukan nama vm: "
  read NAMA
 done
fi

virt-install \
 --name $NAMA \
 --ram 900 \
 --disk path=/virtual/images/$NAMA.qcow2,size=30,bus=scsi,discard='unmap',format='qcow2' \
 --controller type=scsi,model=virtio-scsi \
 --vcpus 1 \
 --cpu host \
 --console pty,target_type=serial \
 --location /iso/CentOS-7-x86_64-Minimal-1908.iso \
 --initrd-inject=centos.ks --extra-args "inst.ks=file:/centos.ks" \
# --noautoconsole
#systemctl start serial-getty@ttyS0
#systemctl enable serial-getty@ttyS0

