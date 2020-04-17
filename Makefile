ROOT=`pwd`
CONFIG=$(ROOT)/development.ini
PASTER=$(ROOT)/bin/paster

deb:
	sudo aptitude -y update
	LC_ALL="$(LANG)" sudo aptitude -y install python-dev solr-tomcat postgresql postgresql-client postgresql-server-dev-all libpq5 python-virtualenv git-core

venv/bin/python:
	virtualenv -p python2 $(ROOT)
	$(ROOT)/bin/pip install --upgrade pip
	$(ROOT)/bin/pip install -e 'git+git@github.com:regardscitoyens/ckan.git@master#egg=ckan'
	$(ROOT)/bin/pip install -r src/ckan/requirements.txt
	$(ROOT)/bin/pip install -r src/ckan/dev-requirements.txt
	$(ROOT)/bin/python setup.py develop
	$(ROOT)/bin/nosdonnees-apache-vhost

venv: venv/bin/python

solr:
	sudo rm /etc/solr/conf/schema.xml
	sudo ln -s $(ROOT)/src/ckan/ckan/config/solr/schema-2.0.xml /etc/solr/conf/schema.xml
	sudo service tomcat6 restart

user:
	LC_ALL="C" sudo -u postgres createuser -S -D -R -P ckan_default; true
	LC_ALL="C" sudo -u postgres createuser -S -D -R -P datastore_default; true

pg: solr user
	LC_ALL="C" sudo -u postgres createdb -O ckan_default ckan_default -E utf-8; true
	cd src/ckan; LC_ALL="C" /vagrant/bin/paster db clean -c /vagrant/development.ini
	cd src/ckan; LC_ALL="C" /vagrant/bin/paster db load -c /vagrant/development.ini /vagrant/131007-nosdonnees_db.pg_dump


clean:
	LC_ALL="C" sudo -u postgres dropdb ckan_test; true
	LC_ALL="C" sudo -u postgres dropdb datastore_test; true
	LC_ALL="C" sudo -u postgres dropdb datastore_default; true


test: solr user
	LC_ALL="C" sudo -u postgres createdb -O ckan_default ckan_test -E utf-8
	LC_ALL="C" sudo -u postgres createdb -O ckan_default datastore_test -E utf-8
	cd src/ckan; LC_ALL="C" paster datastore set-permissions postgres -c test-core.ini
	cd src/ckan; LC_ALL="C" nosetests --ckan --with-pylons=test-core.ini ckan ckanext

serve:
	$(PASTER) serve $(CONFIG)

dev:
	$(PASTER) serve --reload $(CONFIG)

update:
	cd $(ROOT)/src/ckan; $(PASTER) db clean --config=$(CONFIG)
	cd $(ROOT)/src/ckan; $(PASTER) db load --config=$(CONFIG) $(ROOT)/131007-nosdonnees_db.pg_dump

vagrant: deb venv solr
