import 'package:coffe_admin/Dialogs/EditDishDialog.dart';
import 'package:flutter/material.dart';

import '../Dialogs/EditCakeDialog.dart';

class NewDishWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))),
        margin: EdgeInsets.only(top: 10),
        child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditDishDialog(),
                  ));
            },
            child: Container(
                width: width * 0.9,
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40)),
                child: Column(
                  children: [
                    Text('Нажмите,'),
                    Icon(Icons.coffee, size: width / 3),
                    Text('чтобы добавить кофе'),
                  ],
                ))));
  }
}
