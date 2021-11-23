include:
  - modules.database.mysql.install

provides-mysql-file:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - names:
      - /etc/my.cnf:
        - source: salt://modules/lnmp/files/my.cnf
      - /etc/ld.so.conf.d/mysql.conf:
        - source: salt://modules/lnmp/files/mysql.conf

/usr/local/include/mysql:
  file.symlink:
    - target: {{ pillar['mysql_install_dir'] }}/include

mysqld.service:
  service.running:
    - enable: true
    - reload: true
    - require:
      - cmd: mysql-install
      - file: trasfer-files
    - watch:
      - file: provides-mysql-file

set-password:
  cmd.run:
    - name: {{ pillar['mysql_install_dir'] }}/bin/mysql -e "set password=password('{{ pillar['mysql_password'] }}');"
    - require:
      - service: mysqld.service
    - unless: {{ pillar['mysql_install_dir'] }}/bin/mysql -uroot -p{{ pillar['mysql_password'] }} -e " exit"
