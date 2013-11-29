# -*- coding: utf-8 -*-
from glob import glob
import os

instance_dir = os.path.dirname(os.path.abspath(__file__))

# auto detect config file
invalids = ['development.ini', 'template.ini', 'who.ini']
filenames = glob(os.path.join(instance_dir, '*.ini'))
filenames = [f for f in filenames if os.path.basename(f) not in invalids]
# you can force it
# filenames = [os.path.join(instance_dir, 'beta.ini')]


if not filenames:
    raise OSError((
        'No .ini file found. Please add one based on template.ini. '
        'See README.rst'))

if len(filenames) > 1:
    raise OSError((
        'You have more than one possible .ini file. '
        'Please remove useless files in %s') % ','.join(filenames))

bin_dir = os.path.join(instance_dir, 'bin')
activate_this = os.path.join(bin_dir, 'activate_this.py')
execfile(activate_this, dict(__file__=activate_this))

from paste.deploy import loadapp
from paste.script.util.logging_config import fileConfig

config_file = filenames[0]

fileConfig(config_file)
application = loadapp('config:%s' % config_file)
