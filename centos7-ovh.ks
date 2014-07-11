install
keyboard us
network  --bootproto=dhcp --device=eth0 --onboot=on
rootpw --iscrypted $1$UKLtvLuY$kka6S665oCFmU7ivSDZzU.
timezone Europe/Paris --isUtc 
selinux --enforcing
repo --name="CentOS" --baseurl=http://mirror.ovh.net/ftp.centos.org/7.0.1406/os/x86_64/ --cost=100
repo --name="Updates" --baseurl=http://mirror.ovh.net/ftp.centos.org/7.0.1406/updates/x86_64/ --cost=100


clearpart --all --initlabel
part / --fstype ext4 --size=1024 --grow
reboot

%packages  --excludedocs --nobase
bind-utils
bash
yum
vim-minimal
centos-release
shadow-utils
less
-kernel*
-*firmware
grub2
-os-prober
-gettext*
-bind-license
-freetype
tar
git
%end

%post
# randomize root password and lock root account
dd if=/dev/urandom count=50 | md5sum | passwd --stdin root
passwd -l root

# create necessary devices
/sbin/MAKEDEV /dev/console

# cleanup unwanted stuff

# ami-creator requires grub during the install, so we remove it (and
# its dependencies) in %post 

# some packages get installed even though we ask for them not to be,
# and they don't have any external dependencies that should make
# anaconda install them


yum -y remove  grub2 centos-logos hwdata os-prober gettext* \
  bind-license freetype

rm -rf /boot


# Add tsflags to keep yum from installing docs

sed -i '/distroverpkg=centos-release/a tsflags=nodocs' /etc/yum.conf

# Remove files that are known to take up lots of space but leave
# directories intact since those may be required by new rpms.

# locales
#find /usr/{{lib,share}/{i18n,locale},{lib,lib64}/gconv,bin/localedef,sbin/build-locale-archive} \
#        -type f \( ! -iname "*utf*" ! -name "en_US" \) | xargs /bin/rm


rm -f /usr/lib/locale/locale-archive

#  man pages and documentation
find /usr/share/{man,doc,info,gnome/help} \
        -type f | xargs /bin/rm

#  cracklib
#find /usr/share/cracklib \
#        -type f | xargs /bin/rm

#  sln
rm -f /sbin/sln

#  ldconfig
rm -rf /etc/ld.so.cache
rm -rf /var/cache/ldconfig/*

# ************************
# Add customizations here


# EPEL repo
rpm -Uvh http://download-i2.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm


# End of customizations
# ************************

%end
