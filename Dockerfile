FROM python:3.10-slim-buster
WORKDIR /src

# Setup postgres env
ENV DB_USERNAME=$DB_USERNAME
ENV DB_PASSWORD=$DB_PASSWORD
ENV DB_NAME=$DB_NAME
ENV DB_HOST=$DB_HOST
ENV DB_PORT=$DB_PORT

COPY ./analytics/requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY ./analytics .
CMD python app.py