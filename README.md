blupig-gomoku
------

A Gomoku (五子棋, Five in a Row) AI with a custom `heuristic negamax` algorithm with `alpha-beta pruning` and built-in rules and cut-offs, written in `C++`.

It provides:
  - A REST API (used by the [HTML client](gui))
  - A CLI interface
  - The stdin / stdout based [protocol](http://petr.lastovicka.sweb.cz/protocl2en.htm) used in Gomocup

Currently runs single-threaded, supports only `Gomoku` rules.

![Alt text](gui/screenshots/00.png?raw=true "Screenshot")

Run Your Own Copy
-----
- Make sure you have access to `docker`.

- Run `scripts/build.sh` and then `scripts/run.sh`.

- Access `http://localhost:8000` in your browser.

- Play!
