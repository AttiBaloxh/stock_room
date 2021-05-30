import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'map_Screens/welcome.dart';

class SignUpSetPassword extends StatefulWidget {
  static String id = "SignUpSetPassword";
  final String phoneNumber;
  SignUpSetPassword({this.phoneNumber});
  @override
  _SignUpSetPasswordState createState() => _SignUpSetPasswordState();
}

class _SignUpSetPasswordState extends State<SignUpSetPassword> {
  GlobalKey<ScaffoldState> myKey = GlobalKey<ScaffoldState>();
  bool isLoadding = false;
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  passwordValidation() async {
    if (password.text.isEmpty && confirmPassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Both fields are empty'),
      ));
    } else if (password.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password must be 8'),
      ));
    } else if (password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('password Is Empty'),
      ));
    } else if (confirmPassword.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Confirm password Is Empty'),
      ));
    } else if (password.text != confirmPassword.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password does\'t match'),
      ));
      // myKey.currentState.showSnackBar(
      //   SnackBar(
      //     content: Text("Password does\'t match"),
      //   ),
      // );
    } else {
      await sendData();
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Welcome(),
        ),
      );
    }
  }

  sendData() async {
    setState(() {
      isLoadding = true;
    });
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .set(
      {
        'UserPassword': password.text,
        'UserConfirmPassword': confirmPassword.text,
        'UserPhoneNumber': widget.phoneNumber,
        'UserUid': FirebaseAuth.instance.currentUser.uid
      },
    );
    setState(() {
      isLoadding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: myKey,
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
                "Set your Password",
                maxLines: 1,
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
                "Password",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: password,
                obscureText: true,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: KPrimaryColor,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: KBlackColor),
                decoration: InputDecoration(
                  hintText: "***************",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Confirm password",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: confirmPassword,
                obscureText: true,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: KPrimaryColor,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: KBlackColor),
                decoration: InputDecoration(
                  hintText: "***************",
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.82,
                  height: 48,
                  child:isLoadding==false? MaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    color: KPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: passwordValidation,
                    // () {
                    //   Navigator.push(
                    //     context,
                    //     new MaterialPageRoute(
                    //       builder: (context) => Welcome(),
                    //     ),
                    //   );
                    // },
                    child: Text(
                      "Get started",
                      style: TextStyle(
                        color: KSecondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ):Center(child: CircularProgressIndicator())
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
