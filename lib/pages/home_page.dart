import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inmobiliaria/models/property_model.dart';
import 'package:inmobiliaria/providers/properties_provider.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map<String, String> typeOfProperties = {
    "house"     : "Casa",
    "ranch"     : "Finca",
    "apartment" : "Apartamento",
  };

  Map<String, dynamic> properties;

  List propertyTypeDropdown = [];
  String propertyTypeValue;

  List propertiesDropdown = [];
  PropertyModel propertyValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inmobiliaria La Choza'),
      ),
      body: FutureBuilder(
        future: propertiesProvider.loadData(),
        builder: (BuildContext context, AsyncSnapshot< Map<String, dynamic> > snapshot) {  

          if( snapshot.hasData ) {
            // snapshot.data.forEach((key, value) {
            //   propertyTypeDropdown.add(key);

            // });
            properties = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _menu(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Divider(
                          color: Colors.black26,
                          height: 30.0,
                        )
                      ),
                    ),
                  ]
                ),
                _selected(),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: Divider(
                          color: Colors.black26,
                          height: 30.0,
                        )
                      ),
                    ),
                  ]
                ),
                ElevatedButton(
                  onPressed: ( ) {
                    SystemNavigator.pop();
                  },
                  child: Text('Salir')
                )
              ],
            );
          } else { 
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )
    );
  }

  Widget _menu() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Tipo de inmueble'),
          DropdownButton(
            value: propertyTypeValue,
            hint: Text('Seleccionar'),
            items: properties.keys.map(
              ( value ) => DropdownMenuItem(
                value: value,
                child: Text(typeOfProperties[value])
              )
            ).toList(),
            onChanged: ( value ) {
              propertyTypeValue = value;
              propertyValue = null;
              propertiesDropdown = properties[value];
              setState(() {
                
              });
            }
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Divider(
                    color: Colors.black26,
                    height: 30.0,
                  )
                ),
              ),
            ]
          ),
          Text('Inmueble'),
          DropdownButton(
            value: propertyValue?.caption,
            hint: Text('Seleccionar'),
            items: properties[propertyTypeValue]?.map<DropdownMenuItem<String>>(
              ( value ) {
                return DropdownMenuItem<String>(
                  value: value.caption,
                  child: Text( value.caption )
                );
              }
            )?.toList(),
            onChanged: ( value ) {
              print(propertyValue);
              propertyValue = properties[propertyTypeValue].firstWhere(( element ) 
                => element.caption == value
              );
              setState(() {
                
              });
            }
          ),
        ],
      ),
    );
  }

  Widget _selected() {

    if ( propertyValue != null ) {
      return GestureDetector(
        onTap: ( ) {
          Navigator.of(context).pushNamed('property', arguments: propertyValue);
        },
        child: Image.asset(propertyValue.picture),
      );
    } else {
      return Text('No hay propiedad seleccionada');
    }
  }
}