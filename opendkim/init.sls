# -*- coding: utf-8 -*-
# vim: ft=sls

include:
  - opendkim.install
  - opendkim.config
  - opendkim.service
  - opendkim.key
  {%- if pillar.get('opendkim:trustedhosts') is defined %}
  - opendkim.trustedhosts
  {%- endif %}
