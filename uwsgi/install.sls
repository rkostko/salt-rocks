include:
  - python

/usr/local/bin/uwsgi-pip-wrapper:
  file.managed:
    - source: salt://uwsgi/files/uwsgi-pip-wrapper
    - mode: 0655

uwsgi-installer:
  cmd.run:
    - name: /usr/local/bin/uwsgi-pip-wrapper
    - stateful: true
    - require:
      - file: /usr/local/bin/uwsgi-pip-wrapper
      - pkg: uwsgi-pkg-uninstalled
      - pkg: uwsgi-requirements

uwsgi-pkg-uninstalled:
  pkg:
    - removed
    - pkgs:
      - uwsgi
      - uwsgi-core
      - uwsgi-plugin-python

uwsgi-requirements:
  pkg:
    - installed
    - pkgs:
      - zlib1g-dev

uwsgitop-install:
  pip:
    - name: uwsgitop
    - installed
    - require:
      - cmd: uwsgi-installer
