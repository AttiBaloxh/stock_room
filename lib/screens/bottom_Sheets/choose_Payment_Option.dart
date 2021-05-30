import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/alert_Dialouges/order_Confirmation.dart';

class ChoosePaymentOption extends StatefulWidget {
  static String id = "ChoosePaymentOption";

  @override
  _ChoosePaymentOptionState createState() => _ChoosePaymentOptionState();
}

class _ChoosePaymentOptionState extends State<ChoosePaymentOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 340,
      padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
      decoration: BoxDecoration(
          color: KWhiteColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
          Container(
            padding: EdgeInsets.only(bottom: 30),
            decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                color: KLightBlueColor,
                width: 1,
              )),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "39TA-R030780105",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Belt Tightener",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: KBlackColor,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        "85th Avenue, South Coast",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: KBlackColor,
                      ),
                      children: [
                        TextSpan(
                          text: '\$ ',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: '89',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Select payment",
                  style: TextStyle(
                    fontSize: 16,
                    color: KPrimaryColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 5,
                  child: Container(
                    child: Center(
                      child: ListTile(
                        leading: Image.asset(
                          'assets/ic_mastercard.png',
                          height: 25,
                        ),
                        title: Text(
                          "**** 8295",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff3E4958),
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: Color(0xff97ADB6),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Container(
              height: 46,
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                border: Border.all(
                  color: KPrimaryColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => OrderConfirmation(),
                    );
                  });
                },
                elevation: 0,
                highlightElevation: 0,
                highlightColor: KWhiteColor.withOpacity(0.3),
                splashColor: KLightGreyColor,
                color: KWhiteColor,
                textColor: KPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Pay Now",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: KPrimaryColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
