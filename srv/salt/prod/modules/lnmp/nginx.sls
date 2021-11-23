include:
  - modules.web.nginx.install

{{ pillar['install_nginx_dir'] }}/html/index.php:
  file.managed:
    - source: salt://modules/lnmp/files/index.php
    - user: root
    - group: root
    - mode: '0644'
    - require:
      - cmd: nginx-install

{{ pillar['install_nginx_dir'] }}/conf/nginx.conf:
  file.managed:
    - source: salt://modules/lnmp/files/nginx.conf.j2
    - user: root
    - group: root
    - mode: '0644'
    - require:
      - cmd: nginx-install
    - template: jinja

lnmp-nginx-service:
  service.running:
    - name: nginx
    - enable: true
    - reload: true
    - require:
      - file: {{ pillar['install_nginx_dir'] }}/conf/nginx.conf
    - watch:
      - file: {{ pillar['install_nginx_dir'] }}/conf/nginx.conf
