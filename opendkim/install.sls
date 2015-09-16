# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "opendkim/map.jinja" import opendkim with context %}

opendkim_packages:
  pkg.installed:
    - name: {{ opendkim.pkg }}
