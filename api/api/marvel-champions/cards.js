const express = require('express');

const Card = require('../../models/Card');
const DecktoolService = require('../../lib/DecktoolService');

const router = express.Router();
const logger = log.child({ name: 'marvel-champions' });

async function generate(req, res, next) {
  const card = new Card(req.body);

  logger.debug(card, 'registered card model to generate');

  if (!card.meta.type) {
    next(new Error('missing card type, cannot render card'));
  }

  try {
    const serviceResponse = await DecktoolService.render(card);

    res.writeHead(200, {
      'Content-Type': 'image/png',
      'Content-Length': serviceResponse.length,
    });

    res.end(serviceResponse);
  } catch (error) {
    next(error);
  }
}

router.post('/', generate);

module.exports = router;
