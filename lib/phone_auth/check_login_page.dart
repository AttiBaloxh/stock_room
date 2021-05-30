import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:stock_room_app/provider/product.dart';

import '../constant.dart';
import './pin_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CheckingLoginPage extends StatefulWidget {
  final character;
  CheckingLoginPage({this.character});
  static String id = 'CheckingLoginPage';
  @override
  _CheckingLoginPageState createState() => _CheckingLoginPageState();
}

class _CheckingLoginPageState extends State<CheckingLoginPage> {
  bool isLoading = false;
  var verificationIds;
  var countryCode = '92';
  var countryName;
  String _phoneNumber = "";
  TextEditingController _phoneAuthController = TextEditingController();
  ProductProvider productProvider;
  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    setState(() {
      isLoading = true;
    });
    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();

        final UserCredential result =
            await _auth.signInWithCredential(credential);

        User user = result.user;

        if (user != null) {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PinCode(
                charter: widget.character,
                phoneNumber: _phoneNumber,
                verificationId: verificationIds,
                auth: _auth,
              ),
            ),
          );
          setState(() {
            isLoading = false;
          });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Alert Dialog"),
                  content: Text('Error'),
                );
              });
          setState(() {
            isLoading = false;
          });
        }
        setState(() {
          isLoading = false;
        });
      },
      verificationFailed: (var exception) {
        print(exception.toString());
        switch (exception.toString()) {
          case '[firebase_auth/invalid-phone-number] The format of the phone number provided is incorrect. Please enter the phone number in a format that can be parsed into E.164 format. E.164 phone numbers are written in the format [+][country code][subscriber number including area code]. [ TOO_LONG ]':
            print("No");
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Text("Phone Number Is Not Correct"),
                  );
                });
            break;
        }
        setState(() {
          isLoading = false;
        });
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        setState(() {
          verificationIds = verificationId;
        });
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => PinCode(
              phoneNumber: _phoneNumber,
              verificationId: verificationId,
              auth: _auth,
              charter: widget.character,
            ),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
    return true;
  }

  var imgVisibility = false;
  var actionVisibility = true;
  var buttonColor = KPrimaryColor;
  var buttonTextColor = KSecondaryColor;
  var buttonBorderColor = KPrimaryColor;
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    print(widget.character);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isLoading == false
          ? _bodyWidget()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  Widget _bodyWidget() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
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
                    if (_phoneAuthController.text.isNotEmpty) {
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
              controller: _phoneAuthController,
              decoration: InputDecoration(
                prefixIcon: Container(
                  width: 125,
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
                      CountryCodePicker(
                        onChanged: (country) {
                          setState(() {
                            countryCode = country.dialCode;
                            countryName = country.name;
                          });
                        },
                        initialSelection: 'pakistan',
                        // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                        favorite: ['+92', 'pakistan'],
                        // optional. Shows only country name and flag
                        showCountryOnly: false,
                        // optional. Shows only country name and flag when popup is closed.
                        // optional. aligns the flag and the Text left
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
                  onPressed: _submitVerifyPhoneNumber,
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
    );
  }

  User currentUsers = FirebaseAuth.instance.currentUser;
  void _submitVerifyPhoneNumber() async {
    if (_phoneAuthController.text.isNotEmpty) {
      _phoneNumber = "+$countryCode${_phoneAuthController.text}";
      await loginUser(_phoneNumber, context);
    }
  }
}
