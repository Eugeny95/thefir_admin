import 'dart:convert';

import 'package:coffe_admin/utils/Network/RestController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BonusesDialog extends StatefulWidget {
  int userId = -1;
  double cost = 0;
  BonusesDialog({required this.userId, required this.cost, Key? key})
      : super(key: key);

  @override
  State<BonusesDialog> createState() => _BonusesDialogState(userId, cost);
}

class _BonusesDialogState extends State<BonusesDialog> {
  int userId = -1;
  double cost = 0;
  double currentBonusesBalance = 0.0;
  _BonusesDialogState(this.userId, this.cost) {
    RestController().sendGetRequest(
        onComplete: ({required String data, required int statusCode}) {
          var map = jsonDecode(data);
          print('balanxce $currentBonusesBalance');
          currentBonusesBalance = map['bonuses'];
          setState(() {});
        },
        onError: ({required int statusCode}) {},
        controller: 'client_bonuses',
        data: '?user_id=$userId');
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      title: new Text('Завершение заказа'),
      content: Text('Начислить бонусы'),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () async {
            RestController().sendDeleteRequest(
                onComplete: (
                    {required String data, required int statusCode}) {},
                onError: ({required int statusCode}) {},
                controller: 'client_bonuses',
                data: '{"bonuses":$currentBonusesBalance, "user_id":$userId}');
            await showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Иформация об оплате'),
                content:
                    Text('К опалате: ${cost - currentBonusesBalance} руб.'),
                actions: <Widget>[
                  new ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pop(); // dismisses only the dialog and returns nothing
                    },
                    child: new Text('OK'),
                  ),
                ],
              ),
            );
            Navigator.of(context, rootNavigator: true)
                .pop(); // dismisses only the dialog and returns nothing
          },
          child: new Text('Списать $currentBonusesBalance бонусов',
                    style: TextStyle(
                      color: Color.fromARGB(255, 44, 44, 44)
                    ),),
        ),
        ElevatedButton(
          onPressed: () async {
            RestController().sendPostRequest(
                onComplete: (
                    {required String data, required int statusCode}) {},
                onError: ({required int statusCode}) {},
                controller: 'client_bonuses',
                data: '{"bonuses":${cost * 0.01}, "user_id":$userId}');
            await showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                title: new Text('Иформация об оплате'),
                content: Text('К опалате: $cost руб.'),
                actions: <Widget>[
                  new ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pop(); // dismisses only the dialog and returns nothing
                    },
                    child: new Text('OK',
                    style: TextStyle(
                      color: Color.fromARGB(255, 43, 43, 43)
                    ),),
                  ),
                ],
              ),
            );
            Navigator.of(context, rootNavigator: true)
                .pop(); // dismisses only the dialog and returns nothing
          },
          child: new Text('Начислить бонусный стаканчик',
          style: TextStyle(
            color: Color.fromARGB(255, 51, 51, 51)
          ),),
        ),
        ElevatedButton(
          onPressed: () async {
            await showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: new Text('Иформация об оплате'),
                content: Text('К опалате: $cost руб.'),
                actions: <Widget>[
                  new ElevatedButton(
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true)
                          .pop(); // dismisses only the dialog and returns nothing
                    },
                    child: new Text('OK',
                    style: TextStyle(
                      color: Colors.black
                    ),),
                  ),
                ],
              ),
            );
            Navigator.of(context, rootNavigator: true)
                .pop(); // dismisses only the dialog and returns nothing
          },
          child: new Text('Завершить',
                    style: TextStyle(
                      color: Color.fromARGB(255, 28, 28, 28)
                    )),
        ),
      ],
    );
  }
}
