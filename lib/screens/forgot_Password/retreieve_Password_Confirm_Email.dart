import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/alert_Dialouges/confirm_Email_Pop_Up.dart';

class RetreievePasswordConfirmEmail extends StatefulWidget {
  static String id = "RetreievePasswordConfirmEmail";

  @override
  _RetreievePasswordConfirmEmailState createState() => _RetreievePasswordConfirmEmailState();
}

class _RetreievePasswordConfirmEmailState extends State<RetreievePasswordConfirmEmail> {
  TextEditingController recoverPassConfirmEmail = TextEditingController();
  var buttonColor = KPrimaryColor;
  var buttonTextColor = KSecondaryColor;
  var buttonBorderColor = KPrimaryColor;

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
        title: Container(
          child: Image.asset(
            'assets/StockRoom.png',
            height: 15.85,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Retreieve your\nPassword",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: KBlackColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Confirm Email Address",
                style: TextStyle(
                  color: KBlackColor.withOpacity(0.4),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: recoverPassConfirmEmail,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: KPrimaryColor,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: KBlackColor,
                ),
                decoration: InputDecoration(
                  hintText: "Bilialmass@gmail.com",
                  hintStyle: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: KBlackColor.withOpacity(0.4),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.82,
                  decoration: BoxDecoration(
                    border: Border.all(color: buttonBorderColor),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  height: 46,
                  child: MaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    color: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => ConfirmEmailPopUp(),
                      );
                    },
                    child: Text(
                      "Send Recover Link",
                      style: TextStyle(
                        color: buttonTextColor,
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
