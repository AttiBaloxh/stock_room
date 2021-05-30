import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/add_Items/add_Product_New.dart';

class ScanBarcode extends StatefulWidget {

  static String id = "ScanBarcode";

  @override
  _ScanBarcodeState createState() => _ScanBarcodeState();
}

class _ScanBarcodeState extends State<ScanBarcode> {
  GlobalKey qrKey = GlobalKey();
  var qrText = "";
 // QRViewController controller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        leading: Center(
          child: IconButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            icon: Image.asset(
              'assets/Union.png',
              height: 15,
            ),
          ),
        ),
        title: Text(
          "Scan barcode",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: KWhiteColor),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            // Expanded(
            //   child: Container(
            //     margin: EdgeInsets.fromLTRB(15, 0, 15, 30),
            //     child: QRView(
            //       key: qrKey,
            //       overlay: QrScannerOverlayShape(
            //         cutOutSize: 200,
            //         borderRadius: 15,
            //         borderLength: 20,
            //         borderWidth: 30,
            //         borderColor: Colors.red,
            //       ),
            //       // onQRViewCreated: onQRViewCreate(),
            //     ),
            //   ),
            // ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => AddProductNew(),
                  ),
                );
              },
              child: Container(
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Container(
                            child: Image.asset(
                              'assets/Group 295.png',
                              height: 63,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Capture",
                            style: TextStyle(
                                color: KWhiteColor, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // @override
  // void dispose(){
  //   super.dispose();
  //   controller?.dispose();
  // }

  // void onQRViewCreate(QRViewController controller) {
  //   this.controller = controller;
  //   controller.scannedDataStream.listen((scanData) { })
  // }
}
