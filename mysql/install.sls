ncurses-compat-libs:
  pkg.installed

create-mysql-user:
  user.present:
    - name: mysql
    - system: true
    - createhome: fales
    - shell: /sbin/nologin

create_datadir:
  file.directory:
    - name: /opt/data
    - user: mysql
    - group: mysql
    - mode: '0755'
    - makedirs: true

unzip-mysql:
  archive.extracted:
    - name: /usr/local
    - source: salt://modules/database/mysql/files/mysql-{{ pillar['mysql_version'] }}-linux-glibc2.12-x86_64.tar.gz
    - if_missing: /usr/local/mysql-{{ pillar['mysql_version'] }}-linux-glibc2.12-x86_64

mysql-install:
  cmd.script:
    - name: salt://modules/database/mysql/files/install.sh.j2
    - unless: test -d {{ pillar['mysql_install_dir'] }}
    - template: jinja

trasfer-files:
  file.managed:
    - names:
      - {{ pillar['mysql_install_dir'] }}/support-files/mysql.server:
        - source: salt://modules/database/mysql/files/mysql.server
      - /usr/lib/systemd/system/mysqld.service:
        - source: salt://modules/database/mysql/files/mysqld.service.j2
    - require:
      - cmd: mysql-install
    - template: jinja
