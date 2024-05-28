import 'package:flutter/material.dart';
import 'package:tic_tac_toe/UI/theme/utils/game_logic.dart';

import 'UI/theme/color.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  String lastvalue="X";
  bool gameOver=false;
  List<int> scoreboard=[0,0,0,0,0,0,0,0];
  int turn =0;
  String result='';

  Game game=Game();
  @override
  void initState() {
    super.initState();
    game.board=Game.initGameBoard();
    print(game.board);
  }
  @override
  Widget build(BuildContext context) {
    double boardwidth=MediaQuery.of(context).size.width;
    return Scaffold(

      backgroundColor: MainColor.primarycolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          Text("It's ${lastvalue} turn ".toUpperCase(),style: TextStyle(color: Colors.white70,fontSize: 58),),
          SizedBox(height: 20,),
          Container(
            width: boardwidth,
            height: boardwidth,
            child: GridView.count(
              crossAxisCount: Game.boardlength~/3,
              padding: EdgeInsets.all(10),
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              children: List.generate(Game.boardlength, (index){
                return InkWell(
                  onTap: gameOver ? null:(){
                    if(game.board![index]=="") {
                      setState(() {
                        game.board![index] = lastvalue;
                        turn++;
                        gameOver=game.winnerCheck(lastvalue, index, scoreboard,3);
                        if(gameOver){
                          result="$lastvalue is the Winner";
                        }
                        else if(!gameOver&& turn==9){
                          result="It's Draw !";
                          gameOver=true;
                        }
                        if (lastvalue == "X") {
                          lastvalue = "O";
                        }
                        else {
                          lastvalue = "X";
                        }
                      });
                    }
                },
                  child: Container(
                    height:Game.blocSize,
                    width:Game.blocSize,
                    decoration: BoxDecoration(
                      color: MainColor.secondarycolor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(game.board![index],style: TextStyle(color: game.board![index]=="X"?Colors.blueAccent.shade400:Colors.pinkAccent.shade400,fontSize: 64.0),),
                    ),
                  ),
                );
              }),),
          ),
          SizedBox(height:20,),
          Text(result,style: TextStyle(color:Colors.white70,fontSize: 40),),
          SizedBox(height:20,),
          Container(
            height:60,
            padding: EdgeInsets.all(10),
            width: boardwidth,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white70, // change background color of button
                backgroundColor: MainColor.accentcolor, // change text color of button
              ),
              onPressed: (){
              setState(() {
                game.board=Game.initGameBoard();
                lastvalue="X";
                gameOver=false;
                turn=0;
                result="";
                scoreboard=[0,0,0,0,0,0,0,0,0];
              });},
              icon:Icon(Icons.repeat_outlined,color:Colors.white70),
              label: Text("Repeat Game",),),
            ),
        ],
      ),
    );

  }
}



