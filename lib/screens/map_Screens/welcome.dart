import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/provider/product.dart';
import 'package:stock_room_app/screens/alert_Dialouges/locating_Nearest_Seller.dart';
import 'package:stock_room_app/screens/bottom_Sheets/scan_Image_Search_Image.dart';
import 'package:stock_room_app/screens/drawer/drawer.dart';
import 'dart:ui';

// ignore: must_be_immutable
class Welcome extends StatefulWidget {
  static String id = "Welcome";
  var userName;
  var userId;
  var userImage;
  String productImage;
  String productName;
  String productOnSell;
  String productPTACAccessories;
  String productPrice;
  String productSKU;
  Welcome({
    this.productPrice,
    this.productSKU,
    this.productName,
    this.productImage,
    this.productOnSell,
    this.productPTACAccessories,
    this.userName,
    this.userImage,
    this.userId,
  });
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final auth = FirebaseAuth.instance;


  var scaffoldKey = GlobalKey<ScaffoldState>();

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
        ),
      );
    });
  }


  ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getSelectUserData();

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
                    GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: _initialcameraposition),
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      myLocationEnabled: true,
                    ),
                    Container(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(horizontal: 5),
                        leading: Builder(
                          builder: (ctx) {
                            return IconButton(
                              onPressed: () {
                                Scaffold.of(ctx).openDrawer();
                              },
                              icon: Image.asset(
                                'assets/Group 77.2.png',
                                height: 18,
                              ),
                            );
                          },
                        ),
                        title: Card(
                          elevation: 5,
                          child: Container(
                            height: 48,
                            child: TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                prefixIcon: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.search),
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
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            productProvider.getselectUser == 'buyers'
                                ?
                                //  ElevatedButton.icon(onPressed: onPressed, icon: icon, label: label)
                                Container(
                                    height: 56,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: MaterialButton(
                                      elevation: 5,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      color: KPrimaryColor,
                                      textColor: Color(0xfffafafa),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              LocationNearestSeller(
                                            productImage: widget.productImage,
                                            productName: widget.productName,
                                            productOnSell: widget.productOnSell,
                                            productPTACAccessories:
                                                widget.productPTACAccessories,
                                            productPrice: widget.productPrice,
                                            productSKU: widget.productSKU,
                                            userId: widget.userId,
                                            userImage: widget.userImage,
                                            userName: widget.userName,
                                          ),
                                        );
                                      },
                                      child: Text(
                                        "Buy",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 56,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      elevation: 5,
                                      color: Color(0xffffffff),
                                      textColor: KPrimaryColor,
                                      splashColor: Color(0xfffafafa),
                                      highlightColor: Colors.white,
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          // ignore: non_constant_identifier_names
                                          builder: (Builder) =>
                                              ScanImageSearchImage(),
                                        );
                                      },
                                      child: Text(
                                        "Sell",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400),
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
            ],
          ),
        ),
      ),
    );
  }
}
