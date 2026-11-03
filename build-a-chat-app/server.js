import http from 'http';
import fs from 'fs';
import { WebSocketServer } from 'ws';

const PORT = 3001;
const server = http.createServer((req, res) => {
  fs.readFile('./public/index.html', (error, content) => {
    if (error) {
      res.writeHead(500, { 'Content-Type': 'text/plain' });
      res.end('Unable to load the chat page');
      return;
    }

    res.writeHead(200, { 'Content-Type': 'text/html' });
    res.end(content);
  });
});
const wss = new WebSocketServer({ server });
function broadcast(message) {
  const data = JSON.stringify(message);

  for (const client of wss.clients) {
    if (client.readyState === 1) {
      client.send(data);
    }
  }
}
wss.on('connection', (socket, req) => {
  const username = new URL(
    req.url,
    'http://localhost'
  ).searchParams.get('username');

  broadcast({
    type: 'system',
    text: `${username} joined`
  });
    socket.on('message', (data) => {
    try {
      const message = JSON.parse(data.toString());

      broadcast({
        type: 'chat',
        username: message.username,
        text: message.text
      });
    } catch (error) {
      console.error('Invalid message:', error.message);
    }
  });
   socket.on('close', () => {
    broadcast({
      type: 'system',
      text: `${username} left`
    });
  });
});
server.listen(PORT, () => {
  console.log(`Chat server running at http://localhost:${PORT}`);
});