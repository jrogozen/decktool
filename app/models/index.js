const isUndefined = require('lodash/isUndefined');

class Model {
  static string(val) {
    if (!val) {
      return '';
    }

    return String(val);
  }

  static number(val) {
    if (isUndefined(val)) {
      return 0;
    }

    return Number(val);
  }

  static boolean(val) {
    if (isUndefined(val)) {
      return false;
    }

    if (val === 'false') {
      return false;
    }

    return true;
  }
}

module.exports = Model;
