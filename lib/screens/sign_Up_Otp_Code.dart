import 'dart:async';
 
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/sign_Up_Set_Password.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignUpOtpCode extends StatefulWidget {
  static String id = "SignUpOtpCode";

  @override
  _SignUpOtpCodeState createState() => _SignUpOtpCodeState();
}

class _SignUpOtpCodeState extends State<SignUpOtpCode> {
  @override
  Widget build(BuildContext context) {
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
              PinCodeVerificationScreen("+8801376221100"),
            ],
          ),
        ),
      ),
    );
  }
}

class PinCodeVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  PinCodeVerificationScreen(this.phoneNumber);

  @override
  _PinCodeVerificationScreenState createState() =>
      _PinCodeVerificationScreenState();
}

class _PinCodeVerificationScreenState extends State<PinCodeVerificationScreen> {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();

  // ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  // @override
  // void dispose() {
  //   errorController.close();
  //
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            // Container(
            //   height: MediaQuery.of(context).size.height / 3,
            //   child: FlareActor(
            //     "assets/Group 295.png",
            //     animation: "otp",
            //     fit: BoxFit.fitHeight,
            //     alignment: Alignment.center,
            //   ),
            // ),
            SizedBox(height: 8),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 8.0),
            //   child: Text(
            //     'Phone Number Verification',
            //     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
            // Padding(
            //   padding:
            //   const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
            //   child: RichText(
            //     text: TextSpan(
            //         text: "Enter the code sent to ",
            //         children: [
            //           TextSpan(
            //               text: widget.phoneNumber,
            //               style: TextStyle(
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.bold,
            //                   fontSize: 15)),
            //         ],
            //         style: TextStyle(color: Colors.black54, fontSize: 15)),
            //     textAlign: TextAlign.center,
            //   ),
            // ),
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
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(right: 110),
              child: Form(
                key: formKey,
                child: PinCodeTextField(
                  autoDisposeControllers: false,
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: KBlackColor,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  obscureText: false,
                  obscuringCharacter: '*',
                  animationType: AnimationType.fade,
                  // validator: (v) {
                  //   if (v.length < 3) {
                  //     return "I'm from validator";
                  //   } else {
                  //     return null;
                  //   }
                  // },
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
                  cursorColor: KPrimaryColor,
                  animationDuration: Duration(milliseconds: 300),
                  textStyle: TextStyle(fontSize: 20, height: 1.6),
                  backgroundColor: KSecondaryColor,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  onTap: () {
                    print("Pressed");
                  },
                  onChanged: (value) {
                    print(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    print("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
            //   child: Text(
            //     hasError ? "*Please fill up all the cells properly" : "",
            //     style: TextStyle(
            //         color: Colors.red,
            //         fontSize: 12,
            //         fontWeight: FontWeight.w400),
            //   ),
            // ),
            SizedBox(
              height: 20,
            ),
            // RichText(
            //   textAlign: TextAlign.center,
            //   text: TextSpan(
            //     text: "Didn't receive the code? ",
            //     style: TextStyle(color: Colors.black54, fontSize: 15),
            //     children: [
            //       TextSpan(
            //           text: " RESEND",
            //           recognizer: onTapRecognizer,
            //           style: TextStyle(
            //               color: Color(0xFF91D3B3),
            //               fontWeight: FontWeight.bold,
            //               fontSize: 16))
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 14,
            // ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 48,
              child: MaterialButton(
                elevation: 0,
                highlightElevation: 0,
                color: KPrimaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onPressed: () {
                  formKey.currentState.validate();
                  // conditions for validating
                  if (currentText.length != 4) {
                    errorController.add(ErrorAnimationType
                        .shake); // Triggering error shake animation
                    setState(() {
                      hasError = true;
                    });
                  } else {
                    // // setState(() {
                    // //   hasError = false;
                    // //   scaffoldKey.currentState.showSnackBar(SnackBar(
                    // //     content: Text("Aye!!"),
                    // //     duration: Duration(seconds: 2),
                    // //   ));
                    // });
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => SignUpSetPassword(),
                      ),
                    );
                  }
                },
                child: Text(
                  "Log in",
                  style: TextStyle(
                    color: KSecondaryColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Center(
              child: Text(
                "A code has been sent to\n+1 234 556 7888 via SMS",
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: KBlackColor.withOpacity(0.4),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     FlatButton(
            //       child: Text("Clear"),
            //       onPressed: () {
            //         textEditingController.clear();
            //       },
            //     ),
            //     FlatButton(
            //       child: Text("Set Text"),
            //       onPressed: () {
            //         textEditingController.text = "123456";
            //       },
            //     ),
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
