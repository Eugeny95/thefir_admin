import 'package:coffe_admin/Dialogs/AddPropertyDialog.dart';
import 'package:coffe_admin/MyWidgets/AddPicture.dart';
import 'package:coffe_admin/MyWidgets/DropListWrapper.dart';
import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:coffe_admin/controllers/DishObject.dart';
import 'package:coffe_admin/pages/HomePage/HomePage.dart';
import 'package:coffe_admin/utils/Network/RestController.dart';
import 'package:coffe_admin/utils/Security/validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/Network/MultiPart.dart';

// TODO можно в будущем сделать категории подгружаемыми с интернета
List<String> caterories = [
  'Чёрный кофе',
  "Классика",
  "Не кофе",
  "Чай",
  "Смузи",
  "Авторские напитки",
  "COLD",
  "Милкшейки",
  'LIMONADES'
];

class EditDishDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditDishDialogState();
  }
}

class EditDishDialogState extends State<EditDishDialog> {
  final _formKey = GlobalKey<FormState>();
  String image = '';
  bool isCancel = false;
  bool isImageUploaded = true;
  DishObject dishObject = DishObject();

  EditDishDialogState() {
    dishObject.category = 'coffe';
    dishObject.subcategory = caterories[0];
  }
  @override
  Widget build(BuildContext context) {
    AddPicture addPic = AddPicture(
        url: '',
        onFileLoaded: (path) {
          isImageUploaded = false;
          print('Worked' + path);
        },
        onFileUploaded: (url) {
          print('picture uploaded!');
          dishObject.picture = url;
          isImageUploaded = true;
        });
    List<Widget> propertiesWidget = [];
    List<Widget> volumesWidget = [];
    for (Option property in dishObject.options) {
      propertiesWidget.add(Row(children: [
        Expanded(
          child: Text(property.name),
          flex: 3,
        ),
        Text(property.price.toString()),
        IconButton(
            onPressed: () {
              dishObject.options.remove(property);
              setState(() {});
            },
            icon: Icon(Icons.close))
      ]));
    }
    for (Option option in dishObject.fieldSelection!.fields) {
      volumesWidget.add(Row(children: [
        Expanded(
          child: Text(option.name),
          flex: 3,
        ),
        Text(option.price.toString()),
        IconButton(
            onPressed: () {
              dishObject.fieldSelection!.fields.remove(option);
              setState(() {});
            },
            icon: Icon(Icons.close))
      ]));
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      //title: Text("Редактирование меню"),
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Создание напитка',
          style: TextStyle(color: Colors.black)),
      ),
      body: ListView(shrinkWrap: true, children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          LimitedBox(
              maxWidth: width * 0.95,
              child: Container(
                  width: width * 0.95,
                  child: Form(
                      key: _formKey,
                      child: Column(children: [
                        SizedBox(
                          height: 25,
                        ),
                        
                        addPic,
                       
                        Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: 
                            TextFormField(
                              cursorColor: Color.fromARGB(255, 77, 77, 77),
                              validator: (value) {
                                return Validator.isEmptyValid(value!);
                              },
                              onChanged: (String value) {
                                dishObject.name = value;
                              },
                              decoration: InputDecoration(
                                fillColor: Color.fromARGB(255, 77, 77, 77),
                            focusColor: Color.fromARGB(255, 77, 77, 77),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                              focusedBorder: 
                              OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color.fromARGB(255, 77, 77, 77),
                                width: 2.0)),
                                labelText: 'Наименование напитка',
                                labelStyle: TextStyle(
                                color: Color.fromARGB(255, 77, 77, 77))
                              ),
                            )),
                        Divider(color: Colors.white),
                        DropListWrapper(
                            items: caterories,
                            onSelect: (String newValue) {
                              dishObject.subcategory = newValue;
                            }),
                        Divider(color: Colors.white),
                        Text('Добавьте доступные объёмы'),
                        Row(children: [
                          Expanded(
                            child: Text('Объем'),
                            flex: 1,
                          ),
                          Text('Цена')
                        ]),
                        Column(children: volumesWidget),
                        Padding(padding:EdgeInsets.all(5)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // <-- Radius
    ),
      elevation: 5,
      minimumSize: Size( height * 0.65,   width * 0.13 ),
      ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return (AddPriceOfVolumeDialog(this));
                                    
                                  });
                            },
                            child: Text('Добавить объём',
          style: TextStyle(color: Color.fromARGB(255, 69, 69, 69)))),
                        Divider(color: Colors.black),
                        Row(children: [
                          Expanded(
                            child: Text('Название добавки'),
                            flex: 3,
                          ),
                          Text('Цена')
                        ]),
                        Column(children: propertiesWidget),
                        Padding(padding:EdgeInsets.all(5)),
                        ElevatedButton(
                           style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // <-- Radius
    ),
      elevation: 5,
      minimumSize: Size( height * 0.65,   width * 0.13 ),
      ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return (AddPropertyDialog(this));
                                  });
                            },
                            child: Text('Добавить свойство',
          style: TextStyle(color: Color.fromARGB(255, 69, 69, 69)))),
                        Divider(color: Colors.black),
                        TextField(
                          cursorColor: Color.fromARGB(255, 77, 77, 77),
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          onChanged: (String value) {
                            dishObject.description = value;
                          },
                          decoration: InputDecoration(
                            fillColor: Color.fromARGB(255, 77, 77, 77),
                            focusColor: Color.fromARGB(255, 77, 77, 77),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                              focusedBorder: 
                              OutlineInputBorder( 
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: Color.fromARGB(255, 77, 77, 77),
                                width: 2.0)),
                            prefixIcon: Icon(Icons.description, color: Color.fromARGB(255, 94, 94, 94)),
                            labelText: 'Введите описание',
                            labelStyle: TextStyle(
                                color: Color.fromARGB(255, 77, 77, 77))
                          ),
                        ),
                        Divider(color: Colors.black),
                        ElevatedButton(
                           style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // <-- Radius
    ),
      elevation: 5,
      minimumSize: Size( height * 0.65,   width * 0.13 ),
      ),
                            onPressed: () {
                              if (dishObject.fieldSelection.fields.isNotEmpty) {
                                if (_formKey.currentState!.validate()) {
                                  Provider.of<CoffeHouse>(context,
                                          listen: false)
                                      .createCoffe(dishObject);

                                  Provider.of<CoffeHouse>(context,
                                          listen: false)
                                      .getCoffes();

                                  Navigator.pop(context);
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Добавьте хотя-бы обин доступынй объем!')),
                                );
                              }
                            },
                            child: Text('Сохранить',
          style: TextStyle(color: Color.fromARGB(255, 69, 69, 69)))),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                             style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // <-- Radius
    ),
      elevation: 5,
      minimumSize: Size( height * 0.65,   width * 0.13 ),
      ),
                            onPressed: () {
                              if (isImageUploaded) {
                                isCancel = true;

                                Navigator.pop(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          'Дождитесь окончания загрузки изображения на сервер',
          style: TextStyle(color: Color.fromARGB(255, 69, 69, 69)))),
                                );
                              }
                            },
                            child: Text('Отмена',
          style: TextStyle(color: Color.fromARGB(255, 69, 69, 69))),
                          ),
                        ),
                      ]))))
        ])
      ]),
    );
    // TODO: implement build
  }

  @override
  void dispose() {
    if (isCancel) {
      RemoteFileManager().deleteFile(url: dishObject.picture);
    }
    print('dispose');
    super.dispose();
  }
}
