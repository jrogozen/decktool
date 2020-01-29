const axios = require('axios');
const env = require('env-var');

const logger = log.child({ name: 'decktool-service' });

function DecktoolService() {
  async function render(card) {
    if (card.meta.type === 'MARVEL_CHAMPIONS:ALLY') {
      const body = card.toService();

      logger.debug(body, 'request body');

      return axios({
        method: 'POST',
        url: `${env.get('DECKTOOL_SERVICE_API').asString()}/marvel-champions/hero/ally`,
        data: body,
        responseType: 'arraybuffer',
      })
        .then((res) => res.data);
    }

    return Promise.resolve();
  }

  return {
    render,
  };
}

module.exports = DecktoolService();
