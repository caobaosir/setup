FROM alpine:edge

RUN wget -O /tmp/go.sh https://raw.githubusercontent.com/caobaosir/setup/master/ins_wg_alpine.sh \
            chmod +rwx /tmp/go.sh \
            /tmp/go.sh

LABEL maintainer "alpine:edge install wireguard wg(x) for docker by caobaosir"


ENTRYPOINT ["/usr/src/run/run.sh"]

CMD []
