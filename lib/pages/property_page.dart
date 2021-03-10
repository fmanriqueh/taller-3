import 'package:flutter/material.dart';
import 'package:inmobiliaria/models/property_model.dart';

class PropertyPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final PropertyModel property = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(property.caption),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(property.picture),
            Text(property.caption),
            Text(property.canon),
          ],
        ),
      ),
    );
  }
}