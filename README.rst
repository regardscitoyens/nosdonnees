=================
www.nosdonnees.fr
=================

Deployment
==========

::

    $ git clone git@github.com:regardscitoyens/nosdonnees.git beta
    $ cd beta
    $ make venv


Create a config file::

    $ cp template.ini beta.ini

Change some values to fit your needs

Launch the server::

    $ bin/paster serve beta.ini

You can use the ``wsgi.py`` file to deploy your application with apache.

