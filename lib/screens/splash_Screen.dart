import 'dart:async';
import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/get_Started.dart';
class SplashScreen extends StatefulWidget {
  static String id = "SplashScreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),() {
      Navigator.pushReplacement(context,
      new MaterialPageRoute(builder: (context) => GetStarted())
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Rectangle 11.png'),
              fit: BoxFit.cover,
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: KPrimaryColor.withOpacity(0.85),
                  ),
                  child: Center(child: Image.asset('assets/StockRoom.png',height: 23.94,)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
