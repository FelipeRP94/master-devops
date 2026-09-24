# Reto 2: Dockerizar el Backend

El fichero Dockerfile ha sido generado usando el comando `docker init`.

Construcción de la imagen

```bash
 docker build -t calendar-backend:v1 .
```

Construcción del contenedor. Para ejecutar la imagen no ha sido necesario la variable de entorno HOST.

```bash
docker run -d \
    --name calendar-backend \
    -p 5000:5000 \
    --network calendar-app-network \
    -e DATABASE_URL=mongodb://admin:lemoncode@calendar-db:27017 \
    -e DATABASE_NAME=LemoncodeCourseDb \
    -e PORT=5000 \
    calendar-backend:v1
```

Peticiones al backend

![alt text](image.png)
