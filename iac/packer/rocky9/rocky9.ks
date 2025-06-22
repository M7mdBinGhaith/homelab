text
cdrom
lang en_US.UTF-8
keyboard us
timezone UTC
network --bootproto=dhcp --device=link --activate
rootpw --plaintext rocky
user --name=rocky --password=rocky --groups=wheel
bootloader --location=mbr
clearpart --all --initlabel
autopart
firstboot --disable
eula --agreed
reboot

%packages
@core
openssh-server
qemu-guest-agent
curl
wget
%end

%post
echo "rocky ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/rocky
chmod 440 /etc/sudoers.d/rocky
systemctl enable sshd
systemctl start sshd
systemctl enable qemu-guest-agent
systemctl start qemu-guest-agent
sed -i 's/^#PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/' /etc/ssh/sshd_config
%end