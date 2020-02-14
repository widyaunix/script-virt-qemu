preseed preseed/file string /cdrom/preseed/ubuntu-server-minimalvm.seed

lang en_US
langsupport en_US
keyboard us
#mouse
timezone Asia/Jakarta

#Root password
rootpw --disabled

user widysible --fullname "widysible" --password $1$u08OmYWr$s3v/lOnNMVyb5SCEwFFLG1

reboot
text
install
cdrom

zerombr yes
clearpart --all --initlabel
bootloader --location=mbr
preseed partman-auto-lvm/guided_size string 8192MB
part pv.1 --grow --size=1 --asprimary
volgroup vg0 pv.1
logvol / --fstype=ext4 --name=root --vgname=vg0 --size=8000

preseed base-installer/install-recommends boolean false

auth --useshadow

network --bootproto=dhcp --device=auto

preseed pkgsel/update-policy select unattended-upgrades

skipx

%packages
# -- required for %post --
vim
software-properties-common
# -- pretty much required --
gpg-agent  # apt-key needs this when piping certs in through stdin
curl
openssh-server
net-tools  # this includes commands like ifconfig and netstat
wget
man
bash-completion  # personally I always install it but not everyone uses bash

%post
# -- begin security hardening --
# Change default umask from 022 to 027 (not world readable)
echo ### Add public ssh key for Ansible
mkdir -m0700 -p /home/widysible/.ssh
cat <<EOF >/home/widysible/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTIv6ziCUfRwMfGGVwZoKtWLf51+OLzDwwQYXyrf8vmnY7tZB7GLWAWCmto2nsNfwBQiXBXWZ7rUfTM2og/xfTerrDexyBg1Polm0FAK9zNwDE77WqSeirCQFAQ0Q+GaJaERitrF5h+SfDBHIgoMEuWJ
MzCQvzaI/3WU2YB//LzcM3NckfxolxQbjMzPNweVZ6BpEOGB7a9BQh370+EFj8h9suOVPYmqV5L5M0gMrYiQ7qA2Zzf442g5AElJqU7p8EFUI4ttLnP8AlkxQvRQOWRcf11iQDAbJNF7UDh0iqYOe0cynnMUZQp1nmQD5t65L8tHp0k94P3bdN7FHvbjBL
 root@wid
EOF
chown -R widysible:widysible /home/widysible
chown -R widysible:widysible /home/widysible/.ssh
chmod 0600 /home/widysible/.ssh/authorized_keys
mkdir -m0700 -p /root/.ssh
cat <<EOF >/root/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDTIv6ziCUfRwMfGGVwZoKtWLf51+OLzDwwQYXyrf8vmnY7tZB7GLWAWCmto2nsNfwBQiXBXWZ7rUfTM2og/xfTerrDexyBg1Polm0FAK9zNwDE77WqSeirCQFAQ0Q+GaJaERitrF5h+SfDBHIgoMEuWJ
MzCQvzaI/3WU2YB//LzcM3NckfxolxQbjMzPNweVZ6BpEOGB7a9BQh370+EFj8h9suOVPYmqV5L5M0gMrYiQ7qA2Zzf442g5AElJqU7p8EFUI4ttLnP8AlkxQvRQOWRcf11iQDAbJNF7UDh0iqYOe0cynnMUZQp1nmQD5t65L8tHp0k94P3bdN7FHvbjBL
 root@wid
EOF
chmod 0600 /root/.ssh/authorized_keys
# Allow Ansible to sudo w/o a password
echo "widysible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/widysible

sed -i 's/defaults/defaults,discard/' /etc/fstab

sed -i -e 's/^\(UMASK\W*\)[0-9]\+$/\1027/' /etc/login.defs

# Set some defaults for apt to keep things tidy
cat > /etc/apt/apt.conf.d/90local <<"_EOF_"
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";
APT::Periodic::AutocleanInterval "1";
APT::Periodic::MaxSize "200";
Unattended-Upgrade::Remove-Unused-Dependencies "true";
#Acquire::http::Proxy "http://my-local-cache:3142";
_EOF_

# -- begin vim package customizations --
echo "set background=dark" >>/etc/vim/vimrc.local
# -- end vim package customizations --

# -- begin install git from 'Ubuntu Git Maintainers' PPA --
add-apt-repository -y ppa:git-core/ppa
apt-get -qq -y update
apt-get -qq -y install git
# -- end install git from 'Ubuntu Git Maintainers' PPA --

# -- begin set xdg base directories --
cat > /etc/profile.d/xdg_basedir.sh <<"_EOF_"
# Set XDG base directory global variables
# XDG_RUNTIME_HOME is set on user login
export XDG_DATA_HOME="${XDG_DATA_HOME:-"${HOME}/.local/share"}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-"${HOME}/.config"}"
export XDG_CACHE_HOME="${XDG_CACHE_HOME:-"${HOME}/.cache"}"
_EOF_
chmod 0644 /etc/profile.d/xdg_basedir.sh
# -- end set xdg base directories --

# Clean up
apt-get -qq -y autoremove
apt-get clean
rm -f /var/cache/apt/*cache.bin
rm -rf /var/lib/apt/lists/*

%end
