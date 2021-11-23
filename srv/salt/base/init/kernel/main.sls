/etc/sysctl.conf:
  file.managed:
    - source: salt://init/kernel/files/sysctl.conf
    - user: root
    - gorup: root
    - mode: '0644'

/etc/security/limits.conf:
  file.managed:
    - source: salt://init/kernel/files/limits.conf
    - user: root
    - gorup: root
    - mode: '0644'

'sysctl -p':
  cmd.run
