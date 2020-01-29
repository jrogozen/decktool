
exports.up = function (knex) {
  return knex.schema.createTable('cards', (table) => {
    table.increments('id');
    table.timestamp('created_at').defaultTo(knex.fn.now());
    table.timestamp('updated_at').defaultTo(knex.fn.now());
    table.integer('atk');
    table.integer('atk_consequence');
    table.string('attributes');
    table.string('author').defaultTo('decktool.app');
    table.string('background_image_url');
    table.string('cost');
    table.string('deck_name');
    table.string('deck_url');
    table.integer('def');
    table.string('description');
    table.string('foreground_image_url');
    table.integer('health');
    table.integer('hit_points');
    table.string('illustrator');
    table.string('notes');
    table.boolean('official');
    table.string('png');
    table.string('primary_color');
    table.string('quote');
    table.string('resources');
    table.string('secondary_color');
    table.string('set_icon_url');
    table.string('set_name');
    table.string('set_position');
    table.string('subtitle');
    table.string('svg');
    table.string('tertiary_color');
    table.string('thumbnail');
    table.integer('thw');
    table.integer('thw_consequence');
    table.string('title').notNullable();
    table.string('type').notNullable();
    table.bigInteger('views').defaultTo(0);
  });
};

exports.down = function (knex) {
  return knex.schema.dropTable('cards');
};
