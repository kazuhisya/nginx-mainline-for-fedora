FROM docker.io/fedora:25
MAINTAINER Kazuhisa Hara <kazuhisya@gmail.com>

ENV TZ="JST-9" \
    MAINTAINER="Kazuhisa Hara <kazuhisya@gmail.com>" \
    NGINX_VERSION="1.13.2" \
    NGINX_RELEASE="1"

RUN dnf install -y --setopt=tsflags=nodocs \
    gcc \
    make \
    openssl-devel \
    pcre-devel \
    rpm-build
COPY / /nginx-mainline-for-fedora
RUN curl -OL http://nginx.org/packages/mainline/centos/7/SRPMS/nginx-${NGINX_VERSION}-${NGINX_RELEASE}.el7.ngx.src.rpm && \
    rpm -ivh ./nginx-${NGINX_VERSION}-${NGINX_RELEASE}.el7.ngx.src.rpm && \
    patch -u /root/rpmbuild/SPECS/nginx.spec /nginx-mainline-for-fedora/nginx-fedora.patch && \
    cp /nginx-mainline-for-fedora/nginx-auto-cc-gcc.patch /root/rpmbuild/SOURCES && \
    rpmbuild -ba /root/rpmbuild/SPECS/nginx.spec && \
    dnf install -y --setopt=tsflags=nodocs /root/rpmbuild/RPMS/x86_64/nginx-[^d.+].* copr-cli
CMD ["nginx", "-T"]
