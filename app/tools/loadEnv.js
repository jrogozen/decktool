const appRootDir = require('app-root-dir');
const dotenv = require('dotenv');
const path = require('path');
const { bold } = require('chalk');
const { pointerSmall } = require('figures');

process.env.NODE_ENV = process.env.NODE_ENV || 'development';

const envType = process.env.ENV_TYPE || 'local';


const result = dotenv.config({
  path: path.resolve(
    appRootDir.get(),
    'tools',
    'env',
    `${envType}.env`,
  ),
});

if (result.error) {
  throw result.error;
}

function log(msg) {
  process.stdout.write(`${msg}\n`);
}

function logEnv(key) {
  log(`${pointerSmall} ${bold.cyan(key)}=${bold.blue(process.env[key])}`);
}

log(`\n${bold(pointerSmall)} ${bold('loading environment')}`);
Object.keys(result.parsed).forEach(logEnv);
log('\n');
