# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "opendkim/map.jinja" import opendkim with context %}
{% set user, group = opendkim.conf.UserID.split(':') %}

opendkim-trustedhosts:
  file.managed:
    - name: {{ opendkim.conf.ExternalIgnoreList }}
    - mode: 644
    - user: {{ user }}
    - group: {{ group }}
    - template: 'jinja'
    - backup: minion
    - watch_in:
      - service: opendkim_service
    - require:
      - pkg: opendkim_packages 
    - contents: |
        {%- for host in opendkim.trustedhosts %}
        {{ host }}
        {%- endfor %}
