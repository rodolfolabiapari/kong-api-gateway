# instala o curl jq e less para facilitar
apt update; apt install -y curl jq less

# define vars
export API_ADMIN_NAME="admin-api"
export API_ADMIN_HOSTNAME="localhost"
export API_ADMIN_PORT="8001"
export API_PORT="8000"
#for plugins
export CONSUMER_USER_NAME=rodolfo

# cria o servico e confere
curl -sX POST --url http://localhost:API_ADMIN_PORT/services \
  --data name=${API_ADMIN_NAME} \
  --data host=${API_ADMIN_HOSTNAME} \
  --data port=${API_ADMIN_PORT} | jq '.'

curl -sX GET --url http://localhost:API_ADMIN_PORT/services | jq '.'

# cria a rota e confere
curl -sX POST --url http://localhost:API_ADMIN_PORT/services/${API_ADMIN_NAME}/routes --data name=${API_ADMIN_NAME} --data "paths[]=/${API_ADMIN_NAME}" | jq '.'

curl -sX GET --url http://localhost:API_ADMIN_PORT/services/${API_ADMIN_NAME}/routes | jq '.'


#PAREI AQUI

################################
# tutorial: https://github.com/Kong/kong-oauth2-hello-world

# enabling the plugin on a service
curl -sX POST http://localhost:API_ADMIN_PORT/services/${API_ADMIN_NAME}/plugins --data "name=key-auth" | jq '.'

# Creating a consumer
curl -sd "username=${consumersUsername}&custom_id=${consumersUsername}" http://localhost:API_ADMIN_PORT/consumers/ | jq

# creating a key para que o usuario consiga acessar o admin
curl -sX POST http://localhost:API_ADMIN_PORT/consumers/${consumersUsername}/key-auth -d '' | jq

# using the key
curl http://kong:8000/{proxy path}?apikey=<some_key>

# konga
#nome=kong
#url="http://kong:8000/admin-api"
#key=key


############################
# pluging oauth2
# enable the oauth2
servico="httpbin"
scopes="email, phone, address"
application="application"
curl -sX POST http://localhost:API_ADMIN_PORT/services/${servico}/plugins \
    --data "name=oauth2"  \
    --data "config.scopes=${scopes}" \
    --data "config.mandatory_scope=true" \
    --data "config.enable_authorization_code=true" | jq

# getting the auto-generated provision_key, sera usado 
# dentro da aplicacao quando subir ela
provision_key=$(curl -sX GET --url http://localhost:API_ADMIN_PORT/services/httpbin/plugins | jq -r '.data[0].config.provision_key')

# chamando 8000 vai dar erro falando que nao tem token

# create a application que o usuario consiga acessar
curl -sX POST http://localhost:API_ADMIN_PORT/consumers/${consumersUsername}/oauth2 \
    --data "name=${application}" \
    --data "redirect_uris[]=http://${servico}/" | jq



########### 
# executando a applicacao web
