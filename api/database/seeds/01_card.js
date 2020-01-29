const axios = require('axios');
const parse = require('csv-parse/lib/sync');

exports.seed = function (knex) {
  return axios.get('https://docs.google.com/spreadsheets/d/e/2PACX-1vSP5-vsJX1O_diLTiDAPwU_qTxp4Mc_FHOdcK4ypIEj-ymSe83TlUTlnRnRfhOYvPpxL5jnS-46lG5v/pub?gid=0&single=true&output=csv')
    .then((response) => {
      const { data } = response;

      const records = parse(data, {
        columns: true,
        skip_empty_lines: true,
      });

      // Deletes ALL existing entries
      return knex('cards').del()
        .then(() => knex('cards').insert(records));
    })
    .catch((error) => {
      console.error('error getting data from google spreadsheet');

      throw error;
    });
};
