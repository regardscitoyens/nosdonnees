# -*- coding: utf-8 -*-
from ckan.config.middleware import make_app
import os


def get_md(name):
    filename = os.path.join(
        os.path.dirname(os.path.dirname(__file__)),
        'md', name)
    with open(filename) as fd:
        return fd.read()


def nosdonnees(global_config, **local_config):
    # wrapper to hook the configuration
    local_config['ckan.site_title'] = u'Nos Données'  # utf8 FTW
    local_config['ckan.locale_default'] = 'fr'
    local_config['ckan.site_about'] = get_md('about.md')
    if '/vagrant/' in global_config['__file__']:
        # you gonna dev
        local_config['ckan.site_url'] = u'http://www2.nosdonnees.fr'
    else:
        # prod
        local_config['ckan.site_url'] = u'http://www.nosdonnees.fr'
    print(local_config)
    return make_app(global_config, **local_config)
