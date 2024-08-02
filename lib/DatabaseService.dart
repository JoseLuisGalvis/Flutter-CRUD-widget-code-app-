import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/category.dart';
import 'model/widget.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._();

  factory DatabaseService() => _instance;

  DatabaseService._();

  Future<List<Category>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('http://localhost:2800/categories'));
      print(response);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body).cast<Map<String, dynamic>>();
        print('jsonData: $jsonData');
        return Future.value(jsonData.map((categoryJson) => Category.fromJson(categoryJson)).toList().cast<Category>());
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      print('Error: $e');
      rethrow; // rethrow the error to propagate it up the call stack
    }
  }

  Future<List<WidgetModel>> getWidgetsByCategory(int categoryId) async {
    final response = await http.get(Uri.parse('https://api.example.com/widgets/$categoryId'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      return jsonData.map((widgetJson) => WidgetModel.fromJson(widgetJson)).toList();
    } else {
      throw Exception('Failed to load widgets');
    }
  }

  Future<void> createCategory(Category category) async {
    final response = await http.post(
      Uri.parse('https://api.example.com/categories'),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode(category.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create category');
    }
  }

  Future<void> createWidget(WidgetModel widget) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:2800/widgets'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(widget.toJson()),
      );

      print(response.body);

      if (response.statusCode != 201) {
        throw Exception('Failed to create widget');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> updateCategory(Category category) async {
    final response = await http.put(
      Uri.parse('https://api.example.com/categories/${category.id}'),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode(category.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update category');
    }
  }

  Future<void> updateWidget(WidgetModel widget) async {
    final response = await http.put(
      Uri.parse('http://localhost:2800/widget/${widget.id}'),
      headers: { 'Content-Type': 'application/json' },
      body: jsonEncode(widget.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update widget');
    }
  }

  Future<void> deleteCategory(int categoryId) async {
    final response = await http.delete(Uri.parse('https://api.example.com/categories/$categoryId'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete category');
    }
  }

  Future<void> deleteWidget(int widgetId) async {
    final response = await http.delete(Uri.parse('http://localhost:2800/widget/$widgetId'));

    if (response.statusCode == 404) {
      throw Exception('Widget not found');
    } else if (response.statusCode != 200) {
      throw Exception('Failed to delete widget');
    }
  }

}