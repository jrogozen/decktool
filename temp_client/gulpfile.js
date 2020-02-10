const log = require('fancy-log');
const c = require('ansi-colors');
const http = require('http');
const st = require('st');
const clear = require('clear');
const { parallel, watch } = require('gulp');
const { exec } = require('child_process');

let counter = 0;

const cmd = 'elm make ./src/Main.elm --output ./bundle.js';

function elm(cb) {
  if (counter > 0) {
    clear();
  }

  exec(cmd, (err, stdout, stderr) => {
    if (err) {
      log.error(c.red('elm make: '));

      console.log(c.red(stderr));
    } else {
      log(c.green('elm make: '));

      console.log(c.green(stdout));
    }

    cb();
  });

  counter += 1;
}

function server(cb) {
  log.info(c.green('starting server at http://localhost:4000'));
  http.createServer(
    st({
      path: __dirname,
      index: 'index.html',
      cache: false,
    }),
  ).listen(4000, cb);
}

function watchElm() {
  watch(['**/*.elm'], { ignoreInitial: false }, elm);
}


exports.default = parallel(watchElm, server);
