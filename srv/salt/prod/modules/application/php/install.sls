
dep-package-install:
  pkg.installed:
    - pkgs:
      - libxml2
      - libxml2-devel
      - openssl
      - openssl-devel
      - bzip2
      - bzip2-devel
      - libcurl
      - libcurl-devel
      - libicu-devel
      - libpng
      - libpng-devel
      - openldap-devel
      - pcre-devel
      - freetype
      - freetype-devel
      - gmp
      - gmp-devel
      - libmcrypt
      - libmcrypt-devel
      - readline
      - readline-devel
      - libxslt
      - libxslt-devel
      - mhash
      - mhash-devel
      - php-mysqlnd
      - libsqlite3x
      - libsqlite3x-devel
      - libzip-devel
      - libjpeg-turbo-devel 

/usr/src/oniguruma-devel-6.8.2-2.el8.x86_64.rpm:
  file.managed:
    - source: salt://modules/application/php/files/oniguruma-devel-6.8.2-2.el8.x86_64.rpm
    - user: root
    - group: root
    - mode: '0644'
  cmd.run:
    - name: yum install -y /usr/src/oniguruma-devel-6.8.2-2.el8.x86_64.rpm
    - unless: rpm -q oniguruma-devel

/usr/src/php-{{ pillar['php_version'] }}.tar.xz:
  file.managed:
    - source: salt://modules/application/php/files/php-{{ pillar['php_version'] }}.tar.xz
    - user: root
    - group: root
    - mode: '0644'

php-install:
  cmd.script:
    - name: salt://modules/application/php/files/install.sh.j2
    - unless: test -d {{ pillar['php_install_dir'] }}
    - template: jinja

copysoft:
  file.managed:
    - names:
      - /etc/init.d/php-fpm:
        - source: salt://modules/application/php/files/{{ pillar['php_num'] }}/php-fpm
        - user: root
        - group: root
        - mode: '0755'
      - {{ pillar['php_install_dir'] }}/etc/php-fpm.conf:
        - source: salt://modules/application/php/files/{{ pillar['php_num'] }}/php-fpm.conf
      - {{ pillar['php_install_dir'] }}/etc/php-fpm.d/www.conf:
        - source: salt://modules/application/php/files/{{ pillar['php_num'] }}/www.conf
      - /usr/lib/systemd/system/php-fpm.service:
        - source: salt://modules/application/php/files/php-fpm.service
    - require:
      - cmd: php-install

php-fpm.service:
  service.running:
    - enable: true
    - reload: true
    - require:
      - cmd: php-install
      - file: copysoft
    - watch:
      - file: copysoft  
