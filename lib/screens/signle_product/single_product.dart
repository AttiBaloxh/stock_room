import 'package:flutter/material.dart';
import '../../constant.dart';

class SingleProduct extends StatelessWidget {
  final String productImage;
  final String productName;
  final String productPTACAccessories;
  final String productPrice;
  final String productOnSell;
  final String productSKU;
  final Function whenPressed;
  // String productImage;
  // String productImage;
  // String productImage;
  SingleProduct({
    this.productImage,
    this.productName,
    this.productOnSell,
    this.productPTACAccessories,
    this.productPrice,
    this.productSKU,
    @required this.whenPressed,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: whenPressed,
      child: Container(
        margin: EdgeInsets.only(top: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: KWhiteColor,
        ),
        height: 85,
        child: Row(
          children: [
            Expanded(
              flex: 2,
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
                  child: Image.network(
                    productImage ?? '',
                    height: 60,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Container(
                margin: EdgeInsets.only(left: 15),
                height: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //SKu
                    Container(
                      child: Text(
                        productSKU,
                        style: TextStyle(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    //Product Name
                    Container(
                      margin: EdgeInsets.only(top: 2),
                      child: Text(
                        productName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: KPrimaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    //
                    Container(
                      height: 20,
                      margin: EdgeInsets.only(top: 10),
                      child: MaterialButton(
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.adaptivePlatformDensity,
                        onPressed: () {},
                        elevation: 0,
                        color: Color(0xffBAC8F4),
                        child: Text(
                          productPTACAccessories,
                          style: TextStyle(
                            fontSize: 8,
                            color: KPrimaryColor,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        productPrice,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 18,
                      width: 48,
                      child: MaterialButton(
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        color: KPrimaryColor,
                        child: Text(
                          productOnSell,
                          style: TextStyle(
                            fontSize: 8,
                            color: KWhiteColor,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
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
    );
  }
}
