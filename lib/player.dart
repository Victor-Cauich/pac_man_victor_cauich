import 'package:flutter/material.dart'; // Importa el paquete material.dart de Flutter, que proporciona widgets y clases para construir interfaces de usuario.

class MyPlayer extends StatelessWidget { // Define una clase llamada 'MyPlayer', que extiende 'StatelessWidget' porque el widget no tiene estado mutable.
  const MyPlayer({super.key}); // Constructor de 'MyPlayer' que permite pasar una clave opcional a la clase base.

  @override
  Widget build(BuildContext context) { // Sobrescribe el método 'build' para construir la interfaz del widget.
    return Padding( // Retorna un widget 'Padding', que agrega un espacio alrededor del widget hijo.
      padding: const EdgeInsets.all(2.0), // Aplica un relleno de 2.0 píxeles en todos los lados del widget.
      child: Image.asset( // Utiliza el widget 'Image.asset' para cargar una imagen desde los recursos locales.
        "lib/images/pac-man.png" // imagen (asset) que representa a pac-man
      ),
    );
  }
}
