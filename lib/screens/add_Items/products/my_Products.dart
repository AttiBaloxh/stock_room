import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_room_app/model/product_model.dart';
import 'package:stock_room_app/provider/product.dart';
import 'package:stock_room_app/screens/add_Items/add_Product_New.dart';
import 'package:stock_room_app/screens/map_Screens/welcome.dart';
import 'package:stock_room_app/search/map_search.dart';
import '../../../screens/signle_product/single_product.dart';
import '../../../provider/user_data.dart';
import '../../../model/user_model.dart';

class MyProducts extends StatefulWidget {
  static String id = "MyProducts";

  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  UserModel userModel;

  // ignore: missing_return
  // Stream<void> users() {
  //   var querySnapshot = FirebaseFirestore.instance.collection('Users').get();
  //   querySnapshot.then((value) => {
  //         value.docs.forEach((element) {
  //           setState(() {
  //             userModel = UserModel(
  //               email: element.data()['UserEmail'],
  //               password: element.data()['UserPassword'],
  //               photoUrl: element.data()['UserImage'],
  //               userName: element.data()['UserName'],
  //               userUid: element.data()['UserUid'],
  //               confirmPassword: element.data()['UserConfirmPassword'],
  //             );
  //           });
  //         }),
  //       });
  // }

  // // @override
  // void initState() {
  //   users();
  //   super.initState();
  // }
  ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    productProvider.getSelectUserData();
    UserData userProvider = Provider.of<UserData>(context);

    ////list will full/////
    productProvider.getProductData();
    userProvider.fetchUserList();

    //get list ///////
    List<ProductModel> productModel = productProvider.getProductLists;

    Widget renderProduct(ctx, index) {
      var product = productModel[index];
      if (productProvider.selectUser == 'buyers') {
        return SingleProduct(
          whenPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => Welcome(
                    productImage: product.productImage,
                    productName: product.productName,
                    productOnSell: product.productOnSell,
                    productPTACAccessories: product.productPTACAccessories,
                    productPrice: product.productPrice,
                    productSKU: product.productSKU,
                    userName: product.userName,
                    userId: product.userId,
                    userImage: product.userImage),
              ),
            );
          },
          productImage: productModel[index].productImage,
          productName: productModel[index].productName,
          productOnSell: productModel[index].productOnSell,
          productPTACAccessories: productModel[index].productPTACAccessories,
          productPrice: productModel[index].productPrice,
          productSKU: productModel[index].productSKU,
        );
      } else {
        if (FirebaseAuth.instance.currentUser.uid ==
            productModel[index].userId) {
          return SingleProduct(
            whenPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => Welcome(
                      productImage: product.productImage,
                      productName: product.productName,
                      productOnSell: product.productOnSell,
                      productPTACAccessories: product.productPTACAccessories,
                      productPrice: product.productPrice,
                      productSKU: product.productSKU,
                      userName: product.userName,
                      userId: product.userId,
                      userImage: product.userImage),
                ),
              );
            },
            productImage: productModel[index].productImage,
            productName: productModel[index].productName,
            productOnSell: productModel[index].productOnSell,
            productPTACAccessories: productModel[index].productPTACAccessories,
            productPrice: productModel[index].productPrice,
            productSKU: productModel[index].productSKU,
          );
        }
        return Container();
      }
    }

    return Scaffold(
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
        title: Container(
          child: Image.asset(
            'assets/StockRoom.png',
            height: 15.85,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Center(
              child: Image.asset(
                'assets/search.png',
                height: 24,
              ),
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Search(),
              );
            },
          )
          // Padding(
          //   padding: const EdgeInsets.only(right: 15),
          // child: Center(
          //   child: Image.asset(
          //     'assets/search.png',
          //     height: 24,
          //   ),
          //   ),
          // ),
        ],
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        itemCount: productModel.length,
        itemBuilder: renderProduct,
      ),
    );
  }
}
