# Reto 1: MongoDB en Contenedor

Creacion de la red:

```bash
docker network create calendar-app-network
```

Montar la imagen de MongoDB establenciendo la red creada en el paso anterior. También se asigna el volumen calendar-data mapeando al directorio /data/db del contenedor donde Mongo aloja los datos. Por último se asigna el usuario y contraseña de root.

```bash
docker run -d --name calendar-db \
    --network calendar-app-network \
    --mount source=calendar-data,target=/data/db \
    -p 27017:27017 \
    -e MONGO_INITDB_ROOT_USERNAME=admin \
    -e MONGO_INITDB_ROOT_PASSWORD=lemoncode \
    mongo
```

Para conectar el backend de Node con la base de datos Mongo, en el fichero .env he indicado la siguiente cadena de conexión:

`DATABASE_URL=mongodb://admin:lemoncode@localhost:27017`

Una vez hecho esto, utilizando la extensión REST Client de VS Code he hecho diferentes peticiones al backend:

**Creando una clase:**

![alt text](create-class.png)

**Listando clases:**

![alt text](list-classes.png)

**Eliminando una clase:**

![alt text](delete-class.png)
