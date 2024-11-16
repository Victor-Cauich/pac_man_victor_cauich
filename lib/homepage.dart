import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

static int numberInRow = 11; // 11 por cada fila
int numberOfSquares = numberInRow * 17;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: Container(
              child: GridView.builder(
                // physics: NeverScrollableScrollPhysics(), // evitar que la cuadricula scrolle
                itemCount: numberOfSquares,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: numberInRow),
                 itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      color: Colors.grey,
                      child: Text(index.toString()),
                    ),
                  );
                 }
                 ),
              ),
            ),
          Expanded( // Parte inferior de la pantalla 
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Score", style:  TextStyle(color: Colors.white, fontSize: 40),),
                  Text("P L A Y", style:  TextStyle(color: Colors.white, fontSize: 40),),
              ],
              )
              ),
            ),
        ],
      )
    );
  }
}