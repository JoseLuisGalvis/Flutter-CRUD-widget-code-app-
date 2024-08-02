import 'package:flutter/material.dart';


class UpdateCrudPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget CRUD'),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 3,
          children: [
            Card(
              child: Center(
                child: Text('CREATE'),
              ),
            ),
            Card(
              child: Center(
                child: Text('READ'),
              ),
            ),
            Card(
              child: Center(
                child: Text('UPDATE'),
              ),
            ),
            Card(
              child: Center(
                child: Text('DELETE'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}