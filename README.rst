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

    $ bin/gunicorn --paste beta.ini

