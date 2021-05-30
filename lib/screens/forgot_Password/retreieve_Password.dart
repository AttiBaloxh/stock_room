import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/forgot_Password/retreieve_Password_Confirm_Email.dart';

class RetreievePassword extends StatefulWidget {
  static String id = "RetreievePassword";

  @override
  _RetreievePasswordState createState() => _RetreievePasswordState();
}

class _RetreievePasswordState extends State<RetreievePassword> {
  TextEditingController recoverPass = TextEditingController();
  var buttonColor = KPrimaryColor;
  var buttonTextColor = KSecondaryColor;
  var buttonBorderColor = KPrimaryColor;
  // void _changePassword(String password) async {
  //   //Create an instance of the current user.
  //   User user = await FirebaseAuth.instance.currentUser;

  //   //Pass in the password to updatePassword.
  //   user.updatePassword(password).then((_) {
  //     print("Successfully changed password");
  //   }).catchError((error) {
  //     print("Password can't be changed" + error.toString());
  //     //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
  //   });
  // }

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
                "Email Address",
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
                onChanged: (value) {
                  setState(() {
                    if (recoverPass.text.isNotEmpty) {
                      buttonColor = KPrimaryColor;
                      buttonTextColor = KSecondaryColor;
                    } else {
                      buttonColor = KSecondaryColor;
                      buttonTextColor = KPrimaryColor;
                    }
                  });
                },
                controller: recoverPass,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: KPrimaryColor,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: KBlackColor.withOpacity(0.4),
                ),
                decoration: InputDecoration(
                  hintText: "Enter Your Email Address",
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
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => RetreievePasswordConfirmEmail(),
                        ),
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
