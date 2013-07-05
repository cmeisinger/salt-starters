#This is a formula for installing mod_passenger on a CentOX 5/6 based machine.
#It will NOT work on any other distro. 

#This state requires the following Pillar data be available for the selected host.
#If passenger_version is < 3, it'll install the latest build of passenger 3.x
#apache-config:
#  passenger_version: 4.0.5
#rails:
#  rails_environment: (staging|production|integration)
#OPTIONAL PILLAR DATA:
#apache-config:
#  passenger_version: 3.0.19
#  passenger_max_requests:  500
#  passenger_use_global_queue: on
#  passenger_max_pool_size:  10
#  passenger_max_instances:  2


passenger:
  gem:
    - installed
    - runas: root
    - version: {{ pillar['apache-config']['passenger_version'] }}
    - watch:
      - pkg: ruby
    - require:
      - pkg: httpd-packages
      - pkg: ruby

bundle:
  gem:
    - installed
    - runas: root
    - watch:
      - pkg: ruby
    - require:
      - pkg: ruby

run-passenger-install-apache2-mod:
  cmd.run:
    - name:  PATH=/usr/local/bin:$PATH passenger-install-apache2-module -a
    - runas: root
    - cwd: /
{% if pillar['apache-config']['passenger_version'] < '4'  %}
    - unless: stat $(PATH=/usr/local/bin:$PATH passenger-config --root)/ext/apache2/mod_passenger.so
{% elif pillar['apache-config']['passenger_version'] >= '4' %}
    - unless: stat $(PATH=/usr/local/bin:$PATH passenger-config --root)/libout/apache2/mod_passenger.so
{% endif %}
    - require:
      - gem: passenger


/etc/httpd/conf.d/passenger.conf:
  file.managed:
    - source: salt://passenger/passenger.conf.tmpl
    - mode: 600
    - user: root
    - group: root
    - template: jinja
    - context:
    - require:
      - cmd: run-passenger-install-apache2-mod
