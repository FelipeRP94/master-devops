## Monolito en memoria

Ejecutar `kubectl apply -f .` para crear el pod y el servicio.

Para acceder a la aplicación, deberemos crear un port-forward hacia el servicio con el comando `kubectl port-forward svc/todo-app 8080:8080`.
