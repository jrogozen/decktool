const Card = require('../Card');

const mockCardQueryParams = {
  atk: 1,
  atkConsequence: 0,
  attributes: 'hero for hire',
  author: 'jon',
  backgroundImageUrl: 'background.png',
  cost: 3,
  createdAt: 'today',
  deckName: 'custom deck',
  deckUrl: 'deck.com',
  description: 'card has a unique effect',
  foregroundImageUrl: 'foreground.png',
  health: 2,
  primaryColor: 'red',
  quote: 'let\'s go together',
  resources: 'energy=1',
  secondaryColor: 'blue',
  setIconUrl: 'icon.png',
  setName: 'spider-man',
  setPosition: '1/15',
  subtitle: 'felicia',
  tertiaryColor: 'black',
  thw: 1,
  thwConsequence: 1,
  title: 'black cat',
  type: 'MARVEL_CHAMPIONS_ALLY',
  views: 1000,
};

const mockDatabaseParams = {
  atk: 1,
  atk_consequence: 0,
  attributes: 'hero for hire',
  author: 'jon',
  background_image_url: 'background.png',
  cost: 2,
  views: 1000,
};

let c;

describe('Card Model', () => {
  beforeEach(() => {
    c = new Card(mockCardQueryParams);
  });

  describe('static fromDatabase', () => {
    it('camelCases all args', () => {
      const toQuery = Card.fromDatabase(mockDatabaseParams);

      expect(toQuery.atkConsequence).toBe(0);
      expect(toQuery.backgroundImageUrl).toBe('background.png');
    });

    it('accepts sensitives args', () => {
      const toQuery = Card.fromDatabase(mockDatabaseParams);

      expect(toQuery.views).toBe(1000);
    });
  });

  it('creates a card', () => {
    expect(c.title).toBe('black cat');
  });

  it('creates nested values', () => {
    expect(c.stats.atk).toBe(1);
    expect(c.media.backgroundImageUrl).toBe('background.png');
  });

  describe('transforms to database format', () => {
    it('flattens obj', () => {
      const dbFormat = c.toDatabase();

      expect(dbFormat.health).toBe(2);
    });

    it('snake cases values', () => {
      const dbFormat = c.toDatabase();

      expect(dbFormat.background_image_url).toBe('background.png');
      expect(dbFormat.atk_consequence).toBe(0);
    });

    it('removes values', () => {
      const dbFormat = c.toDatabase();

      expect(dbFormat.views).toBeUndefined();
      expect(dbFormat.created_at).toBeUndefined();
      expect(dbFormat.updated_at).toBeUndefined();
    });
  });
});
