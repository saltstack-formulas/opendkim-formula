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
    - watch_in:
      - service: opendkim_service
    - require:
      - pkg: opendkim_packages

{% for selector, key in domain.items() %} 

{{ opendkim.privateKey.directory }}/{{ domainName }}/{{ selector }}.private:
  file.managed:
    - mode: 600
    - user: {{ user }} 
    - group: {{ group}}
    - contents: |
        {{ key | indent(8) }} 
    - watch_in:
      - service: opendkim_service
    - require:
      - pkg: opendkim_packages

  {% endfor %}

{% endfor %}

{% if 'manageKeyTable' in opendkim and 'KeyTable' in opendkim.conf and opendkim.manageKeyTable == true %}

{%- if "refile" in opendkim.conf.KeyTable %}
{%- set type, filePath = opendkim.conf.KeyTable.split(':') %}
{%- else %}
{%- set filePath = opendkim.conf.KeyTable %}
{%- endif %}

{{ filePath }}:
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
    - watch_in:
      - service: opendkim_service
    - require:
      - pkg: opendkim_packages

{% endif %}

{% if 'manageSigningTable' in opendkim and 'SigningTable' in opendkim.conf and opendkim.manageSigningTable == true %}

{%- if "refile" in opendkim.conf.SigningTable %}
{%- set type, filePath = opendkim.conf.SigningTable.split(':') %}
{%- else %}
{%- set filePath = opendkim.conf.SigningTable %}
{%- endif %}

{{ filePath }}:
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
        SigningTable: {{ opendkim.conf.SigningTable }}
{%- if type is defined %}
        type: {{ type }}
{%- endif %}
    - watch_in:
      - service: opendkim_service
    - require:
      - pkg: opendkim_packages

{% endif %}

