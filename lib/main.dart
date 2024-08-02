import 'package:flutter/material.dart';
import 'package:widget_code_app/pages/category_pages.dart';

import 'package:widget_code_app/pages/home_page.dart';
import 'package:widget_code_app/pages/widget_crud_page.dart';



// 1. Punto de Entrada de la Aplicación
void main() {
  runApp(const MyApp());
}

// 2. Widget Raíz de la Aplicación
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Widgets Cards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(primary: Colors.blue),
        useMaterial3: true,
      ),
      // Quitar la cinta de depuración (debug banner)
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

// 3. Página Principal
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 4. Estado de la Página Principal
class _MyHomePageState extends State<MyHomePage> {
  // Declaración e inicialización de currentIndex
  int currentIndex = 0;
  List<Widget> screens = [
    const HomePage(),
    const CategoryPage(),
    WidgetCrudPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Widgets Cards - Flutter Framework',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent, // Hacer la AppBar transparente
        elevation: 0, // Eliminar la sombra para que la AppBar sea completamente transparente
        flexibleSpace: Container(
          color: Theme.of(context).primaryColor, // Usar el color primario del tema como fondo
        ),
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: currentIndex, // Uso de currentIndex
        onTap: (value) { // Manejador de tap para cambiar el índice seleccionado
          setState(() {
            currentIndex = value;
          });
        },
        selectedItemColor: Colors.cyanAccent,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Categories',
            icon: Icon(Icons.category),
          ),
          BottomNavigationBarItem(
            label: 'Widgets',
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
