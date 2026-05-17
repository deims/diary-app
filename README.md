Käyttöönotto Dockerilla
========================

- vaatimukset: docker, docker-compose
- kloonaa repo: `git clone git@github.com:deims/diary-app.git`
- rakenna kontit: `./build.sh` tai `docker-compose build --no-cache`
- aja kontit: `./start.sh` tai `docker-compose up -d`
- lopeta: `./stop.sh` tai `docker-compose down`

Käyttöönotto ilman Dockeria (dev)
=================================

- vaatimukset: sqlite, php, sqlite driver php:lle, composer, npm
- kloonaa repo: `git clone git@github.com:deims/diary-app.git`
- rakenna tietokanta:
    `cd diary-app/backend/database`
    `sqlite3 diary.db < schema.sql`
    `sqlite3 diary.db < seed.sql`
- asenna backendin riippuvuudet:
    `cd diary-app/backend/`
    `composer install`
- alusta frontend:
    `cd diary-app/diary`
    `npm install`
- muuta `diary-app/diary/src/api/index.js` tiedostossa
    ```
    const api = axios.create({
        //for dev
        //baseURL: 'http://localhost:8000/api',
        baseURL: '/api',
        headers: { 'Content-Type': 'application/json' }
    })
    ```
    tähän:
    ```
    const api = axios.create({
        //for dev
        baseURL: 'http://localhost:8000/api',
        //baseURL: '/api',
        headers: { 'Content-Type': 'application/json' }
    })
    ```
- käynnistä backend: `php -S localhost:8000 -t diary-app/backend/public`
- käynnistä frontend: `cd diary-app/diary && npm run dev`
