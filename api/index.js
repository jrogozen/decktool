const express = require('express');

require('./tools/loadEnv');
require('./utils/log');
require('./database');

const errorUtils = require('./utils/errors');
const useRequestSecurity = require('./middleware/generic/useRequestSecurity');
const useRequestId = require('./middleware/generic/useRequestId');
const useRequestParsers = require('./middleware/generic/useRequestParsers');
const useHttpLogger = require('./middleware/generic/useHttpLogger');
const useErrorMiddleware = require('./middleware/errors');

/** api route specific */
const marvelChampionsCardsRouter = require('./api/marvel-champions/cards');

const app = express();
const logger = log.child({ name: 'server' });
const CURRENT_API_VERSION = 'v1';

useRequestParsers(app);
useRequestId(app);
useRequestSecurity(app);
useHttpLogger(app);

app.use(`/api/${CURRENT_API_VERSION}/marvel-champions/cards`, marvelChampionsCardsRouter);

app.use('/check', (req, res) => res.send('ok!'));
app.use('/error', (req) => {
  const err = new Error('generated error');

  errorUtils.augmentError(err, { ...req.query, ...req.body });

  throw err;
});


useErrorMiddleware(app);

app.listen(process.env.PORT, () => {
  logger.warn('started on port=%s', process.env.PORT);
});
