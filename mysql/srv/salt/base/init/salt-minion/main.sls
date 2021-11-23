include:
  - init.yum.main

salt-minion:
  pkg.installed

/etc/salt/minion:
  file.managed:
    - source: salt://init/salt-minion/files/minion.j2
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja

salt-minion.servcie:
  service.running:
    - enable: true
