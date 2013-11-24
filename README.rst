=================
www.nosdonnees.fr
=================

What is it ?
============

This package is a set of customisation of ckan for nosdonnees.fr:

- paste entry point to override some config values on the fly
  ``nosdonnees/ckan_wrapper.py``

- ``templates/``

- ``static/``

And a ``Makefile`` to easily create an instance

Deployment
==========

First checkout the code and create a virtualenv for your instance::

    $ git clone git@github.com:regardscitoyens/nosdonnees.git beta
    $ cd beta
    $ make venv

Create a config file::

    $ cp template.ini beta.ini

Change some values to fit your needs

Launch the server::

    $ bin/paster serve beta.ini

You can use the ``wsgi.py`` file to deploy your application with apache.

Check that it work outside a virtualenv::

    $ /usr/bin/python wsgi.py

