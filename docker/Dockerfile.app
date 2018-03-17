# build with e.g. the following from the repo's root:
#   `docker build -f docker/Dockerfile.app -t example:latest --build-arg app_name=testapp .`

FROM python:3

EXPOSE 5000

WORKDIR /usr/src/app

COPY src/requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY src/ .

ARG app_name
ENV APP_NAME ${app_name}

CMD APP_NAME=$APP_NAME FLASK_APP=app.py flask run --host=0.0.0.0