import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pac_man_victor_cauich/path.dart';
import 'pixel.dart';
import 'player.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11; // 11 por cada fila
  int numberOfSquares = numberInRow * 17;
  int player = numberInRow * 15 + 1; // lugar donde el jugador aparecerá

  List<int> barriers = [
    // Lista de las barreras del mapa
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, // borde superior
    11, 22, 33, 44, 55, 66, 77, 99, 110, 121, 132, 143, 154, 165, 176, // borde izquierdo
    177, 178, 179, 180, 181, 182, 183, 184, 185, 186, // borde inferior
    21, 32, 43, 54, 65, 76, 87, 109, 120, 131, 142, 153, 164, 175, // borde derecho
    24, 35, 46, 57, 26, 37, 38, 39, 28, 30, 41, 52, 63, 78, 79, 80, 81, 70, 59,
    61, 72, 83, 84, 85, 86, // obstáculos parte superior
    156, 145, 134, 123, 162, 151, 140, 129, 158, 147, 148, 149, 160, 100, 101,
    102, 103, 114, 125, 127, 116, 105, 106, 107, 108 // obstáculos parte inferior
  ];

  List<int> food = []; // Lista de la comida

  String direction = "right";
  bool preGame = true;
  bool mouthClosed = false;

  void startGame() {
    preGame = false;
    getFood();
    Timer.periodic(Duration(milliseconds: 120), (timer) {
      setState(() {
        mouthClosed = !mouthClosed;
      });

      if (food.contains(player)) { // verificar que pac-man se halla comido la pildora
        food.remove(player);
      }

      switch (direction) {
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

  void getFood() { // Método para obtener comida
    for (int i = 0; i < numberOfSquares; i++) {
      if (!barriers.contains(i)) {
        food.add(i);
      }
    }
  }

  void moveRight() {
    if (!barriers.contains(player + 1)) {
      // Si el jugador golpea una barrera, se detendrá
      setState(() {
        player++; // Pac-Man se moverá a la derecha
      });
    }
  }

  void moveLeft() {
    if (!barriers.contains(player - 1)) {
      // Si el jugador golpea una barrera, se detendrá
      setState(() {
        player--; // Pac-Man se moverá a la izquierda
      });
    }
  }

  void moveUp() {
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow; // Pac-Man se moverá hacia el cuadro de arriba
      });
    }
  }

  void moveDown() {
    if (!barriers.contains(player + numberInRow)) {
      // Si el jugador golpea una barrera, se detendrá
      setState(() {
        player += numberInRow; // Pac-Man se moverá hacia el cuadro de abajo
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
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
              },
              child: GridView.builder(
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: numberInRow),
                itemBuilder: (BuildContext context, int index) {
                  if (index == player) {
                    // Solo aplica para el jugador
                    if (mouthClosed) {
                      return Padding(
                        padding: EdgeInsets.all(4),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.yellow,
                            shape: BoxShape.circle, // Pac-Man con la boca cerrada
                          ),
                        ),
                      );
                    } else {
                      switch (direction) { //mover el asset de pac-man 
                        case "left":
                          return Transform.rotate(angle: pi, child: MyPlayer());
                        case "right":
                          return MyPlayer();
                        case "up":
                          return Transform.rotate(
                              angle: 3 * pi / 2, child: MyPlayer());
                        case "down":
                          return Transform.rotate(
                              angle: pi / 2, child: MyPlayer());
                        default:
                          return MyPlayer();
                      }
                    }
                  } else if (barriers.contains(index)) {
                    return MyPixel(
                      innerColor: Colors.blue[900],
                      outerColor: Colors.blue[900],
                    );
                  }else if(food.contains(index)){
                    return MyPath(
                      innerColor: Colors.yellow,
                      outerColor: Colors.black,
                    );
                  }else{
                    return const MyPath(
                      innerColor: Colors.black,
                      outerColor: Colors.black,
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            // Parte inferior de la pantalla
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Score",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  GestureDetector(
                    onTap: startGame,
                    child: Text(
                      "P L A Y",
                      style: TextStyle(color: Colors.white, fontSize: 40),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
