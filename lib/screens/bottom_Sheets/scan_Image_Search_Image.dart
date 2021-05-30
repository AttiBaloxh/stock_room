import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/add_Items/sell_Part.dart';

class ScanImageSearchImage extends StatefulWidget {
  static String id = "ScanImageSearchImage";

  @override
  _ScanImageSearchImageState createState() => _ScanImageSearchImageState();
}

class _ScanImageSearchImageState extends State<ScanImageSearchImage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 217,
      padding: EdgeInsets.fromLTRB(15, 0, 15, 20),
      decoration: BoxDecoration(
          color: KWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                width: 30,
                height: 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(10),
                    right: Radius.circular(10),
                  ),
                  color: Color(0xffD5DDE0),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3),
                ),
                elevation: 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: KWhiteColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  height: 48,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/ic_search.png',
                            height: 30,
                          )
                        ],
                      ),
                      hintText: "Belt Tightener",
                      hintStyle: TextStyle(
                        color: KBlackColor,
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 56,
            width: MediaQuery.of(context).size.width * 0.75,
            child: MaterialButton(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              color: KPrimaryColor,
              textColor: Color(0xfffafafa),
              onPressed: () {
                setState(() {
                  //Used for hide bottom sheet
                  Navigator.pop(context);
                  //for move to next screen
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => SellPart(),
                    ),
                  );
                });
              },
              child: Text(
                "Scan Barcode",
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
