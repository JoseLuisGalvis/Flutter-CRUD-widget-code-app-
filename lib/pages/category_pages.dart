import 'package:flutter/material.dart';
import 'package:widget_code_app/pages/widget_category_page.dart';

import '../DatabaseService.dart';
import '../model/category.dart';


class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Category>? _categories;

  @override
  void initState() {
    super.initState();
    _loadCategories().then((value) {
      setState(() {
        _categories = value;
      });
    }).catchError((error) {
      print('Error: $error');
    });
  }

  Future<List<Category>> _loadCategories() async {
    return await DatabaseService().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías de Widgets'),
      ),
      body: _categories == null
          ? Center(child: CircularProgressIndicator())
          : GridView.count(
        crossAxisCount: 2, // número de columnas
        children: _categories!.map((category) {
          return CategoryCard(
            image: category.image,
            title: category.title,
            description: category.description,
            onPressed: () {
              // Navegar a la vista de selección de widgets
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WidgetCategoryPage(category.id, category.title),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}


class CategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback onPressed;

  CategoryCard({
    required this.image,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 200,
        height: 430,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            children: [
              SizedBox(
                width: 200,
                height: 110,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(image),
                ),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  description,
                  maxLines: 4,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}