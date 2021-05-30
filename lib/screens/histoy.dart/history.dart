import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_room_app/model/product_model.dart';
import 'package:stock_room_app/provider/product.dart';
import 'package:stock_room_app/screens/map_Screens/welcome.dart';
import 'package:stock_room_app/screens/signle_product/single_product.dart';
import 'package:stock_room_app/search/map_search.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  User user;
  getUserId() async {
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    getUserId();
    ProductProvider provider = Provider.of<ProductProvider>(context);

    ////list will full/////
    provider.getProductData();

    //get list ///////
    List<ProductModel> productModel = provider.getProductLists;

    Widget renderProduct(ctx, index) {
      var product = productModel[index];

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
        productImage: product.productImage,
        productName: product.productName,
        productOnSell: product.productOnSell,
        productPTACAccessories: product.productPTACAccessories,
        productPrice: product.productPrice,
        productSKU: product.productSKU,
      );
    }

    return Scaffold(
      appBar: AppBar(
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
        ],
      ),
      body: ListView.builder(
        itemCount: productModel.length,
        itemBuilder: (context, index) {
          if (user.uid == productModel[index].userId) {
            return Container(
              height: 100,
              width: 100,
              child: renderProduct(context, index),
            );
          }
          return Container();
        },
      ),
    );
  }
}
