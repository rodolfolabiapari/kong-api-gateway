FROM node:10

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

ENV PROVISION_KEY="lEJ89HX0wrOtbYDE0tMuDcHqDrqDrDZZ"
ENV LISTEN_PORT=3000
ENV KONG_ADMIN="http://127.0.0.1:8001"
ENV KONG_API="https://127.0.0.1:8000"
ENV API_PATH="/httpbin"
ENV SERVICE_HOST="httpbin"
ENV SCOPES="{ \
  \"email\": \"Grant permissions to read your email address\", \
  \"address\": \"Grant permissions to read your address information\", \
  \"phone\": \"Grant permissions to read your mobile phone number\" \
}"


RUN npm install
# If you are building your code for production
# RUN npm ci --only=production

# Bundle app source
COPY . .

EXPOSE 3000

CMD [ "node", "app.js" ]

