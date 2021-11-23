grant-slave:
  cmd.run:
    - name: {{ pillar['mysql_install_dir'] }}/mysql/bin/mysql -e "grant replication slave,super on *.* to 'repl'@'192.168.143.104' identified by 'repl123!';flush privileges;"
