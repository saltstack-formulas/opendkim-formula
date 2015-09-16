# -*- coding: utf-8 -*-
# vim: ft=sls

{% from "opendkim/map.jinja" import opendkim with context %}
{% set user, group = opendkim.conf.UserID.split(':') %}

{% for domainName, domain in opendkim.privateKey.key.items() %}
{{ opendkim.privateKey.directory }}/{{ domainName }}/:
  file.directory:
    - makedirs: true
    - mode: 750
    - user: {{ user }}
    - group: {{ group }}
  {% for selector, key in domain.items() %} 
{{ opendkim.privateKey.directory }}/{{ domainName }}/{{ selector }}.private:
  file.managed:
    - mode: 600
    - user: {{ user }} 
    - group: {{ group}}
    - contents: |
        {{ key | indent(8) }} 
  {% endfor %}
{% endfor %}

{% if 'manageKeyTable' in opendkim.privateKey and 'KeyTable' in opendkim.conf and opendkim.privateKey.manageKeyTable == true %}
{{ opendkim.conf.KeyTable }}:
  file.managed:
    - mode: 640
    - source: salt://opendkim/files/KeyTable.tmpl
    - user: {{ user }}
    - group: {{ group }}
    - template: 'jinja'
    - backup: minion
    - context:
        key: {{ opendkim.privateKey.key }}
        keyDirectory: {{ opendkim.privateKey.directory }}
        KeyTable: {{ opendkim.conf.KeyTable }}
{% endif %}

{% if 'manageSigningTable' in opendkim.privateKey and 'SigningTable' in opendkim.conf and opendkim.privateKey.manageSigningTable == true %}
{{ opendkim.conf.SigningTable }}:
  file.managed:
    - mode: 640
    - source: salt://opendkim/files/SigningTable.tmpl
    - user: {{ user }}
    - group: {{ group }}
    - template: 'jinja'
    - backup: minion
    - context:
        key: {{ opendkim.privateKey.key }}
        keyDirectory: {{ opendkim.privateKey.directory }}
{% endif %}

