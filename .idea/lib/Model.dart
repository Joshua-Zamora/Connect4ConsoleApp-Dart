
class Player {

  String _symbol;

  Player(String symbol) {
    this._symbol = symbol;
  }

  String getSymbol() {
    return this._symbol;
  }

}

class Board {

  int width;
  int height;

  List<List<Player>> _boardSlots;

  Player _emptySlots;
  Player _winnerSlots;

  Board(int width, int height) {
    this.width = width;
    this.height = height;
    this._emptySlots = new Player('_');
    this._winnerSlots = new Player('W');
    this._boardSlots = List.generate(height, (i) => List(width), growable: false);
    for(int i = 0; i < height; i++) {
      for(int j = 0; j < width; j++) {
        this._boardSlots[i][j] = this._emptySlots;
      }
    }
  }

  List<List<Player>>getBoardSlots() {
    return _boardSlots;
  }

}