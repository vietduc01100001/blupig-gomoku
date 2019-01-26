blupig-gomoku
------
RESTful API

### Preparation

- Install Docker.

- Run `scripts/build.sh` and then `scripts/run.sh <PORT>`.

### Usage

- Send request:
  ```
  GET http://localhost:<PORT>/move?s=<game state>&p=<player>
  ```
  Where `game state` is the game board 2D array flatten into a string and `player` is the current player value: `1` or `2` (Gomoku rules).

- Response schema:
  ```
  {
    "message": "ok",
    "result": {
      "build": "<Docker image build date>",
      "cc_0": "0",
      "cc_1": "1",
      "ai_player": "<player value>",
      "winning_player": "<the winning player value>",
      "move_c": "<AI move's column>",
      "move_r": "<AI move's row>",
      "cpu_time": "<AI thinking time>",
      "num_threads": "<number of threads AI used (1)>",
      "search_depth": "<the node depth AI searched>",
      "node_count": "<number of game nodes AI checked>",
      "pm_count": "<pm count>"
    }
  }
  ```
