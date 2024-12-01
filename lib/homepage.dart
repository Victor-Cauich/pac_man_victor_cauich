import 'dart:async'; // Importa la biblioteca para manejar temporizadores 
import 'dart:math'; // Importa la biblioteca de matemáticas, para operaciones con ángulos y rotaciones.
import 'package:flutter/material.dart'; // Importa el paquete de Flutter para crear la interfaz gráfica.
import 'package:pac_man_victor_cauich/path.dart'; // Importa un archivo que parece definir el widget `MyPath`.
import 'ghost.dart'; // Importa el archivo que define el widget `Ghost`.
import 'pixel.dart'; // Importa el archivo que define el widget `MyPixel`.
import 'player.dart'; // Importa el archivo que define el widget `MyPlayer`.

class HomePage extends StatefulWidget { // Declara la clase 'HomePage' como un widget de estado (StatefulWidget).
  const HomePage({super.key}); // Constructor para la clase HomePage con clave opcional para el widget.

  @override
  _HomePageState createState() => _HomePageState(); // Crea el estado asociado con la HomePage.
}
 
class _HomePageState extends State<HomePage> { // Clase privada que contiene el estado de 'HomePage'.
  static int numberInRow = 11; // Establece el número de cuadros por fila en la cuadrícula (11 columnas).
  int numberOfSquares = numberInRow * 17; // Calcula el número total de cuadros en la cuadrícula (11 * 17).
  int player = numberInRow * 15 + 1; // Determina la posición inicial del jugador en la cuadrícula.
  List<int> ghosts = [ // Posiciones iniciales de los 4 fantasmas
    numberInRow + 1, // posicion fantasma 1
    numberInRow + 9, // posicion fantasma 2
    numberInRow * 10 + 1, // posicion fantasma 3
    numberInRow * 10 + 9 // posicion fantasma 4
    ]; 
 

  List<int> barriers = [ // Lista de índices que representan las barreras del mapa (muros y obstáculos).
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, // Borde superior de la cuadrícula.
    11, 22, 33, 44, 55, 66, 77, 99, 110, 121, 132, 143, 154, 165, 176, // Borde izquierdo.
    177, 178, 179, 180, 181, 182, 183, 184, 185, 186, // Borde inferior.
    21, 32, 43, 54, 65, 76, 87, 109, 120, 131, 142, 153, 164, 175, // Borde derecho.
    24, 35, 46, 57, 26, 37, 38, 39, 28, 30, 41, 52, 63, 78, 79, 80, 81, 70, 59, // Obstáculos en la parte superior.
    61, 72, 83, 84, 85, 86, // Más obstáculos en la parte superior. 
    156, 145, 134, 123, 162, 151, 140, 
    129, 158, 147, 148, 149, 160, 100, 101, // Obstáculos en la parte inferior.
    102, 103, 114, 125, 127, 116, 105, 106, 107, 108 // Más obstáculos en la parte inferior.
  ];

  List<int> food = []; // Lista para almacenar las pildoras de la comida en el mapa.

  String direction = "right"; // Dirección inicial del jugador (derecha).
  bool preGame = true; // indica si el juego está en la fase previa al inicio.
  bool mouthClosed = false; // Estado de la boca de Pac-Man, no empieza cerrada
  int score = 0; // Puntuación inicial del jugador.

  void startGame() { // Método que inicia el juego.
    moveGhost(); // Comienza el movimiento del fantasma.
    preGame = false; // Cambia el estado a juego iniciado.
    getFood(); // Obtiene las posiciones de la comida.
    Timer.periodic(Duration(milliseconds: 240), (timer) { // Temporizador que indica la velocidad de pacman
      setState(() { // establecer un estado
        mouthClosed = !mouthClosed; // Cambia el estado de la boca de Pac-Man cada ciclo.
      });
    
      if (food.contains(player)) { // Verifica si Pac-Man ha comido una píldora.
        food.remove(player); // Elimina la píldora que ha comido Pac-Man.
        score++; // Aumenta el puntaje.
      }

        for (int ghost in ghosts){
          if (player == ghost) { // Verifica si Pac-Man ha tocado al fantasma.
        player = -1; // Elimina al jugador (lo coloca fuera de la cuadrícula).
        showGameOverDialog(); // mostrar mensaje de Game Over
        break; // terminar
        }
      }

      // Mueve a Pac-Man según la dirección actual.
      switch (direction) { // cambia la direccion
        case "left": // Si la dirección es izquierda
          moveLeft(); //ueve Pac-Man a la izquierda
          break; // Finaliza el bloque del caso

        case "right": // Si la dirección es derecha
          moveRight(); // ueve Pac-Man a la derecha
          break; // Finaliza el bloque del caso

        case "up": // Si la dirección es arriba
          moveUp(); // mueve Pac-Man hacia arriba.
          break; // Finaliza el bloque del caso

        case "down": // Si la dirección es abajo
          moveDown(); //  mueve Pac-Man hacia abajo.
          break;
      }
    
    });
  }

