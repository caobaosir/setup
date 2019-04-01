#host:centos7

#先在宿主机安装wireguard驱动程序

sudo -i

curl -Lo /etc/yum.repos.d/wireguard.repo https://copr.fedorainfracloud.org/coprs/jdoss/wireguard/repo/epel-7/jdoss-wireguard-epel-7.repo

yum -y install epel-release

yum -y --enablerepo=epel install dkms wireguard-dkms wireguard-tools

#修改好/etc/wireguard/wg0.conf的虚拟网卡配置文件

mkdir /etc/wireguard

vi /etc/wireguard/wg0.conf

#此处放入配置文件文本




#修改好/etc/wireguard/wg1.conf的虚拟网卡配置文件
mkdir /etc/wireguard

vi /etc/wireguard/wg1.conf

#此处放入配置文件文本


++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

wg0  wg1 wg2 ..............wg8    共可以放0-8虚拟网卡配置文件

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++




#运行容器，例如：

docker run -d --rm --cap-add net_admin -v /etc/wireguard:/etc/wireguard -p 5555:5555/udp 容器名 /usr/src/run/run0.sh


结尾运行文件可以是 0-8  如:run4.sh

run.sh   默认加载wg0     runsleep.sh  不加载wgx只有循环sleep1
