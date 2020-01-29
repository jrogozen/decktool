const env = require('env-var');
const knex = require('knex');
const knexConfig = require('../knexfile');

const appEnv = env.get('NODE_ENV').asString();

const config = knexConfig[appEnv];

knex(config);

module.exports = knex;
