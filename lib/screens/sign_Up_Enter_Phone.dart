import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/phone_auth/pin_code.dart';
import 'sign_In.dart';
import 'package:country_code_picker/country_code_picker.dart';

class SignUpEnterPhone extends StatefulWidget {
  static String id = "SignUpEnterPhone";

  @override
  _SignUpEnterPhoneState createState() => _SignUpEnterPhoneState();
}

class _SignUpEnterPhoneState extends State<SignUpEnterPhone> {
  TextEditingController otpChecker = TextEditingController();
  var buttonColor = KPrimaryColor;
  var buttonTextColor = KSecondaryColor;
  var buttonBorderColor = KPrimaryColor;

  var imgVisibility = false;
  var actionVisibility = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Visibility(
          visible: imgVisibility,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Rectangle 11.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: KPrimaryColor.withOpacity(0.85),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
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
        actions: [
          Visibility(
            visible: actionVisibility,
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Center(
                child: Text(
                  "Skip",
                  style: TextStyle(color: KSecondaryColor.withOpacity(0.5)),
                ),
              ),
            ),
          ),
        ],
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
                "Sign up\nwith your phone\nnumber",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Phone Number",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(
                    () {
                      if (otpChecker.text.isNotEmpty) {
                        buttonColor = KPrimaryColor;
                        buttonTextColor = KSecondaryColor;
                        imgVisibility = true;
                        actionVisibility = false;
                      } else {
                        buttonColor = KSecondaryColor;
                        buttonTextColor = KPrimaryColor;
                        imgVisibility = false;
                        actionVisibility = true;
                      }
                    },
                  );
                },
                controller: otpChecker,
                decoration: InputDecoration(
                  prefixIcon: Container(
                    width: 123,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: KBlackColor,
                          ),
                        ),
                        Container(
                          child: CountryCodePicker(
                            onChanged: print,
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'IT',
                            favorite: ['+1', 'US'],
                            // optional. Shows only country name and flag
                            showCountryOnly: false,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                          ),
                        ),
                      ],
                    ),
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
                      Navigator.push(
                        context,
                        new MaterialPageRoute(
                          builder: (context) => PinCode(),
                        ),
                      );
                    },
                    child: Text(
                      "Log in",
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
      bottomNavigationBar: BottomAppBar(
        color: KSecondaryColor,
        elevation: 0,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      new MaterialPageRoute(builder: (context) => SignIn()));
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Have an account?",
                      style: TextStyle(
                        color: KPrimaryColor,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    TextSpan(
                      text: " Log In",
                      style: TextStyle(
                        color: KPrimaryColor,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
