function augmentError(error, data) {
  error.data = {
    ...error.data,
    ...data,
  };
}

function formatForLog(error) {
  return {
    error: {
      stack: error.stack,
      message: error.message,
      code: error.code,
      data: error.data,
    },
  };
}

module.exports = {
  augmentError,
  formatForLog,
};
