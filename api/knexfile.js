module.exports = {
  development: {
    client: 'sqlite3',
    connection: {
      filename: `${__dirname}/database/dev.sqlite3`,
    },
    migrations: {
      directory: `${__dirname}/database/migrations`,
    },
    seeds: {
      directory: `${__dirname}/database/seeds`,
    },
  },

  production: {
    client: 'postgresql',
    connection: {
      database: 'my_db',
      user: 'username',
      password: 'password',
    },
    pool: {
      min: 2,
      max: 10,
    },
    migrations: {
      tableName: 'knex_migrations',
      directory: `${__dirname}/database/migrations`,
    },
    seeds: {
      directory: `${__dirname}/database/seeds`,
    },
  },

};
