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
      createdAt,
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
      updatedAt,
      views,
    } = args;

    this.title = Card.string(title);
    this.attributes = Card.string(attributes).split(',');
    this.subtitle = Card.string(subtitle);
    this.description = Card.string(description);
    this.notes = Card.string(notes);
    this.quote = Card.string(quote);
    this.setName = Card.string(setName);
    this.setPosition = Card.string(setPosition);
    this.belongsToHero = this.shouldBelongToHero();

    this.stats = {
      atk: Card.number(atk),
      atkConsequence: Card.number(atkConsequence),
      thw: Card.number(thw),
      thwConsequence: Card.number(thwConsequence),
      def: Card.number(def),
      health: Card.number(health),
      cost: Card.number(cost),
      hitPoints: Card.number(hitPoints),
      resources: Card.string(resources)
        .split(',')
        .map((resourceBlock) => {
          const resource = resourceBlock.split('=');

          return {
            type: resource[0],
            count: resource[1],
          };
        }),
    };

    this.colors = {
      primaryColor: Card.string(primaryColor),
      secondaryColor: Card.string(secondaryColor),
      tertiaryColor: Card.string(tertiaryColor),
    };
    this.setColors();

    this.media = {
      backgroundImageURL: Card.string(backgroundImageURL),
      foregroundImageURL: Card.string(foregroundImageURL),
      setIconURL: Card.string(setIconURL),
    };

    this.output = {
      svg: Card.string(svg),
      thumbnail: Card.string(thumbnail),
      png: Card.string(png),
    };

    this.meta = {
      author: Card.string(author),
      illustrator: Card.string(illustrator),
      deckURL: Card.string(deckURL),
      deckName: Card.string(deckName),
      official: Card.boolean(official),
      type: Card.string(type),
      views: Card.number(views),
      createdAt: this.createdAt.string(createdAt),
      updatedAt: this.updatedAt.string(updatedAt),
    };
  }

  shouldBelongToHero() {
    const { setName } = this;

    if (
      setName === 'justice'
      || setName === 'protection'
      || setName === 'basic'
      || setName === 'aggression'
      || setName === 'leadership') {
      return false;
    }

    return true;
  }

  setColors() {
    const {
      belongsToHero,
      setName,
    } = this;

    if (belongsToHero) {
      return;
    }

    if (setName === 'leadership') {
      this.colors.primary = '#69b6ca';
      this.colors.secondary = '#69b6ca';
      this.colors.tertiary = '#69b6ca';
    } else if (setName === 'justice') {
      this.colors.primary = '#a89b40';
      this.colors.secondary = '#a89b40';
      this.colors.tertiary = '#a89b40';
    } else if (setName === 'protection') {
      this.colors.primary = '#7db455';
      this.colors.secondary = '#7db455';
      this.colors.tertiary = '#7db455';
    } else if (setName === 'aggression') {
      this.colors.primary = '#923130';
      this.colors.secondary = '#923130';
      this.colors.tertiary = '#923130';
    }
  }
}

module.exports = Card;
