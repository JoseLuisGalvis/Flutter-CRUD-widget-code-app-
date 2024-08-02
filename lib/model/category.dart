import 'package:widget_code_app/model/widget.dart';

class Category {
  int id;
  final String title;
  final String image;
  final String description;
  List<WidgetModel> widgets;

  Category({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.widgets
  });

  // Método para convertir el objeto WidgetModel a un Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'description': description,
    };
  }

  factory Category.fromJson(Map<String, dynamic> json) {
    print('json: $json');
    return Category(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
      widgets: [],
    );
  }

}