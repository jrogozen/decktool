// eslint-disable-next-line no-unused-vars
function finalErrorHtmlResponse(error, req, res, next) {
  const html = `<html>
        <h1>${error.code}<h1>
        <h2>${error.message}</h2>
        <body>
            <pre>${error.stack}</pre>
        </body>
    </html>`;

  if (!res.hasSetStatus) {
    res.status(500);
  }

  res.send(html);
}

module.exports = finalErrorHtmlResponse;
