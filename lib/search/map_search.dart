import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_room_app/model/product_model.dart';
import 'package:stock_room_app/provider/product.dart';
import 'package:stock_room_app/screens/signle_product/single_product.dart';

class Search extends SearchDelegate<ProductProvider> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(
          Icons.arrow_back,
        ),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    ProductProvider provider =
        Provider.of<ProductProvider>(context, listen: false);
    List<ProductModel> _searchfoodList = provider.productSearch(query);

    return ListView(
      children: _searchfoodList
          .map<Widget>(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleProduct(
                whenPressed: () {},
                productImage: e.productImage,
                productName: e.productName,
                productOnSell: e.productOnSell,
                productPTACAccessories: e.productPTACAccessories,
                productPrice: e.productPrice,
                productSKU: e.productSKU,
              ),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    ProductProvider provider =
        Provider.of<ProductProvider>(context, listen: false);
    List<ProductModel> _searchfoodList = provider.productSearch(query);
    return ListView(
      children: _searchfoodList
          .map<Widget>(
            (e) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleProduct(
                whenPressed: () {},
                productImage: e.productImage,
                productName: e.productName,
                productOnSell: e.productOnSell,
                productPTACAccessories: e.productPTACAccessories,
                productPrice: e.productPrice,
                productSKU: e.productSKU,
              ),
            ),
          )
          .toList()
    );
  }
}
