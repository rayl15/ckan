#!/bin/sh
#make paster harvester source barnet open.barnet.gov.uk ckan
docker exec `docker ps | grep spatial | cut -d ' ' -f1` sh -c "cd /srv/app/src/ckan && paster --plugin=ckanext-harvest harvester source barnet https://open.barnet.gov.uk ckan -c /srv/app/production.ini"
make paster harvester run_test barnet
:
:
:
:
