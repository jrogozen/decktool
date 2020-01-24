const Model = require('.');

class Card extends Model {
  constructor(args) {
    super(args);

    const {
      atk,
      atkConsequence,
      attributes,
      author,
      backgroundImageURL,
      cost,
      deckName,
      deckURL,
      def,
      description,
      foregroundImageURL,
      health,
      hitPoints,
      illustrator,
      notes,
      official,
      png,
      primaryColor,
      quote,
      resources,
      secondaryColor,
      setIconURL,
      setName,
      setPosition,
      subtitle,
      svg,
      tertiaryColor,
      thumbnail,
      thw,
      thwConsequence,
      title,
      type,
    } = args;

    this.title = Card.string(title);
    this.attributes = Card.string(attributes).split(',');
    this.subtitle = Card.string(subtitle);
    this.description = Card.string(description);

    this.meta = {

    };

    this.stats = {

    };

    this.colors = {

    };

    this.media = {

    };
  }
}
