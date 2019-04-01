echo 'http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/testing' >> /etc/apk/repositories
echo 'http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/main' >> /etc/apk/repositories
apk update
apk add linux-virt wireguard-virt wireguard-tools iptables bash
mkdir /usr/src
mkdir /usr/src/run
cd /usr/src/run

cat >run.sh<<EOF
#!/bin/sh
wg-quick up wg4
while true
do
sleep 1
done
EOF
chmod +x run.sh




#end
