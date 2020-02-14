text
install

ignoredisk --only-use=sda
clearpart --all
#autopart
part / --fstype=xfs --size=9000 --grow --asprimary
bootloader --location=mbr --driveorder=sda

rootpw r4hasia01
user wid --name wid --password r4hasia

timezone Asia/Jakarta
network --bootproto=dhcp

firewall --disabled
#reboot --eject
shutdown

%packages
@Core
%end
%post --interpreter=/bin/bash
#exec < /dev/tty6 > /dev/tty6
#chvt 6
echo ### Add public ssh key for Ansible
mkdir -m0700 -p /home/wid/.ssh
cat <<EOF >/home/wid/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBqAMPfPPdMuYmwxJpoBrEeWwSmB3KU2WmaCNJrRIKVz8rzD2XADaV1JsO/peBke20W4behyeUAT+7U9SLJZlCotiXHTGu2klSQQicRjwmZfKuO0+S8Ka7AnWn8uhTwsv2QJeFStEN8NPPRXtKu7HX/+hznM//WjaX8luyByPzuka5kLCIS2RQO1NVvKHR41lD2DspeCcJ6yw1YIMDdbNcH8M4zSTf1B/MgOMUk4kXaOnFgrST9xfhNfDy0JRykOCJ2A9Ap3x7jA+uMkTfOUzXWVJsKuqv5mha7ScbxSexvMcxbUAMOhKEr9ppe2+n7oRmw50c1JQ8qMtI0S3uFz6qWb0wKDDa7B+fA4ThjNZiPeYoOAy7BwD4AtipiHJBpU78XnqJbg0o1CDsS6Q4KAkGy6zb+nv1BRM9InAC9MjqEeCywrLf4/iMjnUCULfECCIhRuWFFbJJgq4plsv1ZRjx43DZ1WukMPPeyuglX/zvSRzAWXLzPqL9KQyIk77g75dSAShQbULguhhNN644mQVcXsTs9o0ub5ErgfkMqKSPd2nFQRsrK6qziPAIdUfj81IzQQ7BDmuyQyvUXUf34QfoB/ZVW/EqPW5dx6VXXflDuE3Vs496XFRQ89H6lRcqM49dTAhhKWgRNqquMOgiMvDU0zwJmLpC5xS+acutKtYC8Q== root@paa
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTIv6ziCUfRwMfGGVwZoKtWLf51+OLzDwwQYXyrf8vmnY7tZB7GLWAWCmto2nsNfwBQiXBXWZ7rUfTM2og/xfTerrDexyBg1Polm0FAK9zNwDE77WqSeirCQFAQ0Q+GaJaERitrF5h+SfDBHIgoMEuWJMzCQvzaI/3WU2YB//LzcM3NckfxolxQbjMzPNweVZ6BpEOGB7a9BQh370+EFj8h9suOVPYmqV5L5M0gMrYiQ7qA2Zzf442g5AElJqU7p8EFUI4ttLnP8AlkxQvRQOWRcf11iQDAbJNF7UDh0iqYOe0cynnMUZQp1nmQD5t65L8tHp0k94P3bdN7FHvbjBL root@wid
EOF
chown -R wid:wid /home/wid
chown -R wid:wid /home/wid/.ssh
chmod 0600 /home/wid/.ssh/authorized_keys
mkdir -m0700 -p /root/.ssh
cat <<EOF >/root/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDBqAMPfPPdMuYmwxJpoBrEeWwSmB3KU2WmaCNJrRIKVz8rzD2XADaV1JsO/peBke20W4behyeUAT+7U9SLJZlCotiXHTGu2klSQQicRjwmZfKuO0+S8Ka7AnWn8uhTwsv2QJeFStEN8NPPRXtKu7HX/+hznM//WjaX8luyByPzuka5kLCIS2RQO1NVvKHR41lD2DspeCcJ6yw1YIMDdbNcH8M4zSTf1B/MgOMUk4kXaOnFgrST9xfhNfDy0JRykOCJ2A9Ap3x7jA+uMkTfOUzXWVJsKuqv5mha7ScbxSexvMcxbUAMOhKEr9ppe2+n7oRmw50c1JQ8qMtI0S3uFz6qWb0wKDDa7B+fA4ThjNZiPeYoOAy7BwD4AtipiHJBpU78XnqJbg0o1CDsS6Q4KAkGy6zb+nv1BRM9InAC9MjqEeCywrLf4/iMjnUCULfECCIhRuWFFbJJgq4plsv1ZRjx43DZ1WukMPPeyuglX/zvSRzAWXLzPqL9KQyIk77g75dSAShQbULguhhNN644mQVcXsTs9o0ub5ErgfkMqKSPd2nFQRsrK6qziPAIdUfj81IzQQ7BDmuyQyvUXUf34QfoB/ZVW/EqPW5dx6VXXflDuE3Vs496XFRQ89H6lRcqM49dTAhhKWgRNqquMOgiMvDU0zwJmLpC5xS+acutKtYC8Q== root@paa
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTIv6ziCUfRwMfGGVwZoKtWLf51+OLzDwwQYXyrf8vmnY7tZB7GLWAWCmto2nsNfwBQiXBXWZ7rUfTM2og/xfTerrDexyBg1Polm0FAK9zNwDE77WqSeirCQFAQ0Q+GaJaERitrF5h+SfDBHIgoMEuWJMzCQvzaI/3WU2YB//LzcM3NckfxolxQbjMzPNweVZ6BpEOGB7a9BQh370+EFj8h9suOVPYmqV5L5M0gMrYiQ7qA2Zzf442g5AElJqU7p8EFUI4ttLnP8AlkxQvRQOWRcf11iQDAbJNF7UDh0iqYOe0cynnMUZQp1nmQD5t65L8tHp0k94P3bdN7FHvbjBL root@wid
EOF
chmod 0600 /root/.ssh/authorized_keys
# Allow Ansible to sudo w/o a password
echo "wid ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/wid
# trim
echo "0 0 1 0 0 fstrim /" | tee /etc/cron.d/fstrim
sed -i '/ swap /s/^/#/' /etc/fstab
sed -i 's/defaults/defaults,discard/' /etc/fstab
echo ### Change back to terminal 1
#chvt 1
%end

#virt-install --name c7 --disk path=c7.qcow2,format=qcow2,bus=virtio,size=9 --memory=900 --location /iso/CentOS-7.0-1406-x86_64-Minimal.iso --initrd-inject=cks.cfg --extra-args "inst.ks=file:/cks.cfg"

#https://www.srv24x7.com/kickstart-install-centos-7-using-virt-install/
#https://www.cyberciti.biz/faq/how-to-install-kvm-on-centos-7-rhel-7-headless-server/
#http://blog.leifmadsen.com/blog/2016/12/16/creating-virtual-machines-in-libvirt-with-virt-install/
#http://kvmonz.blogspot.com/p/knowledge-use-virt-install-for-kvm.html
#https://earlruby.org/2018/12/use-iso-and-kickstart-files-to-automatically-create-vms/
#https://graspingtech.com/creating-virtual-machine-virt-install/
#https://www.server-world.info/en/note?os=Ubuntu_18.04&p=kvm&f=2
#http://blog.zencoffee.org/2016/06/easy-headless-kvm-deployment-virt-install/
#https://gist.github.com/aladuca/854b78585c2bba961386
