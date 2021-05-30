import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/map_Screens/order_In_Progress/order_In_Progress_Call_Seller.dart';

class OrderConfirmation extends StatefulWidget {
  static String id = "OrderConfirmation";

  @override
  _OrderConfirmationState createState() => _OrderConfirmationState();
}

class _OrderConfirmationState extends State<OrderConfirmation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/rec.png'), fit: BoxFit.fill),
            ),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.04,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 92,
                        height: 92,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: KLightGreyColor,
                            border: Border.all(
                              color: KPrimaryColor.withOpacity(0.1),
                            )),
                        child: Center(
                          child: Image.asset(
                            'assets/shape.png',
                            height: 21.33,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 13,
                      ),
                      Text(
                        "Your order has been\nconfirmed",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: KBlackColor,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                          fontFamily: "Montserrat",
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Container(
                  height: 146,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: KLightBlueColor,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "11:24",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff97ADB6),
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                  Text(
                                    "11:38",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xff97ADB6),
                                      fontWeight: FontWeight.w400,
                                      decoration: TextDecoration.none,
                                      fontFamily: "Montserrat",
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Image.asset(
                                'assets/ic_route.png',
                                height: 88,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: RichText(
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: KPrimaryColor,
                                      fontFamily: "Montserrat",
                                      fontWeight: FontWeight.w400,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Belt Tightener Assembly\n",
                                      ),
                                      TextSpan(
                                        text: "12W, Manton Str, SF",
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ]),
                              ),
                            ),
                            Container(
                              child: Text(
                                "My Address",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: KPrimaryColor,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xffF7F8F9),
                      borderRadius: BorderRadius.circular(15),
                    ),
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
                        trailing: RichText(
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                            style: TextStyle(
                              letterSpacing: 1.0,
                              fontSize: 15,
                              color: KPrimaryColor,
                              fontFamily: "Montserrat",
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.none,
                            ),
                            children: [
                              TextSpan(
                                text: "\$",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: "7",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: "63",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  child: Column(
                    children: [
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Text(
                          "Delivered to You",
                          style: TextStyle(
                            color: KPrimaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        "(Delivery Fee Cost Extra \$12)",
                        style: TextStyle(
                          color: KPrimaryColor.withOpacity(0.4),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                          fontFamily: "Montserrat",
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: Container(
              height: 46,
              width: MediaQuery.of(context).size.width * 0.75,
              decoration: BoxDecoration(
                border: Border.all(
                  color: KWhiteColor,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    new MaterialPageRoute(
                      builder: (context) => OrderInProgressCallSeller(),
                    ),
                  );
                },
                elevation: 0,
                highlightElevation: 0,
                highlightColor: KWhiteColor.withOpacity(0.3),
                splashColor: KBlackColor.withOpacity(0.2),
                color: Colors.transparent,
                textColor: KWhiteColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "Pay Now",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
