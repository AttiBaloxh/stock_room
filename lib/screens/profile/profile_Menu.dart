import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/profile/add_Payment_Card.dart';
import 'package:stock_room_app/screens/profile/change_Password.dart';
import 'package:stock_room_app/screens/profile/edit_Profile.dart';
import 'package:stock_room_app/screens/profile/term_And_Conditions.dart';
import 'package:stock_room_app/screens/sign_In.dart';
import '../../model/user_model.dart';

// final GoogleSignIn googleSignIn = GoogleSignIn();

class ProfileMenu extends StatefulWidget {
  static String id = "ProfileMenu";

  @override
  _ProfileMenuState createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  File image;
  var _auth = FirebaseAuth.instance;
  var fb = FacebookLogin();
  var google = GoogleSignIn();

  User currentUser = FirebaseAuth.instance.currentUser;
  String userImage;
  fetchUserDetial() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser.uid)
        .get()
        .then(
          (value) => {
            setState(
              () {
                userImage = value.data()['UserImage'];
              },
            ),
          },
        );
  }

  UserModel userModel;

  // Future<void> _signOut() async {
  //   await googleSignIn.signOut().then((value) async {
  //     print(
  //         '------------------------------- $value ----------------------------');
  //     await Navigator.of(context).push(
  //       MaterialPageRoute(
  //         builder: (context) => SignIn(),
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    fetchUserDetial();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
          "Profile",
          style: TextStyle(
            fontSize: 16,
            color: KWhiteColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(0, 200),
          child: Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // width: 124,
                  // height: 124,
                  // decoration: BoxDecoration(
                  //   color: Colors.blueGrey.withOpacity(0.6),
                  //   shape: BoxShape.circle,
                  // ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, left: 0),
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: currentUser.photoURL != null
                                  ? Image.network(
                                      userImage == null
                                          ? currentUser.photoURL
                                          : userImage,
                                      fit: BoxFit.cover,
                                    )
                                  : Center(
                                      child: Text('Add Image'),
                                    )),
                        ),
                      ),
                      Positioned(
                        bottom: 3,
                        right: 7,
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 23,
                            width: 23,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: KWhiteColor,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/Group 302.png',
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  currentUser.displayName ?? 'Add name',
                  style: TextStyle(
                    fontSize: 16,
                    color: KWhiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  currentUser.email ?? 'User@gmail.com',
                  style: TextStyle(
                    fontSize: 14,
                    color: KWhiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: KWhiteColor,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) =>
                                  EditProfile(userImage: userImage),
                            ),
                          );
                        },
                        title: Text(
                          "Edit Profile",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => AddPaymentCard(),
                            ),
                          );
                        },
                        title: Text(
                          "Add Payment Card",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => ChangePassword(),
                            ),
                          );
                        },
                        title: Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        // onTap: () {
                        //   Navigator.push(
                        //     context,
                        //     new MaterialPageRoute(
                        //       builder: (context) => ChangePassword(),
                        //     ),
                        //   );
                        // },
                        title: Text(
                          "Notification",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                              builder: (context) => TermsAndConditions(),
                            ),
                          );
                        },
                        title: Text(
                          "Terms & Conditions",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        title: Text(
                          "FAQ",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                      Container(
                        color: Color(0xffD5DDE0),
                        height: 1,
                        margin: EdgeInsets.symmetric(horizontal: 15),
                      ),
                      ListTile(
                        title: Text(
                          "About App",
                          style: TextStyle(
                            fontSize: 14,
                            color: KBlackColor.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios_sharp,
                          size: 18,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  gooleSignout().then(
                    (value) => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => SignIn(),
                      ),
                    ),
                  );
                  // await _signOut();
                },
                child: Container(
                  padding: EdgeInsets.only(left: 10, top: 30),
                  child: Text(
                    "Sign Out",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.grey.withOpacity(0.6),
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

  Future<void> gooleSignout() async {
    await _auth.signOut().then((onValue) {
      setState(() {
        fb.logOut();
        google.signOut();
      });
    });
  }
}
