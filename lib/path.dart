import 'package:flutter/material.dart'; // Importa el paquete material.dart de Flutter, que contiene clases y widgets para diseñar interfaces de usuario.

class MyPath extends StatelessWidget { // Define una clase llamada 'MyPath', que extiende 'StatelessWidget' porque este widget no tiene estado mutable.
  final innerColor; // Declara una propiedad para el color interior del camino 
  final outerColor; // Declara una propiedad para el color exterior del camino
  final child; // Declara una propiedad para el widget hijo que se mostrará dentro del camino

  const MyPath({super.key, this.innerColor, this.outerColor, this.child}); // Constructor que inicializa las propiedades y permite pasar valores desde el exterior.

  // foramto para los bloques que estan en "el camino de pac-man"
  @override  
  Widget build(BuildContext context) { // Sobrescribe el método 'build', que construye la interfaz del widget.
    return Padding( // Retorna un widget 'Padding' que agrega espacio alrededor de su hijo.
      padding: const EdgeInsets.all(1.0), // Aplica un relleno de 1.0 píxeles alrededor del widget hijo.
      child: ClipRRect( // El widget 'ClipRRect' recorta el widget hijo con bordes redondeados.
        borderRadius: BorderRadius.circular(6), // Redondea los bordes del contenedor exterior con un radio de 6 píxeles.
        child: Container( // Un contenedor que actúa como el fondo exterior del camino.
          padding: const EdgeInsets.all(12), // Aplica un relleno de 12 píxeles dentro del contenedor exterior.
          color: outerColor, // Establece el color de fondo exterior usando el valor de 'outerColor'.
          child: ClipRRect( // Otro widget 'ClipRRect' para recortar el contenedor interior con bordes redondeados.
            borderRadius: BorderRadius.circular(10), // Redondea los bordes del contenedor interior con un radio de 10 píxeles.
            child: Container( // Contenedor que actúa como el fondo interior del camino.
              color: innerColor, // Establece el color de fondo interior usando el valor de 'innerColor'.
              child: Center( // Centra el widget hijo dentro del contenedor interior.
                child: child, // Muestra el widget hijo pasado a 'MyPath'.
              ),
            ),
          ),
        ),
      ),
    );
  }
}
