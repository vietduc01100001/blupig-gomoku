const express = require('express');
const cors = require('cors');
const { exec } = require('child_process');

console.log('Start listening...');
start();

function start() {
  const app = express();
  app.use(cors());
  app.disable('x-powered-by');

  app.get('/status', (req, res) => res.send('ok'));

  app.get('/move', (req, res) => {
    const state = req.query.s ? req.query.s.trim() : '';
    const player = req.query.p ? req.query.s.trim() : '';

    let cmd = 'gomoku';
    if (state && state.length > 0) cmd += ' -s ' + state;
    if (player && player.length > 0) cmd += ' -p ' + player;
    cmd = cmd.trim().replace(/\s+/g, ' ');

    exec(cmd, (err, stdout) => {
      res.write(stdout);
      res.end();
    });
  });

  app.listen(8001);
}
