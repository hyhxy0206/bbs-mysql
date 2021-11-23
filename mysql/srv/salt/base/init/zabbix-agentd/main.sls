include:
  - init.basepkg.main

zabbix-user:
  user.present:
    - name: zabbix
    - shell: /sbin/nologin
    - system: true
    - createhome: false

/usr/src/zabbix-5.4.4.tar.gz:
  file.managed:
    - source: salt://init/zabbix-agentd/files/zabbix-5.4.4.tar.gz

agentd-install:
  cmd.script:
    - name: salt://init/zabbix-agentd/files/install.sh 
      unless: test -d /usr/local/etc/zabbix_agentd.conf.d

/usr/local/etc/zabbix_agentd.conf:
  file.managed:
    - source: salt://init/zabbix-agentd/files/zabbix_agentd.conf.j2
    - user: root
    - group: root
    - mode: '0644'
    - requitre:
      - cmd: agentd-install
    - template: jinja

/etc/init.d/zabbix_agentd:
  file.managed:
    - source: salt://init/zabbix-agentd/files/zabbix_agentd
    - user: root
    - group: root
    - mode: '0755'

'zabbix_agentd':
  cmd.run

'/etc/init.d/zabbix_agentd start':
  cmd.run

'chkconfig zabbix_agentd on':
  cmd.run
