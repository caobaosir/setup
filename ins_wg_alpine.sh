#目前wg需要edge/testing，国内使用清华源

echo 'http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/main' > /etc/apk/repositories
echo 'http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/testing' >> /etc/apk/repositories

apk update   #更新源索引文件
apk add linux-vanilla linux-virt linux-vanilla-dev
apk add wireguard-vanilla wireguard-virt
apk add wireguard-tools-wg  iptables

#服务端配置文件（单/多用户）
mkdir /etc/wireguard
cat > /etc/wireguard/wg0.conf <<EOF
[Interface]
PrivateKey = cFGAuatqg8RHfes4P+iphOGMp7XUNjq16K6ksfuuJ3Y=
Address = 10.0.0.1/24
PostUp   = echo 1 > /proc/sys/net/ipv4/ip_forward; iptables -A FORWARD -i wg0 -j ACCEPT; iptables -A FORWARD -i wg0 -j ACCEPT; iptables -A FORWARD -o wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -D FORWARD -o wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
ListenPort = 53988
DNS = 8.8.8.8
MTU = 1420

[Peer]
PublicKey = lqofQOo5TU2Ji1vXWQ49xOp7B0PCTJQqYBApSZDryiI=
AllowedIPs = 10.0.0.2/32

EOF


#启用wg
wg-quick up wg0     #    wg  命令显示状态


#服务器网卡配置====/etc/network/interfaces ======================

cat >>/etc/network/interfaces <<EOF
auto wg0
iface wg0 inet static
    address 10.0.0.1
    netmask 255.255.255.0
    pre-up ip link add dev wg0 type wireguard
    pre-up wg setconf wg0 /etc/wireguard/wg0.conf
    post-down ip link delete dev wg0
EOF


#接口启停(暂时用不到)
#ifup wg0
#ifdown wg0

#配置iptables

rc-update add iptables
iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F
service iptables save
service iptables start

#启用ip4路由
echo 1 > /proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.conf
