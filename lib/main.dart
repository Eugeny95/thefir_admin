import 'dart:isolate';

import 'package:coffe_admin/controllers/OrderNotification.dart';
import 'package:coffe_admin/controllers/OrdersController.dart';
import 'package:coffe_admin/pages/HomePage/HomePage.dart';
import 'package:coffe_admin/pages/HomePage/TestPage.dart';
import 'package:coffe_admin/pages/OrderPage/OrderPage.dart';
import 'package:coffe_admin/utils/Custom_Theme.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'controllers/CoffeHouseObject.dart';
import 'package:coffe_admin/pages/Orders/Orders.dart';
import 'package:coffe_admin/controllers/CoffeHouseObject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/HomePage/HomePage.dart';
import 'package:coffe_admin/utils/constance.dart';



ReceivePort? _receivePort;
void main() async {
  await Hive.initFlutter();
  
 OrderNotification ();
 // await initForegroundTask();
 // await startForegroundTask();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => CoffeHouse()),
          ChangeNotifierProvider(create: ((context) => OrderController()))
        ],
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            //  '/': (context) =>  HomePage(),
            '/resume-route': (context) => QRViewExample(),
          },
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: basicTheme(),
          home: MainPage(),
        ));
  }
}

class MainPage extends StatefulWidget {
  MainPage() {
    /* _receivePort?.listen((message) {
      if (message == 'onNotificationPressed') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Orders()));
      }
    });*/
  }
  @override
  MyWidget createState() {
    // TODO: implement createState
    return MyWidget();
  }
}

class MyWidget extends State {
  void _onItemTapped(ind) {
    setState(() {
      Provider.of<CoffeHouse>(context, listen: false).getMainData();

      index = ind;
    });
  }

  int index = 0;
  List<Widget> Screens = [HomePage(), OrderPage(), QRViewExample()];

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Scaffold(
      body: Center(child: Screens[index]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromARGB(255, 38, 38, 38),
        currentIndex: index,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.coffee),
            label: 'Меню',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_rounded),
            label: 'Заказы',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets_outlined),
            label: 'Админ',
          ),
        ],
      ),
    );
  }
}
