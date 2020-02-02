## decktool

### getting started

#### install dependencies

1. https://docs.docker.com/docker-for-mac/install/
2. `npm i -g n`
3. `n 10.16.3`

#### run the card_maker service

1. `docker build -t decktool_card_maker ./card_maker`
    - this will output a docker `<image id>`
2. `docker run -p 9292:9292 -e PORT=9292 <image id>`
3. `check `http://localhost:9292` is running

> when the docker daemon is running


#### set up the api

1. `cd /api`
2. `npm i`
3. `mkdir tools/env`
4. `touch tools/env/local.env`
5. add some default settings to the env file
    ```
    LOG_LEVEL=trace
    LOG_PRETTY=false
    PORT=3000
    DECKTOOL_SERVICE_API=http://localhost:9292
    ```
6. `npm run dev`
7. `curl -XPOST -H "Content-type: application/json" -d '{"type": "MARVEL_CHAMPIONS:ALLY" }' 'http://localhost:3000/api/v1/marvel-champions/card'`

### set up elm

1. `npm i -g elm elm-analyse elm-format elm-test elm-live`
2. install `elm` extension for vscode (elm tooling)