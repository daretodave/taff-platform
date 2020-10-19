const http = require('http');

const env = process.env.NODE_ENV || "test"
const port = process.env.PORT || 3000;

const send = contentType => (res, text) => {
    res.statusCode = 200;
    res.setHeader('Content-Type', 'text/plain');
    res.end(`${env}`)
};

const sendText = send('text/plain');
try {

    http.createServer(
        (req, res) => sendText(res, env)
    ).listen(Number(port))

} catch (err) {
    console.log('Failed to start server');
    console.log(err);
}
