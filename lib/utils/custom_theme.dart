import 'package:flutter/material.dart';

import 'package:coffe_admin/utils/constance.dart';

ThemeData basicTheme() => ThemeData(
        brightness: Brightness.light,
        primaryColor: kPrimaryColor,

        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 97, 97, 97),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 235, 235, 235)),
        )),

        textTheme: const TextTheme(
          bodyText2: TextStyle(
            fontFamily: 'PTSansNarrow',
            fontSize: 16,
            color: Color.fromARGB(255, 46, 46, 46),
          ),
          //Освоено
          bodyText1: TextStyle(
            fontFamily: FontNameDefault,
            fontSize: BodyTextSize,
            color: Colors.green,
          ),
        ),

        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),

        accentColor: Colors.white,
        buttonTheme: ButtonThemeData(
          height: 80,
          buttonColor: Colors.white,
          textTheme: ButtonTextTheme.accent,
        ),

        // bottomAppBarColor: Colors.deepPurple,
        // cardColor: Colors.orange.shade100,
        // scaffoldBackgroundColor: Colors.yellow,
      );

