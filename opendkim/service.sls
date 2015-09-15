# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "opendkim/map.jinja" import opendkim with context %}

opendkim-name:
  service.running:
    - name: {{ opendkim.service.name }}
    - enable: True
