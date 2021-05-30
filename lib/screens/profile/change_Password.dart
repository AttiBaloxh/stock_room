import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import '../../model/user_model.dart';

class ChangePassword extends StatefulWidget {
  static String id = "ChangePassword";

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  UserModel userModel = UserModel();

  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();

  User currentUser = FirebaseAuth.instance.currentUser;
  Future<void> users() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('Users').get();
    querySnapshot.docs.forEach((element) {
      setState(() {
        userModel = UserModel(
          email: element.data()['email'],
          password: element.data()['UserPassword'],
          photoUrl: element.data()['email'],
          userName: element.data()['email'],
          userUid: element.data()['email'],
          confirmPassword: element.data()['UserConfirmPassword'],
        );
      });
    });
  }

  var changePassword;

  updateUserProfile(password) async {
    await currentUser
        .updatePassword(password)
        .then((value) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Changed Your Password'),
            )));
  }

  @override
  void initState() {
    users();
    super.initState();
  }

  passwordValidation() async {
    if (password.text.isEmpty && confirmPassword.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).errorColor,
            content: Text(
              "fields are empty",
            ),
          );
        },
      );
    } else if (password.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).errorColor,
            content: Text(
              "password is empty",
            ),
          );
        },
      );
    } else if (password.text.length < 8) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).errorColor,
            content: Text(
              "password must be 8",
            ),
          );
        },
      );
    } else if (confirmPassword.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).errorColor,
            content: Text(
              "confirmPassword is empty",
            ),
          );
        },
      );
    } else if (password.text != confirmPassword.text) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Theme.of(context).errorColor,
            content: Text(
              "Password not match",
            ),
          );
        },
      );
    } else
      updateUserProfile(changePassword);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
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
          "Change Password",
          style: TextStyle(
            fontSize: 16,
            color: KWhiteColor,
            fontWeight: FontWeight.w400,
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
                height: 30,
              ),
              Text(
                "Enter New Password",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: KWhiteColor,
                child: TextField(
                  controller: password,
                  onChanged: (changePasswords) {
                    changePassword = changePasswords;
                  },
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: true,
                  style: TextStyle(color: KPrimaryColor),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.withOpacity(0.7)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: KPrimaryColor.withOpacity(0.5),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: KPrimaryColor.withOpacity(0.5),
                      ),
                    ),
                    hintText: "************",
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Confirm New Password",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: KWhiteColor,
                child: TextField(
                  controller: confirmPassword,
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: true,
                  style: TextStyle(color: KPrimaryColor),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.withOpacity(0.7)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: KPrimaryColor.withOpacity(0.5),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: KPrimaryColor.withOpacity(0.5),
                      ),
                    ),
                    hintText: "************",
                  ),
                ),
              ),
              SizedBox(
                height: 40,
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
                      passwordValidation();
                      // updateUserProfile(password);

                      // Navigator.push(
                      //   context,
                      //   new MaterialPageRoute(
                      //     builder: (context) => SignUpOtpCode(),
                      //   ),
                      // );
                    },
                    child: Text(
                      "Save Changes",
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
