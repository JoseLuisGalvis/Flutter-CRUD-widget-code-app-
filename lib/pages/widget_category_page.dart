import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/category.dart';
import '../model/widget.dart';

class WidgetCategoryPage extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  WidgetCategoryPage(this.categoryId, this.categoryName);

  @override
  _WidgetCategoryPageState createState() => _WidgetCategoryPageState();
}

class _WidgetCategoryPageState extends State<WidgetCategoryPage> {
  late Future<List<WidgetModel>> _loadWidgetsFuture;

  Future<List<WidgetModel>> loadWidgetsByCategory(int categoryId) async {
    final url = 'http://localhost:2800/categories/$categoryId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      final widgets = jsonData.map((jsonWidget) => WidgetModel.fromJson(jsonWidget)).toList();
      return Future.value(widgets);
    } else {
      throw Exception('Failed to load widgets');
    }
  }

  Future<WidgetModel> loadWidgetDetails(int widgetId) async {
    final url = 'http://localhost:2800/widgets/$widgetId';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final widget = WidgetModel.fromJson(jsonData);
      return Future.value(widget);
    } else {
      throw Exception('Failed to load widget details');
    }
  }

  Future<void> updateWidget(WidgetModel widget) async {
    final url = 'http://localhost:2800/widgets/${widget.id}';
    final response = await http.put(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
    }, body: jsonEncode(widget.toJson()));

    if (response.statusCode != 200) {
      throw Exception('Failed to update widget');
    }
  }

  Future<void> deleteWidget(int widgetId) async {
    final response = await http.delete(Uri.parse('http://localhost:2800/widget/$widgetId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete widget');
    }
  }

  @override
  void initState() {
    super.initState();
    _loadWidgetsFuture = loadWidgetsByCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<WidgetModel>>(
        future: _loadWidgetsFuture, // Asignar el futuro aquí
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final widgets = snapshot.data!;
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 4,
              children: widgets.map((widget) {
                return CategoryCardWidget(
                  title: widget.name,
                  onPressed: () async {
                    // Mostrar diálogo con información detallada sobre el widget
                    final WidgetModel widgetDetails = await loadWidgetDetails(widget.id);
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(widgetDetails.name),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 350,
                                child: Image.network(
                                  widgetDetails.image,
                                  fit: BoxFit.contain,
                                  height: 200,
                                ),
                              ),
                              Text(widgetDetails.description),
                            ],
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () async {
                                // Mostrar formulario para editar los datos del widget
                                final _formKey = GlobalKey<FormState>();
                                String _name = widgetDetails.name;
                                String _description = widgetDetails.description;
                                String _image = widgetDetails.image;

                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Editar Widget'),
                                      content: Form(
                                        key: _formKey,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            TextFormField(
                                              initialValue: _name,
                                              decoration: InputDecoration(labelText: 'Nombre'),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Por favor, ingrese un nombre';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) => _name = value!,
                                            ),
                                            TextFormField(
                                              initialValue: _description,
                                              decoration: InputDecoration(labelText: 'Descripción'),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Por favor, ingrese una descripción';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) => _description = value!,
                                            ),
                                            TextFormField(
                                              initialValue: _image,
                                              decoration: InputDecoration(labelText: 'Imagen'),
                                              validator: (value) {
                                                if (value == null || value.isEmpty) {
                                                  return 'Por favor, ingrese una imagen';
                                                }
                                                return null;
                                              },
                                              onSaved: (value) => _image = value!,
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!.validate()) {
                                              _formKey.currentState!.save();
                                              final updatedWidget = WidgetModel(
                                                id: widgetDetails.id,
                                                name: _name,
                                                description: _description,
                                                image: _image,
                                                categoryId: widgetDetails.categoryId,
                                              );
                                              await updateWidget(updatedWidget);
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text('Widget actualizado con éxito'),
                                                  duration: Duration(seconds: 2),
                                                  backgroundColor: Colors.green,
                                                ),
                                              );
                                              Navigator.of(context).pop();
                                            }
                                          },
                                          child: Text('Actualizar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text('Actualizar'),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                // Muestra un diálogo de confirmación
                                final confirmation = await showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text('Confirmar eliminación'),
                                    content: Text('¿Estás seguro de que quieres eliminar este widget?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: Text('Cancelar'),
                                        onPressed: () => Navigator.of(context).pop(false),
                                      ),
                                      TextButton(
                                        child: Text('Eliminar'),
                                        onPressed: () => Navigator.of(context).pop(true),
                                      ),
                                    ],
                                  ),
                                );

                                if (confirmation ?? false) {
                                  // Si el usuario confirma la eliminación, procede con la eliminación
                                  await deleteWidget(widgetDetails.id);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Widget eliminado con éxito'),
                                      duration: Duration(seconds: 2),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                }
                              },
                              child: Text('Eliminar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading widgets: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CategoryCardWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  CategoryCardWidget({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 100,
        height: 100,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}