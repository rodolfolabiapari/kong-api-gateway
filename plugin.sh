# tutorial: https://github.com/Kong/kong-oauth2-hello-world

############################
# Plugin key-auth
port=8000
adminPort=8001
host=localhost
adminHost=localhost
pathBase="admin-api"
service="admin-api" #can be name or id
consumersUsername=rodolfo

# enabling the plugin on a service
curl -sX POST http://localhost:8001/services/${service}/plugins --data "name=key-auth" | jq

# Creating a consumer
curl -sd "username=${consumersUsername}&custom_id=${consumersUsername}" http://localhost:8001/consumers/ | jq

# creating a key para que o usuario consiga acessar o admin
curl -sX POST http://localhost:8001/consumers/${consumersUsername}/key-auth -d '' | jq

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
curl -sX POST http://localhost:8001/services/${servico}/plugins \
    --data "name=oauth2"  \
    --data "config.scopes=${scopes}" \
    --data "config.mandatory_scope=true" \
    --data "config.enable_authorization_code=true" | jq

# getting the auto-generated provision_key, sera usado 
# dentro da aplicacao quando subir ela
provision_key=$(curl -sX GET --url http://localhost:8001/services/httpbin/plugins | jq -r '.data[0].config.provision_key')

# chamando 8000 vai dar erro falando que nao tem token

# create a application que o usuario consiga acessar
curl -sX POST http://localhost:8001/consumers/${consumersUsername}/oauth2 \
    --data "name=${application}" \
    --data "redirect_uris[]=http://${servico}/" | jq



########### 
# executando a applicacao web
