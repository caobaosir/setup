#目前wg需要edge/testing，国内使用清华源

#echo 'http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/main' > /etc/apk/repositories
echo 'http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/testing' >> /etc/apk/repositories

apk update   #更新源索引文件
apk add curl sudo

apk add linux-vanilla linux-virt #linux-vanilla-dev
apk add wireguard-vanilla wireguard-virt iptables
apk add wireguard-tools bash openrc

#服务端配置文件（单/多用户）
mkdir /etc/wireguard
cat > /etc/wireguard/wg0.conf <<EOF
[Interface]
PrivateKey = cFGAuatqg8RHfes4P+iphOGMp7XUNjq16K6ksfuuJ3Y=
Address = 10.0.0.1/24
ListenPort = 53988
DNS = 8.8.8.8
MTU = 1420

[Peer]
PublicKey = lqofQOo5TU2Ji1vXWQ49xOp7B0PCTJQqYBApSZDryiI=
AllowedIPs = 10.0.0.2/32

EOF

#服务器网卡配置====/etc/network/interfaces ======================
chmod +rw /etc/network/interfaces
cat >> /etc/network/interfaces <<EOF
auto wg0
iface wg0 inet static
    address 10.0.0.1
    netmask 255.255.255.0
    pre-up ip link add dev wg0 type wireguard
    pre-up wg setconf wg0 /etc/wireguard/wg0.conf
    post-down ip link delete dev wg0
EOF



#接口启停
#ifup wg0
#ifdown wg0

#启用wg
wg-quick up wg0
wg

#设置开机自启
cat > /etc/local.d/wireguardss.start <<EOF
wg-quick down wg0
wg
wg-quick up wg0
wg
EOF
chmod +rwx /etc/local.d/wireguardss.start
sudo rc-update add local

#配置iptables

sudo rc-update add iptables
sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -F
sudo service iptables save
sudo service iptables restart

#启用ip4路由
chmod +rw /proc/sys/net/ipv4/ip_forward
echo 1 > /proc/sys/net/ipv4/ip_forward
chmod +rw /etc/sysctl.conf
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf
sudo sysctl -p /etc/sysctl.conf
