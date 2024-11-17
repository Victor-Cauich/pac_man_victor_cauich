import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pac_man_victor_cauich/path.dart';
import 'pixel.dart';
import "player.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

static int numberInRow = 11; // 11 por cada fila
int numberOfSquares = numberInRow * 17;
int player = numberInRow * 15 + 1; // lugar donde el jugador aparecera

List<int> barriers = [
  0,1,2,3,4,5,6,7,8,9,10,  // bloques del borde superior
  11,22,33,44,55,66,77,99,110,121,132,143,154,165,176, // bloques del borde izquierdo
  177,178,179,180,181,182,183,184,185,186, // bloques del borde inferior
  21,32,43,54,65,76,87,109,120,131,142,153,164,175, // bloques del borde derecho
  24,35,46,57,26,37,38,39,28,30,41,52,63,78,79,80,81,70,59,61,72,83,84,85,86,// Obstaculos parte superior
  156,145,134,123,162,151,140,129,158,147,148,149,160,100,101,102,103,114,125,127,116,105,106,107,108 // obstaculos parte inferior

];

String direction = "right";

void startGame(){
  Timer.periodic(const Duration(milliseconds: 150), (timer){

    switch (direction){
      case "left":
      moveLeft();
      break;

      case "right":
      moveRight();
      break;

      case "up":
      moveUp();
      break;

      case "down":
      moveDown();
      break;

    }

  });
}

void moveRight(){
  if (!barriers.contains(player+1)){ // Si el jugador golpea una barrera este se detendra
      setState(() {
      player++; //Pac man se movera a la derecha
      });
    }
}
void moveLeft(){
  if (!barriers.contains(player-1)){ // Si el jugador golpea una barrera este se detendra
      setState(() {
      player--; //Pac man se movera a la izquierda
      });
    }
}
void moveUp(){
  if (!barriers.contains(player - numberInRow)){ // 
      setState(() {
      player -= numberInRow; //Pac man se movera hacia el cuadro de arriba
      });
    }
}
void moveDown(){
  if (!barriers.contains(player + numberInRow)){ // Si el jugador golpea una barrera este se detendra
      setState(() {
      player += numberInRow; //Pac man se movera hacia el cuadro de abajo
      });  
    }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onVerticalDragUpdate: (details){
                if (details.delta.dy > 0){
                  direction = "down";
                }else if (details.delta.dy < 0){
                  direction = "up";
                }
                print(direction); // Verificar en la consola la dirección
              },
              onHorizontalDragUpdate: (details){
                if (details.delta.dx > 0){
                  direction = "right";
                }else if (details.delta.dx < 0){
                  direction = "left";
                }
                print(direction); // Verificar en la consola la dirección
              },
              child: Container(
                child: GridView.builder(
                  // physics: NeverScrollableScrollPhysics(), // evitar que la cuadricula scrolle
                  itemCount: numberOfSquares,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: numberInRow),
                   itemBuilder: (BuildContext context, int index){
                    if (player == index ){ // bloques que se encuentran en el borde de la cuadricula
                      return const MyPlayer();
                      }else if (barriers.contains(index)){ // bloques que se encuentran en el borde de la cuadricula
                      return MyPixel(
                       innerColor: Colors.blue[900],
                       outerColor: Colors.blue[900],
                       // child: Text(index.toString()) // Mostrar los numeros de la cuadricula
                      );
                    }else{
                      return MyPath(
                       innerColor: Colors.yellow,
                       outerColor: Colors.black,
                       // child: Text(index.toString()) // Mostrar los numeros de la cuadricula
                      );
                    }
                   }
                   ),
                ),
            ),
            ),
          Expanded( // Parte inferior de la pantalla 
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Score", 
                    style:  TextStyle(color: Colors.white, fontSize: 40),),
                  GestureDetector(
                    onTap: startGame,
                    child: Text("P L A Y",
                    style:  TextStyle(color: Colors.white, fontSize: 40),
                    ),),
              ],
              )
              ),
            ),
        ],
      )
    );
  }
}