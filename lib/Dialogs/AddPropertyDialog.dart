import 'package:coffe_admin/Dialogs/EditDishDialog.dart';
import 'package:coffe_admin/controllers/DishObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddPropertyDialog extends StatefulWidget {
  var baseClass;

  AddPropertyDialog(this.baseClass);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddPropertyDialogState(baseClass);
  }
}

class AddPropertyDialogState extends State<AddPropertyDialog> {
  var baseClass;
  Option property = Option();
  AddPropertyDialogState(this.baseClass);
  @override
  Widget build(BuildContext context) {
    // initialValueWidget = Column();
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return AlertDialog(
        title: Text('Добавить свойство'),
        content: Container(
          width: width * 0.96,
          child: Column(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    cursorColor: Color.fromARGB(255, 77, 77, 77),
                    validator: (value) {},
                    onChanged: (String value) {
                      property.name = value;
                    },
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(255, 77, 77, 77))),
                      fillColor: Color.fromARGB(255, 77, 77, 77),
                      focusColor: Color.fromARGB(255, 77, 77, 77),
                      labelText: 'Наименование',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                    ),
                  )),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    cursorColor: Color.fromARGB(255, 77, 77, 77),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      //FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        try {
                          final text = newValue.text;
                          if (text.isNotEmpty) double.parse(text);
                          return newValue;
                        } catch (e) {}
                        return oldValue;
                      })
                    ],
                    validator: (value) {},
                    onChanged: (String value) {
                      property.price = double.parse(value);
                    },
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 77, 77, 77))),
                        fillColor: Color.fromARGB(255, 77, 77, 77),
                        focusColor: Color.fromARGB(255, 77, 77, 77),
                        labelText: 'Цена',
                        labelStyle:
                            TextStyle(color: Color.fromARGB(255, 77, 77, 77))),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    elevation: 5,
                    minimumSize: Size(height * 0.65, width * 0.13),
                  ),
                  onPressed: () {
                    baseClass.dishObject.options.add(property);
                    baseClass.dishObject.options =
                        baseClass.dishObject.options.toSet().toList();
                    baseClass.setState(() {});
                    Navigator.pop(context);
                    ;
                  },
                  child: Text('Добавить свойство',
                      style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))))
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))));
  }
}

class AddPriceOfVolumeDialog extends StatefulWidget {
  var baseClass;

  AddPriceOfVolumeDialog(this.baseClass);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddPriceOfVolumeDialogState(baseClass);
  }
}

class AddPriceOfVolumeDialogState extends State<AddPriceOfVolumeDialog> {
  var baseClass;
  Option option = Option();
  AddPriceOfVolumeDialogState(this.baseClass);
  @override
  Widget build(BuildContext context) {
    // initialValueWidget = Column();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // TODO: implement build
    return AlertDialog(
        title: Text('Добавить объём'),
        content: Container(
          width: width * 0.96,
          child: Column(
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    cursorColor: Color.fromARGB(255, 77, 77, 77),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        try {
                          final text = newValue.text;
                          if (text.isNotEmpty) double.parse(text);
                          return newValue;
                        } catch (e) {}
                        return oldValue;
                      })
                    ],
                    validator: (value) {},
                    onChanged: (String value) {
                      option.name = (value);
                    },
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 77, 77, 77))),
                        fillColor: Color.fromARGB(255, 77, 77, 77),
                        focusColor: Color.fromARGB(255, 77, 77, 77),
                      labelText: 'Объем, мл',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                    ),
                  )),
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: TextFormField(
                    cursorColor: Color.fromARGB(255, 77, 77, 77),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      //FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]')),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        try {
                          final text = newValue.text;
                          if (text.isNotEmpty) double.parse(text);
                          return newValue;
                        } catch (e) {}
                        return oldValue;
                      })
                    ],
                    validator: (value) {},
                    onChanged: (String value) {
                      option.price = double.parse(value);
                    },
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(255, 77, 77, 77))),
                        fillColor: Color.fromARGB(255, 77, 77, 77),
                        focusColor: Color.fromARGB(255, 77, 77, 77),
                      labelText: 'Цена, руб',
                      labelStyle:
                          TextStyle(color: Color.fromARGB(255, 77, 77, 77)),
                    ),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // <-- Radius
                    ),
                    elevation: 5,
                    minimumSize: Size(height * 0.65, width * 0.13),
                  ),
                  onPressed: () {
                    baseClass.dishObject.fieldSelection!.fields.add(option);

                    baseClass.setState(() {});
                    Navigator.pop(context);
                  },
                  child: Text('Добавить',
                      style: TextStyle(color: Color.fromARGB(255, 77, 77, 77))))
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))));
  }
}
