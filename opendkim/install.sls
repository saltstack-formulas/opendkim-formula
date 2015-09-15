# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "opendkim/map.jinja" import opendkim with context %}

opendkim-pkg:
  pkg.installed:
    - name: {{ opendkim.pkg }}
