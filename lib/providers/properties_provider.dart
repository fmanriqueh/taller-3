import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:inmobiliaria/models/property_model.dart';

class _PropertiesProvider {

  Map<String, dynamic> properties = {};

  Future< Map<String, dynamic> > loadData() async{

    final resp = await rootBundle.loadString('data/properties.json');
    
    Map<String, dynamic> dataMap = json.decode( resp );

    dataMap.forEach((key, value) {
      properties[key] = value.map( (element ) => PropertyModel.fromJson(element)).toList();
    });
    
    return properties;
  }

}

final propertiesProvider = new _PropertiesProvider();