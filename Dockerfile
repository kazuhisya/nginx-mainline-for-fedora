FROM docker.io/fedora:28
MAINTAINER Kazuhisa Hara <kazuhisya@gmail.com>

ENV TZ="JST-9" \
    MAINTAINER="Kazuhisa Hara <kazuhisya@gmail.com>" \
    NGINX_VERSION="1.15.0" \
    NGINX_RELEASE="1" \
    SRPM_DIST="el7_4.ngx"

RUN dnf install -y --setopt=tsflags=nodocs \
    gcc \
    make \
    compat-openssl10-devel \
    pcre-devel \
    rpm-build \
    redhat-lsb-core
COPY / /nginx-mainline-for-fedora
RUN curl -OL http://nginx.org/packages/mainline/centos/7/SRPMS/nginx-${NGINX_VERSION}-${NGINX_RELEASE}.${SRPM_DIST}.src.rpm && \
    rpm -ivh ./nginx-${NGINX_VERSION}-${NGINX_RELEASE}.${SRPM_DIST}.src.rpm && \
    patch -u /root/rpmbuild/SPECS/nginx.spec /nginx-mainline-for-fedora/nginx-fedora.patch && \
    cp /nginx-mainline-for-fedora/nginx-auto-cc-gcc.patch /root/rpmbuild/SOURCES && \
    rpmbuild -ba /root/rpmbuild/SPECS/nginx.spec && \
    dnf install -y --setopt=tsflags=nodocs /root/rpmbuild/RPMS/x86_64/nginx-[^d.+].* copr-cli
CMD ["nginx", "-T"]
