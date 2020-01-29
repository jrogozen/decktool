## local

- `docker build -t decktool_card_maker .`
- `docker run -p 9292:9292 -e PORT=9292 <image id>`

## heroku publish

- `heroku container:login`
- `heroku container:push web`
- `heroku container:release web`

## local thin

- `thin -R config.ru -a 127.0.0.01 -p 9292 start`

## dev mode

- `bundle exec guard -g server`