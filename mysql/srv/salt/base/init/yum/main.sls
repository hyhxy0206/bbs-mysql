{% if grains['os'] == 'RedHat' %}
/etc/yum.repos.d/centos-{{ grains['osrelease'] }}.repo:
  file.managed:
    - source: salt://init/yum/files/centos-{{ grains['osrelease'] }}.repo
    - user: root
    - group: root
    - mode: '0644'
/etc/yum.repos.d/epel.repo:
  file.managed:
    - source: salt://init/yum/files/epel.repo
    - user: root
    - group: root
    - mode: '0644'
{% endif %}

{% if grains['os'] == 'CentOS' %}
epel-release:
  pkg.installed 
{% endif %}

/etc/yum.repos.d/salt-{{ grains['osrelease'] }}.repo:
  file.managed:
    - source: salt://init/yum/files/salt-{{ grains['osrelease'] }}.repo
    - user: root
    - group: root
    - mode: '0644'

