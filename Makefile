ROOT=`pwd`
CONFIG=$(ROOT)/development.ini
PASTER=$(ROOT)/bin/paster

test:
	echo $(ROOT)

deb:
	sudo aptitude -y update
	LC_ALL="$(LANG)" sudo aptitude -y install python-dev solr-tomcat postgresql postgresql-client postgresql-server-dev-all libpq5 python-virtualenv git-core

venv:
	virtualenv $(ROOT)
	$(ROOT)/bin/pip install --upgrade pip
	$(ROOT)/bin/pip install -e 'git+git@github.com:regardscitoyens/ckan.git@master#egg=ckan'
	$(ROOT)/bin/pip install -r src/ckan/requirements.txt
	$(ROOT)/bin/python setup.py develop
	$(ROOT)/bin/nosdonnees-apache-vhost

solr:
	sudo rm /etc/solr/conf/schema.xml
	sudo ln -s $(ROOT)/ckan/ckan/config/solr/schema-2.0.xml /etc/solr/conf/schema.xml
	sudo service tomcat6 restart

user:
	LC_ALL="$(LANG)" sudo -u postgres createuser -S -D -R -P ckan_default

db:
	LC_ALL="$(LANG)" sudo -u postgres createdb -O ckan_default ckan_default -E utf-8

pg: user db

serve:
	$(PASTER) serve $(CONFIG)

dev:
	$(PASTER) serve --reload $(CONFIG)

update:
	cd $(ROOT)/src/ckan; $(PASTER) db clean --config=$(CONFIG)
	cd $(ROOT)/src/ckan; $(PASTER) db load --config=$(CONFIG) $(ROOT)/131007-nosdonnees_db.pg_dump

vagrant: deb venv solr
