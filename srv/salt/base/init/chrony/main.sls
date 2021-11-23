chrony:
  pkg.installed

/etc/chrony.conf:
  file.managed:
    - source: salt://init/chrony/files/chrony.conf
    - user: root
    - group: root
    - mode: '0644'

chronyd.service:
  service.running:
    - enable: true
