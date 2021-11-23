include:
  - modules.database.mysql.install

provides-mysql-file:
  file.managed:
    - user: root
    - group: root
    - mode: '0644'
    - names:
      - /etc/ld.so.conf.d/mysql.conf:
        - source: salt://modules/lamp/files/mysql.conf

{{ pillar['mysql_install_dir'] }}/include/mysql:
  file.symlink:
    - target: {{ pillar['mysql_install_dir'] }}/mysql/include


set-password:
  cmd.run:
    - name: {{ pillar['mysql_install_dir'] }}/mysql/bin/mysql -e "set password=password('{{ pillar['mysql_password'] }}');"
    - require:
      - service: mysqld.service
    - unless: {{ pillar['mysql_install_dir'] }}/mysql/bin/mysql -uroot -p{{ pillar['mysql_password'] }} -e " exit"
