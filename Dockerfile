FROM docker.io/fedora:25
MAINTAINER Kazuhisa Hara <kazuhisya@gmail.com>

ENV TZ="JST-9" \
    MAINTAINER="Kazuhisa Hara <kazuhisya@gmail.com>" \
    NGINX_VERSION="1.11.6" \
    NGINX_RELEASE="1"

RUN dnf install -y --setopt=tsflags=nodocs \
    gcc \
    make \
    openssl-devel \
    pcre-devel \
    rpm-build
COPY / /nginx-fedora
RUN curl -OL http://nginx.org/packages/mainline/centos/7/SRPMS/nginx-${NGINX_VERSION}-${NGINX_RELEASE}.el7.ngx.src.rpm && \
    rpm -ivh ./nginx-${NGINX_VERSION}-${NGINX_RELEASE}.el7.ngx.src.rpm && \
    patch -u /root/rpmbuild/SPECS/nginx.spec /nginx-fedora/nginx-fedora.patch && \
    rpmbuild -ba /root/rpmbuild/SPECS/nginx.spec && \
    dnf install -y --setopt=tsflags=nodocs /root/rpmbuild/RPMS/x86_64/nginx-[^d.+].*
CMD ["nginx", "-T"]
