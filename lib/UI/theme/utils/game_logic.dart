class Player{
  static const x="X";
  static const o="O";
  static const empty="";
}

class Game{
  static final boardlength=9;
  static final blocSize =100.0;


  List<String>? board;
  static List<String> ? initGameBoard()=>List.generate(boardlength, (index) => Player.empty);

  bool winnerCheck(String Player,int index,List<int> scoreboard,int gridsize){
    int row=index~/3;
    int col=index %3;
    int score = Player=="X"?1:-1;

    scoreboard[row]+=score;
    scoreboard[gridsize+col]+=score;

    if(row==col){
      scoreboard[2*gridsize]+=score;
    }
    if(gridsize-1-col==row){
      scoreboard[2*gridsize+1]+=score;
    }
    if(scoreboard.contains(3)||scoreboard.contains(-3)){
      return true;
    }

   return false;
  }
}
