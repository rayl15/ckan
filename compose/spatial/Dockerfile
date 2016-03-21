FROM fiware/ckan:latest

RUN apt-get install -y python-dev libxml2-dev libxslt1-dev libgeos-c1
RUN pip install -e "git+https://github.com/okfn/ckanext-spatial.git#egg=ckanext-spatial"
RUN pip install -r ${APP_DIR}/src/ckanext-spatial/pip-requirements.txt
