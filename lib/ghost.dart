import 'package:flutter/material.dart'; // Importa el paquete material.dart de Flutter, que contiene clases y widgets para diseñar interfaces de usuario.

class Ghost extends StatelessWidget { // Define una clase llamada 'Ghost', que extiende 'StatelessWidget' 

  @override
  Widget build(BuildContext context) { // Sobrescribe el método 'build', que construye la interfaz del widget.
    return Padding( // Retorna un widget 'Padding', que agrega espacio alrededor de su hijo (en este caso la imagen del fantasma).
      padding: const EdgeInsets.all(2.0), // Establece un relleno de 2.0 píxeles en todos los lados del hijo.
      child: Image.asset("lib/images/fantasma.png"), // Carga y muestra la imagen (asset) que representa al fantasma
    );
  }
}
