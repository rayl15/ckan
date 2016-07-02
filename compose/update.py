#!/bin/env python
import pip
from subprocess import call

for dist in pip.get_installed_distributions():
    if 'ckanext' in dist.project_name:
        call("pip install --upgrade " + dist.project_name, shell=True)
