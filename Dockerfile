# syntax=docker/dockerfile:1

FROM python:3-alpine AS build

WORKDIR /opt/pterodactyl_exporter/build

ADD . /opt/pterodactyl_exporter/build

RUN pip3 install --user .




FROM python:3-alpine

RUN mkdir -p /opt/pterodactyl_exporter/config

WORKDIR /opt/pterodactyl_exporter/app

COPY --from=build /root/.local /root/.local

EXPOSE 9531

ENV PATH=/root/.local/bin:$PATH

CMD [ "pterodactyl_exporter", "--config-file=/opt/pterodactyl_exporter/config/config.yml" ]
