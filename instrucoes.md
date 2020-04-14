# versoes
helm 3.1.1
kubectl v1.16.3
npm 3.5.2


# intalando o kong usando a mao (nao utilizar, utilizar docker)
```
helm repo add kong https://charts.konghq.com
helm repo update
helm search repo --versions
helm install kong kong/kong --version=1.2.0 --namespace=kong --set ingressController.installCRDs=false # helm 3.0.0+ specific
```

## instaling konga

Install npm and node.js. Instructions can be found here.

Install bower, ad gulp packages.

```
sudo apt install npm

sudo npm install -g bower
sudo npm install -g gulp

git clone https://github.com/pantsel/konga.git
cd konga
npm install # equal to npm i
```

## configure envs

```
vim .env_example 
mv .env_example to .env
```

# utilizando kong como container

Utilizar o compose

O kong estará disponível em http://localhost:8001/

O konga estará disponível em http://localhost:1337/


# Adicionando um novo service e route 

https://www.popularowl.com/api-first/kong-api-gateway-getting-started/