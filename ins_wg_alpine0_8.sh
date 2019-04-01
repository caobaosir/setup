echo 'http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/testing' >> /etc/apk/repositories
echo 'http://mirrors.tuna.tsinghua.edu.cn/alpine/edge/main' >> /etc/apk/repositories
apk update
apk add linux-virt wireguard-virt wireguard-tools iptables bash
mkdir /usr/src
mkdir /usr/src/run
cd /usr/src/run

cat >run0.sh<<EOF
#!/bin/sh
wg-quick up wg0
while true
do
sleep 1
done
EOF
chmod +x run0.sh

cat >run1.sh<<EOF
#!/bin/sh
wg-quick up wg1
while true
do
sleep 1
done
EOF
chmod +x run1.sh

cat >run2.sh<<EOF
#!/bin/sh
wg-quick up wg2
while true
do
sleep 1
done
EOF
chmod +x run2.sh

cat >run3.sh<<EOF
#!/bin/sh
wg-quick up wg3
while true
do
sleep 1
done
EOF
chmod +x run3.sh

cat >run4.sh<<EOF
#!/bin/sh
wg-quick up wg4
while true
do
sleep 1
done
EOF
chmod +x run4.sh


cat >run5.sh<<EOF
#!/bin/sh
wg-quick up wg5
while true
do
sleep 1
done
EOF
chmod +x run5.sh

cat >run6.sh<<EOF
#!/bin/sh
wg-quick up wg6
while true
do
sleep 1
done
EOF
chmod +x run6.sh


cat >run7.sh<<EOF
#!/bin/sh
wg-quick up wg7
while true
do
sleep 1
done
EOF
chmod +x run7.sh


cat >run8.sh<<EOF
#!/bin/sh
wg-quick up wg8
while true
do
sleep 1
done
EOF
chmod +x run8.sh

cat >run.sh<<EOF
#!/bin/sh
wg
while true
do
sleep 1
done
EOF
chmod +x run.sh



#end
