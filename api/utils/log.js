const isEmpty = require('lodash/isEmpty');
const env = require('env-var');
const pino = require('pino');
const path = require('path');
const stream = require('stream');
const { spawn } = require('child_process');


const cwd = process.cwd();
const logThrough = new stream.PassThrough();
const level = env.get('LOG_LEVEL').asString();
const logPath = env.get('LOG_PATH').asString();
const pretty = env.get('LOG_PRETTY').asBool();

class LogFactory {
  constructor() {
    this.pino = LogFactory.createBaseLogger();
    this.children = {};
  }

  static createBaseLogger() {
    const log = pino({
      name: process.env.APP_NAME,
      env: process.env.NODE_ENV,
      level,
      safe: true,
    }, logThrough);

    if (logPath) {
      const child = spawn(
        process.execPath,
        [
          require.resolve('pino-tee'),
          'debug', `${logPath}/debug.log`,
          'warn', `${logPath}/warn.log`,
          'error', `${logPath}/error.log`,
          'fatal', `${logPath}/fatal.log`,
        ],
        { cwd, env: process.env },
      );

      logThrough.pipe(child.stdin);
    }

    if (process.env.GCLOUD_PROJECT) {
      const pinoStackdriverPath = path.resolve(
        __dirname,
        '..',
        'node_modules/pino-stackdriver/src/cli.js',
      );

      const child = spawn(
        process.execPath,
        [
          require.resolve(pinoStackdriverPath),
          '-p', process.env.GCLOUD_PROJECT,
          '-c', process.env.STACKDRIVER_ACCOUNT_PATH,
        ],
        { cwd, env: process.env },
      );

      logThrough.pipe(child.stdin);
    }

    if (pretty) {
      const pinoPrettyPath = path.resolve(
        __dirname,
        '..',
        'node_modules/pino-pretty/bin.js',
      );

      const child = spawn(
        process.execPath,
        [require.resolve(pinoPrettyPath), '-c'],
        { cwd, env: process.env },
      );

      logThrough.pipe(child.stdin);

      // child pretty process -> original process stdout (terminal)
      child.stdout.pipe(process.stdout);
    } else {
      logThrough.pipe(process.stdout);
    }

    return log;
  }

  child(bindings) {
    if (isEmpty(bindings) || typeof bindings !== 'object' || !bindings.name) {
      this.pino.error('cannot create a child logger without a name');
      return false;
    }

    if (this.children[bindings.name]) {
      this.pino.trace(`returning existing child logger with name=${bindings.name}`);

      return this.children[bindings.name];
    }

    this.pino.trace(`creating pino child logger with name=${bindings.name}`);

    const logger = this.pino.child(bindings);

    this.children[bindings.name] = logger;

    return logger;
  }
}

const log = new LogFactory();

global.log = log;
