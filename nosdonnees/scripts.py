# -*- coding: utf-8 -*-
import sys
import os


def apache():
    public = os.path.abspath('src/ckan/ckan/public/')
    directories = ''
    for name in sorted(os.listdir(public)):
        if os.path.isdir(os.path.join(public, name)):
            directories += '''
Alias /%(name)s/ %(public)s/%(name)s/
<Directory %(public)s/%(name)s/>
    Allow from all
    Options -Indexes
</Directory>
''' % dict(public=public, name=name)
        else:
            directories += '''
Alias /%(name)s %(public)s/%(name)s
''' % dict(public=public, name=name)

    if os.path.isfile('beta.ini'):
        site = 'beta'
        host = 'beta.nosdonnees.fr'
    else:
        site = 'ckanprod'
        host = 'www.nosdonnees.fr'
    conf = open('apache.in').read()

    print(conf % dict(
        directories=directories.strip(),
        site=site, host=host,
        public=public,
        script=os.path.abspath(sys.argv[0]),
        here=os.getcwd(),
    ))

apache()