 List<String> ghostDirections = ["left", "left", "left", "left"];  // Direcciones iniciales de los 4 fantasmas

  void moveGhost() { // Método que maneja el movimiento del fantasma.
    Duration ghostSpeed = Duration(milliseconds: 500); // Establece la velocidad del fantasma.
    Timer.periodic(ghostSpeed, (timer) { // Temporizador que mueve al fantasma periódicamente.
    for (int i = 0; i < ghosts.length; i++) { // mover fantasma
      String ghostDirection = ghostDirections[i]; // direccion de los fantasmas de la lista = ghostDirections
      int ghost = ghosts[i]; // fantasmas de la lista = ghost
    List<String> possibleDirections = []; // Lista de direcciones posibles.
      if (!barriers.contains(ghost - 1) && ghostDirection != "right"){ //&& (ghost % numberInRow !=0)) {  // Determina la dirección del fantasma en función de las barreras y límites.
        possibleDirections.add("left"); // Si no hay barrera a la izquierda, el fantasma va a la izquierda.
      } 
      if (!barriers.contains(ghost + 1) && ghostDirection != "left" ){//&& ((ghost +1) % numberInRow !=0)) {
        possibleDirections.add("right"); // Si no hay barrera a la derecha, el fantasma va a la derecha.
      } 
       if (!barriers.contains(ghost - numberInRow)&& ghostDirection != "down") {
        possibleDirections.add("up"); // Si no hay barrera arriba, el fantasma va hacia arriba.
      } 
      if (!barriers.contains(ghost + numberInRow)&& ghostDirection != "up") {
        possibleDirections.add("down"); // Si no hay barrera abajo, el fantasma va hacia abajo.
      }

      if (possibleDirections.isNotEmpty){ // si las posibles direcciones no estan vacias
        String newDirection = // nueva direccion 
        possibleDirections[Random().nextInt( // elegir direccion aleatoria
        possibleDirections.length)]; // entre las posibles direcciones
          ghostDirection =  newDirection; // Actualizamos la dirección del fantasma.
      }

      // hacer que el fantasma se teletransporte de un lado a otro del mapa
      if (ghost == 98) { // Si el fantasma esta en la csilla 98
      // Si el fantasma llega al índice 98, reaparece en 88
      setState(() { //Actualizar estado
        ghost = 88; // mover fantasma en la casilla 88
        });
        }
      if (ghost == 88) { // Si el fantasma esta en la casilla 88
      // Si el fantasma llega al índice 88, reaparece en 98
      setState(() { // actualizar estado
        ghost = 98; // mover fantasma en la casilla 98
        });
        }

      // Mueve al fantasma en la dirección determinada.
      switch (ghostDirection) {  // cambia la direccion del fantasma
        case "right": // Si la dirección del fantasma es derecha
          setState(() {  // Llama a setState para notificar que el estado del widget ha cambiado.
            ghosts[i]++; // Mueve al fantasma a la derecha.
          });
          break;// Finaliza el bloque del caso

        case "up": // Si la dirección del fantasma es arriba
          setState(() { // Llama a setState para notificar que el estado del widget ha cambiado.
            ghosts[i] -= numberInRow; // Mueve al fantasma hacia arriba.
          });
          break;// Finaliza el bloque del caso

        case "left": // Si la dirección del fantasma es izquierda
          setState(() { // Llama a setState para notificar que el estado del widget ha cambiado.
            ghosts[i]--; // Mueve al fantasma a la izquierda.
          });
          break;// Finaliza el bloque del caso

        case "down": // Si la dirección del fantasma es abajo
          setState(() { // Llama a setState para notificar que el estado del widget ha cambiado.
            ghosts[i] += numberInRow; // Mueve al fantasma hacia abajo.
          });
          break;// Finaliza el bloque del caso
        }
      }
    });
  }


