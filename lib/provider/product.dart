import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:stock_room_app/model/product_model.dart';

class ProductProvider with ChangeNotifier {
  // List<ProductModel> _productModelList = [];
  ProductModel productModel;

  // Future<void> fetchProductList() async {
  //   List<ProductModel> _newproductModel = [];
  //   QuerySnapshot query =
  //       await FirebaseFirestore.instance.collection("Products").get();
  //   query.docs.forEach((element) {
  //     String productImage = element.data()["productImage"];
  //     String productName = element.data()["productName"];
  //     String productOnSell = element.data()["categoryDespriction"];
  //     String productPTACAccessories = element.data()["productDespriction"];
  //     String productPrice = element.data()["productPrice"];
  //     String productSKU = element.data()["skuNo"];
  //     String userId = element.data()['userId'];

  //     productModel = ProductModel(
  //       userId: userId,
  //       productImage: productImage,
  //       productName: productName,
  //       productOnSell: productOnSell,
  //       productPTACAccessories: productPTACAccessories,
  //       productPrice: productPrice,
  //       productSKU: productSKU,
  //     );
  //     _newproductModel.add(productModel);
  //     notifyListeners();
  //   });
  //   _productModelList = _newproductModel;
  // }
  List<ProductModel> productModelList = [];

  // List<ProductModel> get getProductList => List.from(productModelList);

  // List<ProductModel> search(String query) {
  //   List<ProductModel> searchList = productModelList.where((element) {
  //     return element.productName.toUpperCase().contains(query) ||
  //         element.productName.toLowerCase().contains(query) ||
  //         element.productName.toUpperCase().contains(query) &&
  //             element.productName.toLowerCase().contains(query);
  //   }).toList();
  //   return searchList;
  // }

  // //////////////////end Search //////////
  // ////////////////////   Search   //////////
  // List<ProductModel> searchlist;
  // void getSearchList({List<ProductModel> list}) {
  //   searchlist = list;
  // }

  Future<void> addProduct({
    String productImage,
    String productName,
    String productOnSell,
    String productPTACAccessories,
    String productPrice,
    String productSKU,
  }) async {
    try {
      var user = FirebaseAuth.instance.currentUser;

      var querySnapshot =
          FirebaseFirestore.instance.collection('Products').doc();

      querySnapshot.set(
        {
          'userId': user.uid,
          'productId': querySnapshot.id,
          'productName': productName,
          'productPrice': productPrice,
          'productDescription': productPTACAccessories,
          'skuNo': productSKU,
          'productImage': productImage,
          'categoryDespriction': productOnSell,
          'userName': user.displayName,
          'userImage': user.photoURL,
        },
      );
      notifyListeners();
      return null;
    } catch (error) {
      notifyListeners();
      return error;
    }
  }

  getProductData() async {
    List<ProductModel> newList = [];
    QuerySnapshot productData =
        await FirebaseFirestore.instance.collection('Products').get();
    productData.docs.forEach(
      (categorySnapShot) {
        productModel = ProductModel(
          userImage: categorySnapShot.data()['userImage'],
          userName: categorySnapShot.data()['userName'],
          productId: categorySnapShot.data()['productId'],
          userId: categorySnapShot.data()['userId'],
          productName: categorySnapShot.data()['productName'],
          productPrice: categorySnapShot.data()['productPrice'],
          productImage: categorySnapShot.data()['productImage'],
          productOnSell: categorySnapShot.data()['categoryDespriction'],
          productPTACAccessories: categorySnapShot.data()['productDescription'],
          productSKU: categorySnapShot.data()['skuNo'],
        );
        newList.add(productModel);
      },
    );
    notifyListeners();
    productModelList = newList;
  }

  get getProductLists {
    return productModelList;
  }

  List<ProductModel> productSearch(String query) {
    List<ProductModel> productSearch = productModelList.where(
      (element) {
        return element.productName.toLowerCase().contains(query) ||
            element.productName.toUpperCase().contains(query);
      },
    ).toList();
    return productSearch;
  }

  boolData({var enumData, var user}) async {
    await FirebaseFirestore.instance
        .collection('SelectUser')
        .doc(user.uid)
        .set({
      'selectUser': enumData,
    });
    notifyListeners();
  }

  var selectUser;

  getSelectUserData() {
    FirebaseFirestore.instance
        .collection('SelectUser')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get()
        .then(
          (value) => {
            selectUser = value.data()['selectUser'],
            notifyListeners(),
          },
        );
  }

  get getselectUser {
    return selectUser;
  }
}
