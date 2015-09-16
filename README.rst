================
opendkim-formula
================

A salt formula that installs and configures the opendkim milter. (see pillar.example).

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``opendkim``
------------
This does install, config, setup service and manage key.

``opendkim.install``
------------
Install opendkim package

``opendkim.config``
------------
Configure opendkim

``opendkim.service``
------------
Setup service

``opendkim.key``
------------
Manage private key. It can manage KeyTable and SigningTable by enabling in Pillar. (see pillar.example).
