import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/bottom_Sheets/rate_Order.dart';
import 'package:stock_room_app/screens/chat/chat_Screen.dart';

class OrderInProgressCallSellerBSheet extends StatefulWidget {
  static String id = "OrderInProgressCallSellerBSheet";

  @override
  _OrderInProgressCallSellerBSheetState createState() =>
      _OrderInProgressCallSellerBSheetState();
}

class _OrderInProgressCallSellerBSheetState extends State<OrderInProgressCallSellerBSheet> {
  @override
  Widget build(BuildContext context) {
    myCustomBackButton() {
      setState(() {
      });
    }

    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
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
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        myCustomBackButton();
                        showModalBottomSheet(
                          context: context,
                          // ignore: non_constant_identifier_names
                          builder: (Builder) => RateOrder(),
                        );
                      });
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Card(
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            margin: EdgeInsets.zero,
                            child: Container(
                              width: 65,
                              height: 65,
                              child: Center(
                                child: Image.asset(
                                  'assets/Vector.png',
                                  height: 22.30,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            child: Text(
                              "Order Part",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w400,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => ChatScreen(),
                          ),
                        );
                      });
                    },
                    child: Container(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Card(
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100)),
                                margin: EdgeInsets.zero,
                                child: Container(
                                  padding: EdgeInsets.only(top: 7, right: 1),
                                  width: 65,
                                  height: 65,
                                  child: Center(
                                    child: Image.asset(
                                      'assets/ic_chat-removebg-preview.png',
                                      height: 60,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: -5,
                                top: -2,
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  decoration: BoxDecoration(
                                    color: KPrimaryColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "2",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: KWhiteColor,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            child: Text(
                              "Chat Seller",
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      myCustomBackButton();
                    },
                    child: Column(
                      children: [
                        Card(
                          elevation: 8,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          margin: EdgeInsets.zero,
                          child: Container(
                            width: 65,
                            height: 65,
                            child: Center(
                              child: Icon(
                                Icons.close,
                                size: 30,
                                color: Color(0xff3E4958),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        FittedBox(
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
