import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:dotted_border/dotted_border.dart';
import '../../controllers/OrdersController.dart';
import '../OrderPage/UserOrderPage.dart';

class QRViewExample extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _QRViewExampleState();
  }
}

class _QRViewExampleState extends State<QRViewExample> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // return Scaffold(
    //   body: Stack(children: [
    //     Column(
    //       children: <Widget>[
    //         // Expanded(
    //         //   flex: 5,
    //         //   child: QRView(
    //         //     key: qrKey,
    //         //     onQRViewCreated: _onQRViewCreated,
    //         //   ),
    //         // ),
    //         Expanded(
    //           flex: 1,
    //           child: Center(
    //             child: Text('Поместите QR-код в рамку'),
    //           ),
    //         )
    //       ],
    //     ),
    //     // Positioned(
    //     //     left: width / 7,
    //     //     top: height / 5,
    //     //     child: DottedBorder(
    //     //       // PathBuilder
    //     //       color: Color.fromARGB(255, 63, 181, 63),
    //     //       dashPattern: [8, 4],
    //     //       strokeWidth: 2,
    //     //       child: Container(
    //     //         height: width * 0.7,
    //     //         width: width * 0.7,
    //     //         color: Colors.green.withAlpha(20),
    //     //       ),
    //     //     ))
    //   ]),
    // );
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.black),
            backgroundColor: Colors.white,
            title: Text('Панель администратора',
                style: TextStyle(color: Colors.black))),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: height * 0.05,
              ),
              Center(
                  child: Container(
                      width: width / 1.01,
                      height: height / 3.8,
                      child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(children: [
                            Text("Введите сообщение PUSH уведомления",
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 77, 76, 76)
                            )),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Container(
                              width: width / 1.08,
                              height: height / 8,
                              child: TextFormField(
                                minLines: 3,
                                maxLines: 5,
                                cursorColor: Color.fromARGB(255, 97, 97, 97),
                                validator: (value) {},
                                onChanged: (String value) {},
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromARGB(255, 97, 97, 97),
                                            width: 2.0)),
                                    prefixIcon: Icon(Icons.mail_outline_outlined,
                                        color: Color.fromARGB(255, 97, 97, 97)),
                                    labelText: 'Введите текст (не более 3 строк)',
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 97, 97, 97))),
                              ),
                            ),
                            ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // <-- Radius
                                      ),
                                      elevation: 5,
                                      minimumSize:
                                          Size(height * 0.4, width * 0.15)),
                                  onPressed: () async {},
                                  child: Text(
                                    'Отправить клиентам',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 26, 26, 26)),
                                  )),
                          ])))),
                          SizedBox(
                height: height * 0.05,
              ),
              Center(
                  child: Container(
                      width: width / 1.01,
                      height: height / 4.7,
                      child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Column(children: [
                            Text(
                                "Введите телефон клиента, для списания бонусов",
                                 style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(255, 77, 76, 76)
                            )),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Container(
                                width: width / 1.08,
                                height: height / 15,
                                child: TextFormField(
                                  cursorColor:
                                      Color.fromARGB(255, 104, 103, 103),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9.,]'))
                                  ],
                                  onChanged: (String value) {},
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 97, 97, 97),
                                              width: 2.0)),
                                      prefixIcon: Icon(Icons.phone_iphone,
                                          color:
                                              Color.fromARGB(255, 97, 97, 97)),
                                      labelText: 'Телефон',
                                      labelStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 97, 97, 97))),
                                )),
                                SizedBox(
                              height: height * 0.01,
                            ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            12), // <-- Radius
                                      ),
                                      elevation: 5,
                                      minimumSize:
                                          Size(height * 0.4, width * 0.15)),
                                  onPressed: () async {},
                                  child: Text(
                                    'Списать бонусы',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 26, 26, 26)),
                                  )),
                          ])))),
             
            ]));
  }

  bool flag = true;
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      result = scanData;

      await controller.pauseCamera();

      if (result != null) {
        OrderController()
            .getUsersActiveOrders(int.parse(result!.code.toString()));
        await Navigator.push(
            context, MaterialPageRoute(builder: (context) => UserOrderPage()));

        result = null;
      }

      await controller.resumeCamera();
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
