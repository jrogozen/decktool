const helmet = require('helmet');

function useRequestSecurity(app) {
  app.use(helmet.dnsPrefetchControl());
  app.use(helmet.frameguard());
  app.use(helmet.hidePoweredBy());
  app.use(helmet.ieNoOpen());
  app.use(helmet.noSniff());
  app.use(helmet.xssFilter());
}

module.exports = useRequestSecurity;
