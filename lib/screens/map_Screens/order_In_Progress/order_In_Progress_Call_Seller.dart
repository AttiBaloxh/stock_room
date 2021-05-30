import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/bottom_Sheets/order_In_Progress_Call_Seller_BSheet.dart';
import 'package:stock_room_app/screens/drawer/drawer.dart';
import 'dart:ui';

class OrderInProgressCallSeller extends StatefulWidget {
  static String id = "OrderInProgressCallSeller";

  @override
  _OrderInProgressCallSellerState createState() => _OrderInProgressCallSellerState();
}

class _OrderInProgressCallSellerState extends State<OrderInProgressCallSeller> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var otherBuyers = true;
  var myLoc = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      drawer: MyDrawer(),
      body: SafeArea(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/O_map.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        leading: IconButton(
                          onPressed: () {
                            scaffoldKey.currentState.openDrawer();
                          },
                          icon: Image.asset(
                            'assets/Group 77.2.png',
                            height: 18,
                          ),
                        ),
                        title: Card(
                          elevation: 5,
                          child: Container(
                            height: 48,
                            child: TextField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      'assets/ic_search.png',
                                      height: 30,
                                    )
                                  ],
                                ),
                                hintText: "Belt Tightener",
                                hintStyle: TextStyle(
                                  color: KBlackColor.withOpacity(0.4),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.23,
                      right: MediaQuery.of(context).size.width * 0.14,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            // ignore: non_constant_identifier_names
                            builder: (Builder) => OrderInProgressCallSellerBSheet(),
                          );
                        },
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 237,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: KWhiteColor,
                                ),
                                height: 59,
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                            KPrimaryColor.withOpacity(0.6),
                                            BlendMode.multiply),
                                        child: Container(
                                          height: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(5),
                                              bottomLeft: Radius.circular(5),
                                            ),
                                            color: Colors.grey,
                                          ),
                                          child: Center(
                                            child: Image.asset(
                                              'assets/image_8.png',
                                              height: 47,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: Container(
                                        margin: EdgeInsets.only(left: 15),
                                        height: double.infinity,
                                        child: Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            //Seller Name
                                            Container(
                                              child: Flexible(
                                                child: Text(
                                                  "Belt Tightener\nAssembly",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    color: KBlackColor,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            //
                                            Container(
                                              height: 10,
                                              width: 50,
                                              margin: EdgeInsets.only(top: 7),
                                              child: MaterialButton(
                                                padding: EdgeInsets.zero,
                                                visualDensity: VisualDensity
                                                    .adaptivePlatformDensity,
                                                onPressed: () {},
                                                elevation: 0,
                                                highlightElevation: 0,
                                                color: Color(0xffBAC8F4),
                                                child: Text(
                                                  "3km Away",
                                                  style: TextStyle(
                                                    fontSize: 6,
                                                    color: KPrimaryColor,
                                                  ),
                                                  maxLines: 1,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Container(
                                        height: double.infinity,
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              child: RichText(
                                                text: TextSpan(
                                                  style: TextStyle(
                                                    fontFamily: "Montserrat",
                                                    color: KBlackColor,
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: '\$',
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: '89',
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                        FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
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
                              Column(
                                children: [
                                  Container(
                                    height: 14,
                                    width: 2,
                                    color: KPrimaryColor,
                                  ),
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: KPrimaryColor,
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        'assets/location.png',
                                        height: 15,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
      ),
    );
  }
}
