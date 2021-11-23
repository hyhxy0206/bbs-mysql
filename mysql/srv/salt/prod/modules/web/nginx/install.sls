dep-nginx:
  pkg.installed:
    - pkgs:
      - pcre-devel
      - openssl
      - openssl-devel
      - gd-devel
      - gcc
      - gcc-c++
      - make

nginx:
  user.present:
    - shell: /sbin/nologin
    - createhome: false
    - system: true

/var/log/nginx:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: '0755'
    - makedirs: True
    - recurse:
      - user
      - group

unzip-nginx:
  archive.extracted:
    - name: /usr/src
    - source: salt://modules/web/nginx/files/nginx-{{ pillar['nginx_version'] }}.tar.gz
    - if_missing: /usr/src/nginx-{{ pillar['nginx_version'] }}

/usr/lib/systemd/system/nginx.service:
  file.managed: 
    - source: salt://modules/web/nginx/files/nginx.service.j2
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja

nginx-install:
  cmd.script:
    - name: salt://modules/web/nginx/files/install.sh.j2
    - unless: test -d {{ pillar['install_nginx_dir'] }}
    - template: jinja

