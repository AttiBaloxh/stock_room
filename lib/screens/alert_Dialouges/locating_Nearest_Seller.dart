import 'dart:async';

import 'package:stock_room_app/constant.dart';
import 'package:flutter/material.dart';
import 'package:stock_room_app/screens/map_Screens/locale_Parts.dart';

class LocationNearestSeller extends StatefulWidget {
  static String id = "LocationNearestSeller";
  final userId;
  final userImage;
  final userName;
 final String productImage;
 final String productName;
 final String productOnSell;
 final String productPTACAccessories;
 final String productSKU;
 final String productPrice;
  LocationNearestSeller({this.productImage,this.productName,this.productSKU,this.productPTACAccessories,this.productOnSell,this.productPrice ,this.userName, this.userImage, this.userId,});
  @override
  _LocationNearestSellerState createState() => _LocationNearestSellerState();
}

class _LocationNearestSellerState extends State<LocationNearestSeller> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
          builder: (context) => LocalParts(
            productImage: widget.productImage,
            productName: widget.productName,
            productOnSell: widget.productOnSell,
            productPTACAccessories:widget.productPTACAccessories ,
            productPrice:widget.productPrice ,
            productSKU: widget.productSKU,
            userId: widget.userId,
            userImage: widget.userImage,
            userName: widget.userName,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        // color: Color(0xff0F1423),
        height: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: KWhiteColor,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.close,
                      size: 20,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/loader 2.png',
                    height: 218,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Locating the nearest seller...",
                    style: TextStyle(
                      fontSize: 16,
                      color: KWhiteColor,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.none,
                      fontFamily: "Montserrat",
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
