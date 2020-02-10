const { parallel, watch } = require('gulp');
const gutil = require('gulp-util');
const http = require('http');
const st = require('st');
const { exec } = require('child_process');
const clear = require('clear');

let counter = 0;

const cmd = 'elm make ./src/Main.elm --output ./bundle.js';

function elm(cb) {
  if (counter > 0) {
    clear();
  }

  exec(cmd, (err, stdout, stderr) => {
    if (err) {
      gutil.log(gutil.colors.red('elm make: '), gutil.colors.red(stderr));
    } else {
      gutil.log(gutil.colors.green('elm make: '), gutil.colors.green(stdout));
    }

    cb();
  });

  counter += 1;
}

function server(cb) {
  gutil.log(gutil.colors.green('starting server at http://localhost:4000'));
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
