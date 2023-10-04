FROM python:3.11-slim-bullseye

RUN apt update && apt install -y nginx

# Move our nginx configuration to the standard nginx path
COPY files/nginx.conf /etc/nginx/nginx.conf

# Add our static files to a common folder to be provided by nginx
RUN mkdir -p /site /source
COPY files/register_service /site/register_service

# Copy everything for your application
COPY files/entrypoint.sh /entrypoint.sh

COPY source/app.py /source/app.py
COPY source/templates /source/templates
RUN pip install --user pyserial flask

# Add docker configuration
LABEL permissions='{\
  "ExposedPorts": {\
    "80/tcp": {}\
  },\
  "HostConfig": {\
    "Privileged": true,\
    "Binds": [\
      "/dev:/dev:rw"\
    ],\
    "PortBindings": {\
      "80/tcp": [\
        {\
          "HostPort": ""\
        }\
      ]\
    }\
  }\
}'
LABEL authors='[\
    {\
        "name": "John Doe",\
        "email": "john.doe@gmail.com"\
    }\
]'
LABEL company='{\
    "about": "This is just an example",\
    "name": "ACME Corporation",\
    "email": "acme@corporation.com"\
}'
LABEL readme="https://raw.githubusercontent.com/patrickelectric/blueos-extension-template/master/README.md"
LABEL type="example"
LABEL tags='[\
  "example"\
]'

ENTRYPOINT ["/entrypoint.sh"]