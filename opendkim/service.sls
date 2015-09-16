# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "opendkim/map.jinja" import opendkim with context %}

opendkim_service:
  service.running:
    - name: {{ opendkim.service.name }}
    - enable: True
