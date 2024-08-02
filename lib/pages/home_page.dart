import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo2.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 15),
              Text(
                'Bienvenidos a Widget Cards App!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  shadows: [
                    Shadow(
                      offset: Offset(3, 3), // Desplazamiento de la sombra
                      blurRadius: 4, // Radio de desenfoque de la sombra
                      color: Colors.black.withOpacity(0.7), // Color de la sombra
                    ),
                  ],
                ),
              ),
              Text(
                'Encuentra el Widget que necesitas\n para tu App',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blue,
                  shadows: [
                    Shadow(
                      offset: Offset(3, 3), // Desplazamiento de la sombra
                      blurRadius: 4, // Radio de desenfoque de la sombra
                      color: Colors.black.withOpacity(0.9), // Color de la sombra
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}