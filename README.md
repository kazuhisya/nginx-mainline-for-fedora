# nginx-mainline-for-fedora


| CI         | RPM        |
|:----------:|:----------:|
| [![Circle CI](https://circleci.com/gh/kazuhisya/nginx-mainline-for-fedora/tree/master.svg?style=shield)](https://circleci.com/gh/kazuhisya/nginx-mainline-for-fedora/tree/master) | [![FedoraCopr](https://copr.fedorainfracloud.org/coprs/khara/nginx-mainline-for-fedora/package/nginx/status_image/last_build.png)](https://copr.fedorainfracloud.org/coprs/khara/nginx-mainline-for-fedora/) |


This repository provides unofficial NGINX rpmbuild scripts for Fedora.

## Distro support

Tested working on:

- Fedora 25 x86_64

## Install

```bash
$ sudo dnf copr enable khara/nginx-mainline-for-fedora
$ sudo dnf install -y nginx
```

## Disclaimer

- This repository and all files that are included in this, there is no relationship at all with the upstream and vendor.

