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


#wireguard安装完成后，建议先在host上连网试机，没问题后，再运行容器：

#例如：

docker run -it --rm --cap-add net_admin --cap-add sys_module \
       -v /etc/wireguard:/etc/wireguard -v /lib/modules:/lib/modules \
       -p 5555:5555/udp alpine:edge
