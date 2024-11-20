import 'package:flutter/material.dart'; // Importa el paquete material.dart de Flutter
import 'homepage.dart'; // Importa el archivo 'homepage.dart' que contiene la clase HomePage 

void main() { // La función principal que se ejecuta al iniciar la aplicación.
  runApp(MyApp()); // Llama a 'runApp' para inicializar y ejecutar la aplicación, pasando 'MyApp' como el widget raíz.
}

class MyApp extends StatelessWidget { // Define la clase 'MyApp' que extiende 'StatelessWidget', indicando que este widget no tiene estado mutable.
  const MyApp({super.key}); // Constructor de la clase 'MyApp' con una clave opcional 'key' que permite mantener el estado del widget.

  @override
  Widget build(BuildContext context) { // Sobrescribe el método 'build', que construye la interfaz de usuario del widget.
    return MaterialApp( // Retorna un widget 'MaterialApp', que establece la base para una aplicación con el diseño de material de Flutter.
      debugShowCheckedModeBanner: false, // Desactiva la bandera de depuración en la esquina superior derecha de la pantalla.
      home: HomePage(), // Establece 'HomePage' como el widget principal de la pantalla inicial (la página de inicio).
    );
  }
}
