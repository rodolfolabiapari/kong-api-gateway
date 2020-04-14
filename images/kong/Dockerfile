FROM kong:2.0.1-ubuntu 

LABEL email="rodolfo.mansur@linuxplace.com.br"

LABEL owner="rodolfo labiapari mansur"

ENV API_ADMIN_NAME="admin-api"
ENV API_ADMIN_HOSTNAME="localhost"
ENV API_ADMIN_PORT="8001"

RUN apt update && apt install -y curl jq 

RUN curl -sX POST http://localhost:8001/services \
  --data name=${API_ADMIN_NAME} \
  --data host=${API_ADMIN_HOSTNAME} \
  --data port=${API_ADMIN_PORT} | jq '.'

RUN curl -s -X POST http://localhost:8001/services/${API_ADMIN_NAME}/routes --data name=${API_ADMIN_NAME} --data "paths[]=/${API_ADMIN_NAME}" | jq '.'
