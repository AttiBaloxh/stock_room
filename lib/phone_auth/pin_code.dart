import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:stock_room_app/provider/product.dart';
import 'package:stock_room_app/screens/sign_Up_Set_Password.dart';

import '../constant.dart';

class PinCode extends StatefulWidget {
  final String phoneNumber;
  final charter;
  final verificationId;
  final auth;
  const PinCode({
    Key key,
    this.phoneNumber,
    this.charter,
    this.auth,
    this.verificationId,
  }) : super(key: key);
  @override
  _PinCodeState createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  TextEditingController _pinCodeController = TextEditingController();
  // ignore: close_sinks
  StreamController<ErrorAnimationType> errorController;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  bool hasError = false;
  var onTapRecognizer;

  bool isLoading = false;

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
    super.initState();
  }

  ProductProvider productProvider;
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text(
              "Phone\nVerification",
              style: TextStyle(
                color: KBlackColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "OTP Code",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            _pinCodeWidget(),
          ],
        ),
      ),
    );
  }

  Widget _pinCodeWidget() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        PinCodeTextField(
          appContext: context,
          length: 6,
          cursorColor: KPrimaryColor,
          autoDisposeControllers: false,
          animationDuration: Duration(milliseconds: 300),
          textStyle: TextStyle(fontSize: 20, height: 1.6),
          backgroundColor: KSecondaryColor,
          errorAnimationController: errorController,
          controller: _pinCodeController,
          keyboardType: TextInputType.number,
          onChanged: (value) {
            print(value);
            setState(() {
              currentText = value;
            });
          },
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            // borderRadius: BorderRadius.circular(5),
            fieldHeight: 40,
            fieldWidth: 30,
            inactiveFillColor: KBlackColor,
            inactiveColor: KBlackColor,
            activeFillColor: KBlackColor,
            activeColor: KBlackColor,
            selectedColor: KBlackColor,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            width: MediaQuery.of(context).size.width,
            height: 48,
            child: isLoading == false
                ? MaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    color: KPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: _submitSmsCode,
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: KSecondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                : Center(child: CircularProgressIndicator())),
        SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            "A code has been sent to\n${widget.phoneNumber} via SMS",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: KBlackColor.withOpacity(0.4),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

  void _submitSmsCode() async {
    if (_pinCodeController.text.isNotEmpty) {
      final code = _pinCodeController.text.trim();
      try {
        setState(() {
          isLoading = true;
        });
        var credential = PhoneAuthProvider.credential(
            verificationId: widget.verificationId, smsCode: code);

        UserCredential result =
            await widget.auth.signInWithCredential(credential);

        var user = result.user;

        await productProvider.boolData(
          user: user,
          enumData: widget.charter,
        );
        if (user != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SignUpSetPassword(
                phoneNumber: widget.phoneNumber,
              ),
            ),
          );
        }
        setState(() {
          isLoading = false;
        });
      } catch (er) {
        switch (er.toString()) {
          case '[firebase_auth/invalid-verification-code] The sms verification code used to create the phone auth credential is invalid. Please resend the verification code sms and be sure use the verification code provided by the user.':
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Error"),
                    content: Text("Code Is Not Correct"),
                  );
                });
            break;
        }
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
// phoneNumber: widget.phoneNumber,
