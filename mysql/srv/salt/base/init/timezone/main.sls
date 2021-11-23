/etc/sysconfig/clock:
  file.managed:
    - source: salt://init/timezone/files/clock

rm -rf:
  cmd.run:
    - name: rm -rf /etc/localtime

/etc/localtime:
  file.symlink:
    - target: /usr/share/zoneinfo/Asia/Shanghai
