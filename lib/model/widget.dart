
class WidgetModel {
  int id;
  final int categoryId;
  final String name;
  final String description;
  final String image;

  WidgetModel({required this.id, required this.categoryId, required this.name, required this.description, required this.image});

  // Método para convertir el objeto WidgetModel a un Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'name': name,
      'description': description,
      'image': image,
    };
  }

  factory WidgetModel.fromJson(Map<String, dynamic> json) {
    print('json: $json');
      return WidgetModel(
        id: json['id'],
        categoryId: json['category_id'],
        name: json['name'],
        description: json['description'],
        image: json['image'],
      );
  }

}