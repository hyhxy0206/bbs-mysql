include:
  - modules.web.apache.install

/usr/include/httpd:
  file.symlink:
    - target: {{ pillar['httpd_install_dir'] }}/include
    - require:
      - cmd: apache-install

{{ pillar['httpd_install_dir'] }}/htdocs:
  file.directory:
    - user: apache
    - group: apache
    - mode: '0755'
    - makedirs: True
    - require:
      - cmd: apache-install

{{ pillar['httpd_install_dir'] }}/htdocs/index.php:
  file.managed:
    - source: salt://modules/lamp/files/index.php
    - user: root
    - group: root
    - mode: '0644'
    - require:
      - cmd: apache-install

{{ pillar['httpd_install_dir'] }}/conf/extra/vhosts.conf:
  file.managed:
    - source: salt://modules/lamp/files/vhosts.conf
    - user: root
    - group: root
    - mode: '0644'
    - require:
      - cmd: apache-install

lamp-apache-service:
  service.running:
    - name: httpd
    - enable: true
    - reload: true
    - require:
      - file: {{ pillar['httpd_install_dir'] }}/conf/extra/vhosts.conf
    - watch:
      - file: {{ pillar['httpd_install_dir'] }}/conf/extra/vhosts.conf
