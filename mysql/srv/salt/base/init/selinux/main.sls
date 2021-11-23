/etc/selinux/config:
  file.managed:
    - source: salt://init/selinux/files/config
    - user: root
    - group: root
    - mode: '0644'

setenforce 0:
  cmd.run:
    - name: setenforce0
