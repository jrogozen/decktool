const env = require('env-var');
const PrettyError = require('pretty-error');

const errorUtils = require('../../utils/errors');

const pretty = new PrettyError();
const logger = log.child({ name: 'middleware' });

pretty.skipNodeFiles();
pretty.skipPackage('express');

function logError(error, req, res, next) {
  const ignoredErrorCodes = ['ECONNABORTED'];

  const ignored = ignoredErrorCodes.includes(error.code);

  if (!ignored) {
    if (env.get('DEV').asBool()) {
      // eslint-disable-next-line no-console
      console.log(`\n${pretty.render(error)}`);
    }

    logger.error(errorUtils.formatForLog(error), 'error caught in express middleware');
  }

  next(error);
}

module.exports = logError;
