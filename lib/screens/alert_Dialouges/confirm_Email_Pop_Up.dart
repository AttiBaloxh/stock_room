import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';

class ConfirmEmailPopUp extends StatefulWidget {
  static String id = "ConfirmEmailPopUp";

  @override
  _ConfirmEmailPopUpState createState() => _ConfirmEmailPopUpState();
}

class _ConfirmEmailPopUpState extends State<ConfirmEmailPopUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 92,
                    height: 92,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: KLightGreyColor,
                        border: Border.all(
                          color: KPrimaryColor.withOpacity(0.1),
                        )
                    ),
                    child: Center(
                      child: Image.asset(
                        'assets/Group 319.png',
                        height: 38.04,
                      ),
                    ),
                  ),
                  Text(
                    "We have sent you a recover link to retrieve your password.",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: KBlackColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.82,
                      height: 48,
                      child: MaterialButton(
                        elevation: 0,
                        highlightElevation: 0,
                        color: KPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   new MaterialPageRoute(
                          //     builder: (context) => SignUpEnterPhone(),
                          //   ),
                          // );
                        },
                        child: Text(
                          "Go to Email",
                          style: TextStyle(
                            color: KSecondaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
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
    );
  }
}
