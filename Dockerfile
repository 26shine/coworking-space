FROM python:3.10-slim-buster
WORKDIR /src

COPY ./analytics/requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY ./analytics .

ENV APP_PORT=5153
EXPOSE ${APP_PORT}

CMD python app.py