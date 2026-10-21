# Monolito con base de datos en Kubernetes

Este ejemplo despliega una aplicación web Todo y una base de datos PostgreSQL en Kubernetes. La app se expone mediante un Service `LoadBalancer`; PostgreSQL solo es accesible dentro del clúster y guarda sus datos en un volumen persistente basado en un directorio del nodo.

![Diagrama de la infraestructura de la aplicación y PostgreSQL](./infraestructura.svg)

Para abrir la aplicación ejecuta el comando:

```powershell
kubectl port-forward svc/todo-app 8080:8080
```

Visita [http://localhost:8080](http://localhost:8080). El port-forward usa el puerto `8080` del Service y lo dirige al puerto `3000` del pod.

## Componentes y recorrido

| Componente                               | Función                                                                                                   |
| ---------------------------------------- | --------------------------------------------------------------------------------------------------------- |
| `app/todo-app` Deployment                | Ejecuta el contenedor de la aplicación en el puerto `3000`.                                               |
| `app/todo-app` Service                   | Expone la app en el puerto `8080` y reenvía tráfico al puerto `3000`. Está declarado como `LoadBalancer`. |
| `app/todo-app-cm` ConfigMap              | Proporciona configuración de ejecución y conexión a PostgreSQL.                                           |
| `database/todo-app-data-service` Service | Da a la app un nombre DNS interno estable y enruta al puerto `5432` de PostgreSQL.                        |
| `database/todo-app-data` StatefulSet     | Ejecuta una réplica de PostgreSQL.                                                                        |
| `database/todo-app-data-cm` ConfigMap    | Proporciona la contraseña inicial de PostgreSQL y otros parámetros.                                       |
| `database/todo-app-data-pvc` PVC         | Solicita `100Mi` de almacenamiento con la clase `todo-app-data-sc`.                                       |
| `database/todo-app-data-pv` PV           | Ofrece `100Mi` desde el directorio `/data/pv0001` del nodo.                                               |
| `database/todo-app-data-sc` StorageClass | Usa `kubernetes.io/no-provisioner`: el PV se crea manualmente, no de forma dinámica.                      |

El flujo de solicitudes es:

1. El navegador llega al Service `todo-app` por el puerto `8080`.
2. El Service reenvía la solicitud al pod de la aplicación por el puerto `3000`.
3. La aplicación se conecta a `todo-app-data-service:5432`.
4. PostgreSQL guarda sus archivos en `/var/lib/postgresql`, montado desde el PVC.
5. El PVC se enlaza con el PV, cuyo directorio del nodo es `/data/pv0001`.
