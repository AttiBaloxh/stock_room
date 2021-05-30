import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/add_Items/add_Product_New.dart';
import 'package:stock_room_app/screens/add_Items/scan_Barcodes/scan_Barcode.dart';
import 'package:stock_room_app/screens/drawer/drawer.dart';

class SellPart extends StatefulWidget {
  static String id = "SellPart";

  @override
  _SellPartState createState() => _SellPartState();
}

class _SellPartState extends State<SellPart> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: KSecondaryColor,
        leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState.openDrawer();
          },
          icon: Image.asset(
            'assets/Group 77.2.png',
            height: 18,
          ),
        ),
        title: Text(
          "Start Selling",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: KBlackColor),
        ),
        centerTitle: true,
      ),
      drawer: MyDrawer(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 191,
                    width: 191,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: KPrimaryColor,
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/Group 298 5x.png',
                        height: 98,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: Text(
                      "Upload your product and make it available for sales.",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        color: KBlackColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: [
                  Container(
                    height: 56,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: MaterialButton(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      color: KPrimaryColor,
                      textColor: Color(0xfffafafa),
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => ScanBarcode(),
                          ),
                        );
                      },
                      child: Text(
                        "Scan Barcode",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 54,
                    decoration: BoxDecoration(
                      border: Border.all(color: KPrimaryColor, width: 2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 0,
                      color: Color(0xffffffff),
                      textColor: KPrimaryColor,
                      splashColor: Color(0xfffafafa),
                      highlightColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => AddProductNew(),
                          ),
                        );
                      },
                      child: Text(
                        "Add Manually",
                        style: TextStyle(fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
