ROOT=/vagrant/root
CONFIG=/vagrant/development.ini
PASTER=$(ROOT)/bin/paster

deb:
	sudo aptitude -y update
	LC_ALL="$(LANG)" sudo aptitude -y install python-dev solr-tomcat postgresql postgresql-client postgresql-server-dev-all libpq5 python-virtualenv git-core

venv:
	virtualenv $(ROOT)
	$(ROOT)/bin/pip install -e 'git+https://github.com/okfn/ckan.git#egg=ckan'
	$(ROOT)/bin/pip install -r ckan/src/ckan/requirements.txt

solr:
	sudo rm /etc/solr/conf/schema.xml
	sudo ln -s $(ROOT)/src/ckan/ckan/config/solr/schema-2.0.xml /etc/solr/conf/schema.xml
	sudo service tomcat6 restart

user:
	LC_ALL="$(LANG)" sudo -u postgres createuser -S -D -R -P ckan_default

db:
	LC_ALL="$(LANG)" sudo -u postgres createdb -O ckan_default ckan_default -E utf-8

pg: user db

serve:
	$(PASTER) serve $(CONFIG)

update:
	cd $(ROOT)/src/ckan; $(PASTER) db clean --config=$(CONFIG)
	cd $(ROOT)/src/ckan; $(PASTER) db load --config=$(CONFIG) /vagrant/131007-nosdonnees_db.pg_dump

vagrant: deb venv solr
