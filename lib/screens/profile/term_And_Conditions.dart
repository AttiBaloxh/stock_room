import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';

class TermsAndConditions extends StatefulWidget {
  static String id = "TermsAndConditions";

  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Terms & Conditions",
          style: TextStyle(
            color: KWhiteColor,
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Lorem ipsum dolor sit amet, "
                  "consectetur adipiscing elit, "
                  "sed do eiusmod tempor incididunt "
                  "ut labore et dolore magna aliqua. "
                  "Ut enim ad minim veniam, quis nostrud "
                  "exercitation ullamco laboris nisi ut "
                  "aliquip ex ea commodo consequat. ",
                  style: TextStyle(
                    fontSize: 14,
                    color: KBlackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Duis aute irure dolor in reprehenderit in"
                  " voluptate velit esse cillum dolore eu fugiat "
                  "nulla pariatur. Excepteur sint occaecat cupidatat "
                  "non proident, sunt in culpa qui officia deserunt mollit "
                  "anim id est laborum.",
                  style: TextStyle(
                    fontSize: 14,
                    color: KBlackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur "
                  "adipiscing elit, sed do eiusmod tempor incididunt "
                  "ut labore et dolore magna aliqua. Ut enim ad minim veniam,"
                  " quis nostrud exercitation ullamco laboris nisi ut aliquip"
                  " ex ea commodo consequat. ",
                  style: TextStyle(
                    fontSize: 14,
                    color: KBlackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 70),
                child: Text(
                  "Duis aute irure dolor in reprehenderit in"
                  "voluptate velit esse cillum dolore eu fugiat "
                  "nulla pariatur. Excepteur sint occaecat cupidatat "
                  "non proident, sunt in culpa qui officia deserunt mollit "
                  "anim id est laborum.",
                  style: TextStyle(
                    fontSize: 14,
                    color: KBlackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.82,
                  height: 46,
                  child: MaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    color: KPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   new MaterialPageRoute(
                      //     builder: (context) => SignUpOtpCode(),
                      //   ),
                      // );
                    },
                    child: Text(
                      "About Version",
                      style: TextStyle(
                        color: KWhiteColor,
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
    );
  }
}
