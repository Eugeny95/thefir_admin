import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffe_admin/MyWidgets/OrderPreview.dart';
import 'package:coffe_admin/controllers/OrdersController.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/OrdersObject.dart';

Key scrollKey = GlobalKey();

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() {
    return _OrderPageState();
  }
}

class _OrderPageState extends State<OrderPage> {
  List<Widget> orderPreview = [];
  _OrderPageState() {}

  @override
  Widget build(BuildContext context) {
    print('rebuild');
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    List<OrderObject> activeOrders =
        Provider.of<OrderController>(context, listen: true).activeOrders;

    orderPreview = [];
    for (var order in activeOrders) {
      orderPreview.add(OrderPreview(
        order,
        key: UniqueKey(),
      ));
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Активные заказы ',
          style: TextStyle(color: Colors.black)),
        ),
        body: ListView(key: scrollKey, children: [
          Column(children: orderPreview),
          Container(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                 borderRadius: BorderRadius.circular(12), // <-- Radius
                ),
                  elevation: 5,
                  minimumSize: Size( height * 0.3,   width * 0.15 )
              ),
              onPressed: () {
                Provider.of<OrderController>(context, listen: false)
                    .getActiveOrders();
              },
              child: Text('Обновить',
              style: TextStyle(color: Colors.black))))
        ]));
  }
}
