import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/alert_Dialouges/select_User.dart';
import '../screens/alert_Dialouges/login_user.dart';

class GetStarted extends StatefulWidget {
  static String id = "GetStarted";

  @override
  _GetStartedState createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  color: KPrimaryColor,
                  child: Center(
                      child: Image.asset(
                    'assets/StockRoom.png',
                    height: 23.94,
                  )),
                ),
              ),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: KPrimaryColor,
                          ),
                        ),
                        height: 56,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: MaterialButton(
                          elevation: 0,
                          highlightElevation: 0,
                          shape: StadiumBorder(),
                          color: KPrimaryColor,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => LoginUser(),
                            );
                            // Navigator.push(
                            //   context,
                            //   new MaterialPageRoute(
                            //       builder: (context) => SignIn()),
                            // );
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: KSecondaryColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: KPrimaryColor,
                          ),
                        ),
                        height: 56,
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: MaterialButton(
                          elevation: 0,
                          highlightElevation: 0,
                          shape: StadiumBorder(),
                          color: KSecondaryColor,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => SelectUser(),
                            );
                          },
                          child: Text(
                            "Get Started",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: KPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
