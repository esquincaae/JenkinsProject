# Dockerfile para Auth Service
FROM node:18-alpine

# Definir ARG para APP_NAME que se puede pasar durante la construcción
ARG APP_NAME="User Service"
ARG JWT_SECRET="secret"

ARG DB_NAME="database"
ARG DB_USER="root"
ARG DB_PASSWORD="password"
ARG DB_HOST="localhost"
ARG DB_DIALECT="mysql"
ARG DB_PORT="3306"

# Establecer ENV a partir del ARG
ENV APP_NAME=${APP_NAME}
ENV JWT_SECRET=${JWT_SECRET}
ENV DB_NAME=${DB_NAME}
ENV DB_USER=${DB_USER}
ENV DB_PASSWORD=${DB_PASSWORD}
ENV DB_HOST=${DB_HOST}
ENV DB_DIALECT=${DB_DIALECT}
ENV PORT=${DB_PORT}

# Crear directorio de la aplicación
WORKDIR /usr/src/app

# Copiar package.json y package-lock.json
COPY package*.json ./

# Instalar dependencias
RUN npm install

# Copiar el código fuente
COPY . .

# Exponer el puerto (asumiendo que la aplicación usa el puerto 3000)
EXPOSE 3000

# Comando para iniciar la aplicación
CMD ["npm", "start"]
