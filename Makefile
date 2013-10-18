
deb:
	sudo aptitude update
	LC_ALL="$(LANG)" sudo aptitude install python-dev solr-tomcat postgresql postgresql-client postgresql-server-dev-all libpq5 python-virtualenv git-core

venv:
	virtualenv ckan
	cd ckan
	ckan/bin/pip install -e 'git+https://github.com/okfn/ckan.git#egg=ckan'
	ckan/bin/pip install -r ckan/src/ckan/requirements.txt

solr:
	sudo rm /etc/solr/conf/schema.xml
	sudo ln -s $(PWD)/ckan/src/ckan/ckan/config/solr/schema-2.0.xml /etc/solr/conf/schema.xml
	sudo service tomcat6 restart

user:
	LC_ALL="$(LANG)" sudo -u postgres createuser -S -D -R -P ckan_default

db:
	LC_ALL="$(LANG)" sudo -u postgres createdb -O ckan_default ckan_default -E utf-8

pg: user db

vagrant: deb venv solr
