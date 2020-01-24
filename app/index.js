const express = require('express');

require('./tools/loadEnv');
require('./utils/log');
require('./database');

const errorUtils = require('./utils/errors');
// const secureRequest = require('./middleware/generic/secureRequest');
// const setRequestId = require('./middleware/generic/setRequestId');
// const useRequestParsers = require('./middleware/generic/useRequestParsers');
// const useHttpLogger = require('./middleware/generic/useHttpLogger');
// const useErrorMiddleware = require('./middleware/errors');

const app = express();
const logger = log.child({ name: 'server' });

app.use('/check', (req, res) => res.send('ok!'));
app.use('/error', (req) => {
  const err = new Error('generated error');

  errorUtils.augmentError(err, { ...req.query, ...req.body });

  throw err;
});

app.listen(process.env.PORT, () => {
  logger.warn('started on port=%s', process.env.PORT);
});
