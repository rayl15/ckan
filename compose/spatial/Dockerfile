FROM fiware/ckan:latest

RUN apt-get install -y python-dev libxml2-dev libxslt1-dev libgeos-c1
RUN pip install -e "git+https://github.com/okfn/ckanext-spatial.git#egg=ckanext-spatial"
RUN pip install -r ${APP_DIR}/src/ckanext-spatial/pip-requirements.txt
RUN pip install -e "git+https://github.com/XVTSolutions/ckanext-spatialUI#egg=ckanext-spatialUI"
RUN find  / -name search.html -exec md5sum {} + | sort
RUN sed -i '${/^$/d;}' /srv/app/src/ckan/ckan/templates/package/search.html
RUN sed -i '$i {% snippet "spatial/snippets/spatial_query.html" %}' /srv/app/src/ckan/ckan/templates/package/search.html

#dcat
RUN pip install -e git+https://github.com/ckan/ckanext-dcat.git#egg=ckanext-dcat
RUN pip install -r ${APP_DIR}/src/ckanext-dcat/requirements.txt
