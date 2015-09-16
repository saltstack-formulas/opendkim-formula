# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "opendkim/map.jinja" import opendkim with context %}

opendkim-config:
  file.managed:
    - name: {{ opendkim.config }}
    - source: salt://opendkim/files/opendkim.tmpl
    - mode: 644
    - user: root
    - group: root
    - template: 'jinja'
    - backup: minion
    - context: 
        conf: {{ opendkim.conf }}
