import 'package:flutter/material.dart';

import '../DatabaseService.dart';
import '../model/widget.dart';

class WidgetCrudPage extends StatefulWidget {
  @override
  _WidgetCrudPageState createState() => _WidgetCrudPageState();
}

class _WidgetCrudPageState extends State<WidgetCrudPage> {
  final DatabaseService _databaseService = DatabaseService();

  final List<Map<String, dynamic>> categories = [
    {'id': 1, 'name': 'usabilidad'},
    {'id': 2, 'name': 'animacion_y_movimientos'},
    {'id': 3, 'name': 'activos_imagen_e_icono'},
    {'id': 4, 'name': 'gestion_de_estado'},
    {'id': 5, 'name': 'basicos'},
    {'id': 6, 'name': 'cupertino'},
    {'id': 7, 'name': 'entrada'},
    {'id': 8, 'name': 'navegacion'},
    {'id': 9, 'name': 'layout'},
    {'id': 10, 'name': 'componentes_de_material'},
    {'id': 11, 'name': 'efectos_visuales'},
    {'id': 12, 'name': 'desplazamiento'},
    {'id': 13, 'name': 'tema_y_apariencia'},
    {'id': 14, 'name': 'texto'},
    {'id': 15, 'name': 'eguridad_y_autenticacion'},
  ];

  final _widgetNameController = TextEditingController();
  final _widgetDescriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();

  int? selectedCategoryId;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Widget CRUD'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/fondo1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SizedBox(
            width: 350,
            child: Card(
              color: Colors.white.withOpacity(0.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Categoría',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      DropdownButtonFormField<int>(
                        value: selectedCategoryId,
                        hint: Text('Selecciona una categoría'),
                        items: categories.map((category) {
                          return DropdownMenuItem<int>(
                            value: category['id'],
                            child: Text(category['name']),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategoryId = newValue!;
                          });
                        },
                      ),
                      TextFormField(
                        controller: _widgetNameController,
                        decoration: InputDecoration(labelText: 'Widget Name'),
                      ),
                      TextFormField(
                        controller: _widgetDescriptionController,
                        decoration: InputDecoration(labelText: 'Widget Description'),
                      ),
                      TextFormField(
                        controller: _imageUrlController,
                        decoration: InputDecoration(labelText: 'Image URL'),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (selectedCategoryId != null) {
                            final widgetName = _widgetNameController.text;
                            final widgetDescription = _widgetDescriptionController.text;
                            final imageUrl = _imageUrlController.text;

                            final widget = WidgetModel(
                              id: 0,
                              categoryId: selectedCategoryId!,
                              name: widgetName,
                              description: widgetDescription,
                              image: imageUrl,
                            );

                            // Llama al método createWidget de tu DatabaseService
                            await _databaseService.createWidget(widget);

                            // Limpiar el formulario
                            _widgetNameController.clear();
                            _widgetDescriptionController.clear();
                            _imageUrlController.clear();

                            // Mostrar un mensaje de éxito
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Widget creado con éxito'),
                                duration: Duration(seconds: 2),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Seleccione una categoría')),
                            );
                          }
                        },
                        child: Text('Create Widget'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}