  void getFood() { // Método para generar la comida en el mapa.
    for (int i = 0; i < numberOfSquares; i++) { // Recorre todos los cuadros del mapa.
      if (!barriers.contains(i)) { // Si el cuadro no es una barrera, es comida.
        food.add(i); // Añade la posición de la comida.
      }
    }
  }

  // movimientos que hara pac-man
  void moveRight() { // Mueve a Pac-Man a la derecha si no hay barrera.
  if (player == 98) {
    // Si el jugador llega al índice 98, 
    setState(() { // actualizar estado
      player = 88; //reaparece en 88
    });
    } else if (!barriers.contains(player + 1)) { // Verifica si la posición a la derecha del jugador no está bloqueada por una barrera
      setState(() { // Llama a 'setState' para actualizar la interfaz 
        player++; // Aumenta la posición del jugador en el eje horizontal.
      });
    }
  }
  void moveLeft() { // Mueve a Pac-Man a la izquierda si no hay barrera.
  if (player == 88) {
    // Si el jugador llega al índice 88, reaparece en 98
    setState(() { // actualizar estado
      player = 98; //reaparece en 98
    });
    } else if (!barriers.contains(player - 1)) { // Verifica si la posición a la izquierda del jugador no está bloqueada por una barrera
      setState(() { // Llama a 'setState' para actualizar la interfaz
        player--; // Disminuye la posición del jugador en el eje horizontal.
      });
    }
  }
  void moveUp() { // Mueve a Pac-Man hacia arriba si no hay barrera.
    if (!barriers.contains(player - numberInRow)) { // Verifica si la posición arriba del jugador no está bloqueada por una barrera
      setState(() { // Llama a 'setState' para actualizar la interfaz
        player -= numberInRow; // Reduce la posición del jugador en el eje vertical.
      });
    }
  }
  void moveDown() { // Mueve a Pac-Man hacia abajo si no hay barrera.
    if (!barriers.contains(player + numberInRow)) { // Verifica si la posición abajo del jugador no está bloqueada por una barrera
      setState(() { // Llama a 'setState' para actualizar la interfaz
        player += numberInRow; // Aumenta la posición del jugador en el eje vertical
      });
    }
  }

  // metodo para el cuadro de dialogo que aparece al perder la partida
void showGameOverDialog() { // metodo para mostrar mensaje de fin del juego
  showDialog( // mostar un mensaje
    context: context, //contexto
    barrierDismissible: false, // Evita cerrar el diálogo al tocar fuera de él.
    builder: (BuildContext context) { //constructor
      return AlertDialog( // retormar AlertDialog
        backgroundColor: const Color.fromARGB(255, 24, 39, 241), // Color del fondo del mensaje
        title: Text( // El titulo sera un texto
          "GAME OVER", // mensaje del titulo del mensaje
          style: TextStyle(color:Colors.white, fontSize: 30), // formato del texto GAME OVER
          textAlign: TextAlign.center, // centrar el mensaje
        ),
        content: Text( // texto
          "\nScore: $score", // mostar el score del jugador
          style: TextStyle(color: Colors.white, fontSize: 20), // formato del texto del score
          textAlign: TextAlign.center,// centrar texto
        ),
      );
    },
  );
}

  //

