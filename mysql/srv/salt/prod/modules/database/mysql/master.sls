/etc/my.cnf.d/master.cnf:
  file.managed:
    - source: salt://modules/database/mysql/files/master.cnf
    - user: root
    - grour: root
    - mode: '0644'

master-stop-mysql:
  service.dead:
    - name: mysqld.service

master-start-mysql:
  service.running:
    - name: mysqld.service

