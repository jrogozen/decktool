const camel = require('lodash/camelCase');
const merge = require('lodash/merge');
const snake = require('lodash/snakeCase');

const Model = require('.');

/**
 * incoming from api req
 * const card = new Card(req.body)
 *
 * incoming from database
 * const card = new Card(Card.fromDatabase(data))
 *
 * saving to database
 * card.toDatabase()
 */
class Card extends Model {
  constructor(args) {
    super(args);

    const {
      atk,
      atkConsequence,
      attributes,
      author,
      backgroundImageUrl,
      cost,
      createdAt,
      deckName,
      deckUrl,
      def,
      description,
      foregroundImageUrl,
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
      setIconUrl,
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
      backgroundImageUrl: Card.string(backgroundImageUrl),
      foregroundImageUrl: Card.string(foregroundImageUrl),
      setIconUrl: Card.string(setIconUrl),
    };

    this.output = {
      svg: Card.string(svg),
      thumbnail: Card.string(thumbnail),
      png: Card.string(png),
    };

    this.meta = {
      author: Card.string(author),
      illustrator: Card.string(illustrator),
      deckUrl: Card.string(deckUrl),
      deckName: Card.string(deckName),
      official: Card.boolean(official),
      type: Card.string(type),
      views: Card.number(views),
      createdAt: Card.string(createdAt),
      updatedAt: Card.string(updatedAt),
    };
  }

  static fromDatabase(args) {
    const queryObj = {};

    Object.keys(args).forEach((k) => {
      queryObj[camel(k)] = args[k];
    });

    return queryObj;
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

  /**
   * transformations from internal model -> card_maker service
   */
  toService() {
    const {
      title,
      subtitle,
      colors,
      description,
    } = this;

    return {
      atk: this.stats.atk,
      atk_consequence: this.stats.atkConsequence,
      attributes: this.attributes.join(','),
      background_image_url: this.media.backgroundImageUrl,
      cost: this.stats.cost,
      description,
      primary_color: colors.primaryColor,
      quote: this.quote,
      resources: this.stats.resources.map((resource) => `${resource.type}=${resource.count}`).join(','),
      secondary_color: colors.secondaryColor,
      set_icon_url: this.media.setIconUrl,
      set_name: this.setName,
      set_position: this.setPosition,
      subtitle,
      tertiary_color: colors.tertiaryColor,
      thw: this.stats.thw,
      thw_consequence: this.stats.thwConsequence,
      title,
    };
  }

  /**
   * transformations from internal model -> database
   */
  toDatabase() {
    const {
      title,
      attributes,
      subtitle,
      description,
      notes,
      quote,
      setName,
      setPosition,
    } = this;
    const databaseObj = {};
    const nestedKeys = [this.colors, this.media, this.output, this.meta, this.stats];

    const flatObj = merge({
      title,
      attributes,
      subtitle,
      description,
      notes,
      quote,
      setName,
      setPosition,
    }, ...nestedKeys);

    nestedKeys.forEach((k) => {
      delete flatObj[k];
    });

    Object.keys(flatObj).forEach((k) => {
      databaseObj[snake(k)] = flatObj[k];
    });

    // handle values that need to be transformed into query-like syntax
    databaseObj.resources = databaseObj.resources.map((resource) => `${resource.type}=${resource.count}`).join(',');

    // delete values that shouldn't be put in database, unless explicit
    delete databaseObj.updated_at;
    delete databaseObj.created_at;
    delete databaseObj.views;

    return databaseObj;
  }
}

module.exports = Card;