  @override
  Widget build(BuildContext context) { // Método que construye la interfaz de usuario.
    return Scaffold( // Crea una pantalla básica de Flutter.
      backgroundColor: Colors.black, // Establece el fondo de la pantalla como negro.
      body: Column( // Organiza los elementos en una columna.
        children: [ // Lista de widgets hijos que se incluirán dentro de la columna.
          Expanded( // La parte superior de la pantalla que contiene el juego.
            flex: 5, // Ocupa 5 partes del espacio disponible.

            child: GestureDetector( // Detecta gestos táctiles en la pantalla.
              onVerticalDragUpdate: (details) { // Maneja el arrastre vertical (arriba y abajo).
                if (details.delta.dy > 0) { // Si se arrastra hacia abajo
                  direction = "down"; //  cambia la dirección a "abajo".
                } else if (details.delta.dy < 0) { // Si se arrastra hacia arriba
                  direction = "up"; // cambia la dirección a "arriba".
                }
              },
              onHorizontalDragUpdate: (details) { // Maneja el arrastre horizontal (izquierda y derecha).
                if (details.delta.dx > 0) { // Si se arrastra hacia la derecha,
                  direction = "right"; // cambia la dirección a "derecha".
                } else if (details.delta.dx < 0) { // Si se arrastra hacia la izquierda
                  direction = "left"; // cambia la dirección a "izquierda".
                }
              },
              child: GridView.builder( // Construye la cuadrícula del juego.
              physics: NeverScrollableScrollPhysics(),
                itemCount: numberOfSquares, // Número total de cuadros en la cuadrícula.
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount( // Configura el diseño de la cuadrícula con un número fijo de columnas.
                    crossAxisCount: numberInRow), // Configura el número de columnas.
                itemBuilder: (BuildContext context, int index) { // Define cómo se renderiza cada cuadro.
                  if (index == player) { // Si el índice es la posición de Pac-Man.
                    if (mouthClosed) { // Si la boca de Pac-Man está cerrada.
                      return Padding( // Muestra Pac-Man con la boca cerrada.
                        padding: EdgeInsets.all(4), // Aplica un padding de 4 píxeles en todos los lados.
                        child: Container( // Crea un contenedor que representa a Pac-Man con la boca cerrada.
                          decoration: BoxDecoration(
                            color: Colors.yellow, // Color de Pac-Man con la boca cerrada.
                            shape: BoxShape.circle, // Pac-Man tiene forma circular cuandp cierra la boca.
                          ),
                        ),
                      );

                    } else {
                      // Muestra la imagen Pac-Man en la dirección correspondiente.
                      switch (direction) { // cambiar la direccion
                        case "left": // cuando es a la izquierda
                          return Transform.rotate(angle: pi, child: MyPlayer()); // rotar la imagen para que quede mirando hacia la izquierda
                        case "right": // cuando es derecha
                          return MyPlayer(); //Mostrar la imagen por defecto (no es necesario rotar)
                        case "up": // cuando es arriba
                          return Transform.rotate( // rotar la imagen
                              angle: 3 * pi / 2, child: MyPlayer()); // rotar la imagen para que quede mirando hacia arriba
                        case "down": // cuando es abajo
                          return Transform.rotate( // rotar la imagen
                              angle: pi / 2, child: MyPlayer()); // rotar la imagen para que quede mirando hacia abajo
                        default: // cuando no se a movido a pacman
                          return MyPlayer(); // retornar la imagen de "pac-man por defecto"
                      }
                    }

                  } else if (ghosts.contains(index)) { // Si el índice es la posición del fantasma.
                    return Ghost(); // muestra el fantasma
                  } else if (barriers.contains(index)) { // Si el índice es una barrera.
                    return MyPixel( // muestra la "barrera"
                      innerColor: Colors.blue[900], // Color de la barrera.
                      outerColor: Colors.blue[900], // Color del borde de la barrera.
                    );
                  } else if(food.contains(index)){ // Si el índice es comida.
                    return MyPath( // Muestra las pildoras (la comida)
                      innerColor: Colors.yellow, // Color de la píldora de comida.
                      outerColor: Colors.black, // Color de borde de la comida.
                    );
                  } else {
                    return const MyPath( // Cuadro vacío que simula una pildora que ya fue "comida".
                      innerColor: Colors.black, // color (camino vacio) negro 
                      outerColor: Colors.black, // color del borde (camino vacio) negro
                    );
                  }
                },
              ),
            ),
          ),
          Expanded( // La parte inferior de la pantalla que muestra el puntaje y el botón de inicio.
            child: Container( // Crea un contenedor dentro de la parte inferior del expanded
              child: Row( // Organiza los elementos en una fila.
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Organiza los elementos con espacios iguales entre ellos.
                children: [ // hijo de la fila
                  Text( // muestra el texto del score
                    "Score: "+ score.toString(), // Muestra el puntaje actual.
                    style: TextStyle(color: Colors.white, fontSize: 40), // estilo del texto "score"
                  ),
                  GestureDetector( // Detecta el toque en el botón de inicio.
                    onTap: startGame, // Inicia el juego cuando se toca.
                    child: Text( // Muestra el texto del botón de play
                      "P L A Y", // Texto del botón de inicio.
                      style: TextStyle(color: Colors.white, fontSize: 40), // estilo del texto "play"
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
