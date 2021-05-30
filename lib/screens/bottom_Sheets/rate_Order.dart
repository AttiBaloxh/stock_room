import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/bottom_Sheets/rate_Order_Done.dart';

class RateOrder extends StatefulWidget {
  static String id = "RateOrder";

  @override
  _RateOrderState createState() => _RateOrderState();
}

class _RateOrderState extends State<RateOrder> {
  @override
  Widget build(BuildContext context) {
    myCustomBackButton() {
      setState(() {
      });
    }

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.36,
          padding: EdgeInsets.fromLTRB(25, 0, 25, 20),
          color: KWhiteColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 10, bottom: 20),
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
                padding: EdgeInsets.only(right: 15),
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
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: KPrimaryColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RichText(
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
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: KPrimaryColor.withOpacity(0.1)),
                            child: Center(
                              child: Text(
                                "Paid",
                                style: TextStyle(
                                  color: KPrimaryColor,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w500,
                                ),
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
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 56,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: MaterialButton(
                      elevation: 0,
                      highlightElevation: 0,
                      color: KPrimaryColor,
                      textColor: Color(0xfffafafa),
                      onPressed: () {
                        setState(() {
                          myCustomBackButton();
                          showModalBottomSheet(
                            enableDrag: true,
                            context: context,
                            // ignore: non_constant_identifier_names
                            builder: (Builder) =>
                                RateOrderDone(),
                          );
                        });
                      },
                      child: Text(
                        "Rate Order",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    height: 55,
                    decoration:
                        BoxDecoration(border: Border.all(color: KBlackColor)),
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: MaterialButton(
                      elevation: 0,
                      highlightElevation: 0,
                      color: Color(0xffffffff),
                      textColor: KBlackColor,
                      splashColor: Color(0xfffafafa),
                      highlightColor: Colors.white,
                      onPressed: () {
                      Navigator.pop(context);
                      },
                      child: Text(
                        "Exit",
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 18),
                      ),
                    ),
                  ),
                ],
              )
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
