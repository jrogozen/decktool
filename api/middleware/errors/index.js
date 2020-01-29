const logError = require('./logError');
const finalErrorResponseHtml = require('./finalErrorHtmlResponse');

function useErrorMiddleware(app) {
  app.use(logError);
  app.use(finalErrorResponseHtml);
}

module.exports = useErrorMiddleware;
