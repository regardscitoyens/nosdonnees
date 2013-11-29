# -*- coding: utf-8 -*-
from setuptools import setup, find_packages

version = '0.1'

setup(
    name='nosdonnees',
    version=version,
    author='Regard Citoyen',
    author_email='contact@regardcitoyens.fr',
    license='',
    url='',
    description='',
    keywords='data packaging component tool server',
    long_description='',
    zip_safe=False,
    packages=find_packages(exclude=['ez_setup']),
    entry_points='''
    [paste.app_factory]
    main = nosdonnees.ckan_wrapper:nosdonnees
    [console_scripts]
    nosdonnees-apache-vhost = nosdonnees.scripts:apache
    ''')
