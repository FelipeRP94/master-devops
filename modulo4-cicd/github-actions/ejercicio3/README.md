# Ejercicio 3: Ejecucion de tests E2E con GitHub Actions

En este ejercicio hemos creado un workflow de GitHub Actions para levantar la aplicacion Hangman y ejecutar sus tests end-to-end (E2E) con Cypress.

- **Workflow:** [`e2e.yml`](./e2e.yml)
- **Workflow original:** [`.github/workflows/e2e.yml`](https://github.com/FelipeRP94/bootcamp-devops-lemoncode/blob/master/.github/workflows/e2e.yml)
- **Ejecucion de prueba:** [ver ejecucion del workflow](https://github.com/FelipeRP94/bootcamp-devops-lemoncode/actions/runs/45012547726/job/137177832188)

## Activacion del workflow

El workflow se activa manualmente con `workflow_dispatch` o automaticamente cuando se produce un `push` o un `pull_request` sobre la rama `master`. En los tres casos, solo se ejecuta si existen cambios dentro de `03-cd/03-github-actions/.start-code/**`.

## Flujo de ejecucion

El job `e2e` se ejecuta en un runner con Ubuntu y realiza estas acciones:

1. Descarga el repositorio mediante `actions/checkout`.
2. Ejecuta `docker compose -f compose-e2e.yml up --build -d` para construir y levantar los servicios definidos para las pruebas E2E. El fichero [`compose-e2e.yml`](https://github.com/FelipeRP94/bootcamp-devops-lemoncode/blob/master/03-cd/03-github-actions/.start-code/compose-e2e.yml) contiene la configuracion de los servicios necesarios para levantar el proyecto Hangman.
3. Espera 10 segundos para dar tiempo a que los servicios esten disponibles.
4. Ejecuta Cypress con `cypress-io/github-action@v7`, indicando como directorio de trabajo `03-cd/03-github-actions/.start-code/hangman-e2e/e2e`.

La ejecucion de ejemplo finalizo correctamente en 1 minuto y 19 segundos.