# -*- coding: utf-8 -*-
from ckan.model import license
from ckan.common import _


class LicenseOuverte(license.DefaultLicense):
    domain_content = True
    id = "fr-lo"
    is_okd_compliant = True
    url = "http://www.data.gouv.fr/license-Ouverte-Open-license"

    @property
    def title(self):
        return _("French license Ouverte (LO/OL)")


class LicenseFreeArt(license.DefaultLicense):
    domain_content = True
    id = "lal"
    is_okd_compliant = True
    url = "http://artlibre.org/license/lal/en"

    @property
    def title(self):
        return _("Free Art License")


class LicenseAPIE(license.DefaultLicense):
    id = "fr-apie"
    url = "https://www.apiefrance.fr/sections/acces_thematique/reutilisation-des-informations-publiques/license-type"

    @property
    def title(self):
        return _("French APIE License (Not Open)")


LicenseRegister_create_license_list = \
    license.LicenseRegister._create_license_list


def _create_license_list(self, license_data, license_url=''):
    license_data.extend([LicenseOuverte(), LicenseFreeArt(), LicenseAPIE()])
    return LicenseRegister_create_license_list(self, license_data, license_url)

license.LicenseRegister._create_license_list = _create_license_list
