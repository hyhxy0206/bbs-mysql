include:
  - init.yum.main

base.packages:
  pkg.installed:
    - pkgs:
      - screen
      - tree 
      - psmisc
      - openssl
      - openssl-devel
      - telnet
      - iftop
      - iotop
      - sysstat
      - wget
      - dos2unix
      - lsof
      - net-tools
      - vim-enhanced
      - zip
      - unzip
      - bzip2
      - bind-utils
      - gcc
      - gcc-c++
      - glibc
      - make
      - autoconf
      - pcre-devel
      - libpsl
"Development Tools":
  pkg.group_installed
