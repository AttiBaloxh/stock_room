import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/bottom_Sheets/select_Buyers.dart';
import 'package:stock_room_app/screens/drawer/drawer.dart';
import 'package:stock_room_app/search/map_search.dart';
import 'dart:ui';
import 'package:stock_room_app/screens/signle_product/single_product.dart';

// ignore: must_be_immutable
class LocalParts extends StatefulWidget {
  static String id = "LocalParts";
  final userId;
  final userImage;
  final userName;
  String productImage;
  String productName;
  String productOnSell;
  String productPTACAccessories;
  String productPrice;
  String productSKU;
  LocalParts({
    this.productImage,
    this.productName,
    this.productOnSell,
    this.productPTACAccessories,
    this.productPrice,
    this.productSKU,
    this.userId,
    this.userImage,
    this.userName,
  });
  @override
  _LocalPartsState createState() => _LocalPartsState();
}

class _LocalPartsState extends State<LocalParts> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var otherBuyers = true;
  var myLoc = true;

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
                                    IconButton(
                                      icon: Icon(Icons.search),
                                      onPressed: () {
                                        showSearch(
                                          context: context,
                                          delegate: Search(),
                                        );
                                      },
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
                    Visibility(
                      visible: myLoc,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 30, top: 100),
                          child: Image.asset(
                            'assets/ic_loc.png',
                            height: 56,
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: otherBuyers,
                      child: Positioned(
                        bottom: MediaQuery.of(context).size.height * 0.12,
                        right: MediaQuery.of(context).size.width * 0.2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 237,
                              height: 90,
                              child: widget.productName == null
                                  ? Container()
                                  : SingleProduct(
                                      whenPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          // ignore: non_constant_identifier_names
                                          builder: (Builder) => SelectBuier(
                                            accessories:
                                                widget.productPTACAccessories,
                                            price: widget.productPrice,
                                            productName: widget.productName,
                                            id: widget.userId ?? '',
                                            userImage: widget.userImage,
                                            userName: widget.userName,
                                          ),
                                        );
                                      },
                                      productImage: widget.productImage ?? '',
                                      productName: widget.productName ?? '',
                                      productOnSell: widget.productOnSell ?? '',
                                      productPTACAccessories:
                                          widget.productPTACAccessories ?? '',
                                      productPrice: widget.productPrice ?? '',
                                      productSKU: widget.productSKU ?? '',
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
                    )
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
