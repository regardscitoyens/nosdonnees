# -*- coding: utf-8 -*-
from ckan.config.middleware import make_app
from . import licenses  # NOQA
import os

project_dir = os.path.dirname(os.path.dirname(__file__))


def nosdonnees(global_config, **local_config):
    # wrapper to hook the configuration
    local_config['ckan.site_logo'] = '/nosdonnees/nosdonnees.png'
    local_config['ckan.site_title'] = u'NosDonnées.fr'  # utf8 FTW
    local_config['ckan.locale_default'] = 'fr'

    filename = os.path.join(project_dir, 'md', 'about.md')
    with open(filename) as fd:
        local_config['ckan.site_about'] = fd.read()

    local_config['ckan.homepage_style'] = '1'  # templates/home/layout1.html

    local_config['extra_public_paths'] = os.path.join(project_dir, 'static')
    local_config['ckan.template_head_end'] = '''
        <link rel="stylesheet" href="/nosdonnees/nosdonnees.css" />
    '''

    if '/vagrant/' in global_config['__file__']:
        # you gonna dev
        local_config['ckan.site_url'] = u'http://www2.nosdonnees.fr'
    else:
        # prod
        local_config['ckan.site_url'] = u'http://www.nosdonnees.fr'
    print(local_config)
    return make_app(global_config, **local_config)
