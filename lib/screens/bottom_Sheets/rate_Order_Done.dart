import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';

class RateOrderDone extends StatefulWidget {
  static String id = "RateOrderDone";

  @override
  _RateOrderDoneState createState() => _RateOrderDoneState();
}

class _RateOrderDoneState extends State<RateOrderDone> {
  TextEditingController comment = TextEditingController();
  var buttonColor = KPrimaryColor;
  var buttonTextColor = KSecondaryColor;
  var buttonBorderColor = KPrimaryColor;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.45,
          // height: 344,
          padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
          color: KWhiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  width: 30,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(10),
                    ),
                    color: Color(0xffD5DDE0),
                  ),
                ),
              ),
              Text(
                "HOW DO YOU RATE THE ORDER.".toUpperCase(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star,color: Color(0xffF8B500),),
                    Icon(Icons.star,color: Color(0xffF8B500),),
                    Icon(Icons.star,color: Color(0xffF8B500),),
                    Icon(Icons.star,color: Color(0xffF8B500),),
                    Icon(Icons.star,color: Color(0xffD5DDE0)),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xffF7F8F9),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color(0xffD5DDE0),
                  ),
                ),
                child: TextField(
                  onChanged: (value) {
                    setState(
                          () {
                        if (comment.text.isNotEmpty) {
                          buttonColor = KPrimaryColor;
                          buttonTextColor = KSecondaryColor;
                        } else {
                          buttonColor = KSecondaryColor;
                          buttonTextColor = KPrimaryColor;
                        }
                      },
                    );
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: 15,
                    color: KBlackColor,
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Message",
                    hintStyle: TextStyle(
                      color: Color(0xffBDBDBD),
                    ),
                  ),
                ),
              ),
              Container(
                height: 47,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: buttonBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                width: MediaQuery.of(context).size.width * 0.3,
                child: MaterialButton(
                  elevation: 0,
                  highlightElevation: 0,
                  color: buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  textColor: buttonTextColor,
                  splashColor: Color(0xfffafafa),
                  highlightColor: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Rate Order",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: -30,
          right: 10,
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/jurica-koletic-317414-unsplash.png',
                height: 60,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
