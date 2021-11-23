{% if grains['osmajorrelease'] == 8 %}
ncurses-compat-libs:
  pkg.installed
{% endif %}

{% if grains['osmajorrelease'] == 7 %}
libaio-devel:
  pkg.installed
{% endif %}

create-mysql-user:
  user.present:
    - name: mysql
    - system: true
    - createhome: fales
    - shell: /sbin/nologin

create_datadir:
  file.directory:
    - name: {{ pillar['data_dir'] }}
    - user: mysql
    - group: mysql
    - mode: '0755'
    - makedirs: true

create_my.cnf.d:
  file.directory:
    - name: /etc/my.cnf.d
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: true

unzip-mysql:
  archive.extracted:
    - name: {{ pillar['mysql_install_dir'] }}
    - source: salt://modules/database/mysql/files/mysql-{{ pillar['mysql_version'] }}-linux-glibc2.12-x86_64.tar.gz
    - if_missing: {{ pillar['mysql_install_dir'] }}/mysql-{{ pillar['mysql_version'] }}-linux-glibc2.12-x86_64

mysql-install:
  cmd.script:
    - name: salt://modules/database/mysql/files/install.sh.j2
    - unless: test -d {{ pillar['mysql_install_dir'] }}/mysql
    - template: jinja

trasfer-files:
  file.managed:
    - names:
      - /etc/my.cnf:
        - source: salt://modules/database/mysql/files/my.cnf.j2
      - {{ pillar['mysql_install_dir'] }}/mysql/support-files/mysql.server:
        - source: salt://modules/database/mysql/files/mysql.server
      - /usr/lib/systemd/system/mysqld.service:
        - source: salt://modules/database/mysql/files/mysqld.service.j2
    - require:
      - cmd: mysql-install
    - template: jinja

mysqld.service:
  service.running:
    - enable: true
    - reload: true
    - watch:
      - file: trasfer-files
