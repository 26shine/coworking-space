FROM python:3.10-slim-buster
WORKDIR /src

# Get value from pod
ARG DB_NAME
ARG DB_HOST
ARG DB_PORT
ARG DB_USERNAME
ARG DB_PASSWORD

# Set env for project
ENV DB_NAME=$DB_NAME
ENV DB_HOST=$DB_HOST
ENV DB_PORT=$DB_PORT
ENV DB_USERNAME=$DB_USERNAME
ENV DB_PASSWORD=$DB_PASSWORD

COPY ./analytics/requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY ./analytics .

ENV APP_PORT=5153
EXPOSE ${APP_PORT}

CMD python app.py