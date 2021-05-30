import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/stripe_payment/stripe_home.dart';

class AddPaymentCard extends StatefulWidget {
  static String id = "AddPaymentCard";

  @override
  _AddPaymentCardState createState() => _AddPaymentCardState();
}

class _AddPaymentCardState extends State<AddPaymentCard> {
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expMonth = TextEditingController();
  TextEditingController expYear = TextEditingController();
  TextEditingController cvc = TextEditingController();

  addPayMentCardData() {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .update({
      'cardNumber': cardNumber.text,
      'expMonth': expMonth.text,
      'expYear': expYear.text,
      'CVC': cvc.text,
    });
  }

  controllerClear() {
    cvc.clear();
    expMonth.clear();
    expYear.clear();
    cardNumber.clear();
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
          "Add Payment Card",
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
              MaterialButton(
                child: Text('Check Stripe Payment '),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => StripeHome(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Enter Card Number",
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
                  textAlignVertical: TextAlignVertical.center,
                  obscureText: true,
                  style: TextStyle(color: KBlackColor),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    hintStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: KBlackColor),
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
                    hintText: "**** **** **** ****",
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Exp.Month",
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
                                controller: expMonth,
                                textAlignVertical: TextAlignVertical.center,
                                obscureText: true,
                                style: TextStyle(color: KPrimaryColor),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: KBlackColor,
                                  ),
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
                                  hintText: "MM",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Exp.Year",
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
                                controller: expYear,
                                textAlignVertical: TextAlignVertical.center,
                                style: TextStyle(
                                  color: KBlackColor,
                                ),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: KBlackColor,
                                  ),
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
                                  hintText: "YY",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(
                      flex: 1,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "CVC",
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
                                controller: cvc,
                                textAlignVertical: TextAlignVertical.center,
                                obscureText: true,
                                style: TextStyle(color: KBlackColor),
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 15),
                                  hintStyle: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: KBlackColor),
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
                                  hintText: "***",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 40),
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
                      addPayMentCardData();
                      controllerClear();
                    },
                    // {
                    //   // Navigator.push(
                    //   //   context,
                    //   //   new MaterialPageRoute(
                    //   //     builder: (context) => SignUpOtpCode(),
                    //   //   ),
                    //   // );
                    // },
                    child: Text(
                      "Add Card",
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
