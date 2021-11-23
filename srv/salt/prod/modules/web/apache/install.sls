apache-dep-package:
  pkg.installed:
    - pkgs:
      - epel-release
      - openssl-devel
      - pcre-devel
      - expat-devel
      - libtool
      - gcc
      - gcc-c++
      - make

apache:
  user.present:
    - shell: /sbin/nologin
    - createhome: false
    - system: true

unzip-httpd:
  archive.extracted:
    - name: /usr/src
    - source: salt://modules/web/apache/files/httpd-{{ pillar['httpd_version'] }}.tar.gz
    - if_missing: /usr/src/httpd-{{ pillar['httpd_version'] }}

unzip-apr:
  archive.extracted:
    - name: /usr/src
    - source: salt://modules/web/apache/files/apr-{{ pillar['apr_version'] }}.tar.gz
    - if_missing: /usr/src/apr-{{ pillar['apr_version'] }}

unzip-apr-util:
  archive.extracted:
    - name: /usr/src
    - source: salt://modules/web/apache/files/apr-util{{ pillar['apr-util_version'] }}.tar.gz
    - if_missing: /usr/src/apr-util-{{ pillar['apr-util_version'] }}

apache-download:
  file.managed:
    - names:
      - /usr/lib/systemd/system/httpd.service:
        - source: salt://modules/web/apache/files/httpd.service.j2
    - template: jinja
 
apache-install:
  cmd.script:
    - name: salt://modules/web/apache/files/install.sh.j2
    - unless: test -d {{ pillar['httpd_install_dir'] }}
    - template: jinja

{{ pillar['httpd_install_dir'] }}/conf/httpd.conf:
  file.managed:
    - source: salt://modules/web/apache/files/httpd.conf
    - user: root
    - group: root
    - mode: '0644'
    - require:
      - cmd: apache-install
