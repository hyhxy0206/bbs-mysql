include:
  - modules.database.mysql.install

/etc/my.cnf.d/slave.cnf:
  file.managed:
    - source: salt://modules/database/mysql/files/slave.cnf
    - user: root
    - group: root
    - mode: '0644'

slave-stop-mysql:
  service.dead:
    - name: mysqld.service

slave-start-mysql:
  service.running:
    - name: mysqld.service
