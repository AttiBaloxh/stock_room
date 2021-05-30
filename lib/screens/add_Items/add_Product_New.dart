import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/provider/product.dart';
import 'package:stock_room_app/screens/add_Items/products/my_Products.dart';

User currentUser = FirebaseAuth.instance.currentUser;
CollectionReference productRef =
    FirebaseFirestore.instance.collection('Products');
List catItems = [
  "Category Despriction",
  "Room Air Unit Accessorie",
  "39 Series Accessories",
  "30G Accessories",
  "Electronic Air Cleaners",
];

List filItems = [
  "FILTER KIT",
];

var selectedItem = 0;
var selectedFilter = 0;

class AddProductNew extends StatefulWidget {
  static String id = "AddProductNew";

  @override
  _AddProductNewState createState() => _AddProductNewState();
}

class _AddProductNewState extends State<AddProductNew> {
  var imageUrl;

  File image;
  final picker = ImagePicker();
  TextEditingController productName = TextEditingController();
  TextEditingController productFilter = TextEditingController();
  TextEditingController productSKuNo = TextEditingController();
  TextEditingController productCategoryDescripation = TextEditingController();
  TextEditingController productDescripation = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  cleanController() {
    productName.clear();
    productFilter.clear();
    productSKuNo.clear();
    productCategoryDescripation.clear();
    productDescripation.clear();
    productPrice.clear();
  }

  ProductProvider productProvider;

  Widget button = Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: KPrimaryColor.withOpacity(0.5),
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    padding: EdgeInsets.only(left: 15, right: 15),
    height: 48,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Text(
            catItems[selectedItem].toString(),
            style: TextStyle(color: Colors.grey, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 12,
          height: 17,
          child: RotatedBox(
            quarterTurns: 3,
            child: Icon(
              Icons.arrow_back_ios,
              color: KBlackColor,
              size: 18,
            ),
          ),
        ),
      ],
    ),
  );
  final Widget filButton = Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: KPrimaryColor.withOpacity(0.5),
      ),
      borderRadius: BorderRadius.circular(5),
    ),
    padding: EdgeInsets.only(left: 15, right: 15),
    height: 48,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Text(
            filItems[selectedFilter].toString(),
            style: TextStyle(color: Colors.grey, fontSize: 12),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        SizedBox(
          width: 12,
          height: 17,
          child: RotatedBox(
            quarterTurns: 3,
            child: Icon(
              Icons.arrow_back_ios,
              color: KBlackColor,
              size: 18,
            ),
          ),
        ),
      ],
    ),
  );
  addProduct({TextEditingController controller, String label}) {
    return Container(
      color: KWhiteColor,
      child: TextField(
        controller: controller,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(color: KPrimaryColor),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 15),
          hintStyle: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Colors.grey.withOpacity(0.7)),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: KPrimaryColor.withOpacity(0.5),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: KPrimaryColor.withOpacity(0.5),
            ),
          ),
          hintText: label,
        ),
      ),
    );
  }

  Future uploadFile(
    var file,
  ) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var reference = FirebaseStorage.instance.ref().child(fileName);
    var uploadTask = reference.putFile(file);
    var storageTaskSnapshot = await uploadTask;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      setState(() {
        imageUrl = downloadUrl;
      });
    }, onError: (err) {
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  void _askCameraPermission() async {
    if (await Permission.camera.request().isGranted) {}
  }
  

  Future getImage({ImageSource imageSource}) async {
    final pickedFile = await ImagePicker().getImage(
      source: imageSource,
      maxHeight: 450,
      maxWidth: 450,
    );

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    uploadFile(image);
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Gallery"),
      onPressed: () async {
        await getImage(imageSource: ImageSource.gallery);
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Camera"),
      onPressed: () async {
        await getImage(imageSource: ImageSource.camera);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text(
          "Add Product Image"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  validation() async {
    if (productName.text.isEmpty &&
        productFilter.text.isEmpty &&
        productSKuNo.text.isEmpty &&
        productCategoryDescripation.text.isEmpty &&
        productDescripation.text.isEmpty &&
        productPrice.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('All fields are empty'),
      ));
    } else if (productName.text.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product Name  must be 4'),
        ),
      );
    } else if (productName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Product Name Is Empty'),
      ));
    } else if (productFilter.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('product filter Is Empty'),
      ));
    } else if (productSKuNo.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Password does\'t match'),
      ));
    } else if (productDescripation.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('product Descripation Is empty'),
      ));
    } else if (productPrice.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Product Price Is empty'),
      ));
    } else {
      productProvider
          .addProduct(
              productImage: imageUrl,
              productName: productName.text,
              productOnSell: productSKuNo.text,
              productPTACAccessories: productCategoryDescripation.text,
              productPrice: productPrice.text,
              productSKU: productSKuNo.text)
          .then((value) => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MyProducts())));
    }
  }
@override
  void initState() {
    _askCameraPermission();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: KSecondaryColor,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/Rectangle 11.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: KPrimaryColor.withOpacity(0.85),
                  ),
                ),
              ),
              // ElevatedButton.
            ],
          ),
        ),
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
        title: Text(
          "Add Product",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w600, color: KWhiteColor),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  showAlertDialog(context);
                },
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: image == null
                        ? Image.asset(
                            'assets/Rectangle 1209.png',
                            height: 146,
                          )
                        : Image.file(image),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Product Name",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              addProduct(controller: productName, label: 'ProductName'),
              SizedBox(
                height: 30,
              ),
              Text(
                "Product Filter",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              addProduct(controller: productFilter, label: 'Product Filter'),
              // Container(
              //   child: MenuButton(
              //     child: filButton,
              //     items: filItems,
              //     // Widget displayed as the button
              //     selectedItem: (value) {
              //       selectedFilter = value;
              //     },
              //     onItemSelected: (value) {
              //       setState(
              //         () {
              //           selectedFilter = value;
              //         },
              //       );
              //       // Action when new item is selected
              //     },

              //     // scrollPhysics: AlwaysScrollableScrollPhysics(),
              //     // Change the physics of opened menu (example: you can remove or add scroll to menu)
              //     itemBuilder: (value) => Container(
              //       height: 40,
              //       alignment: Alignment.centerLeft,
              //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //       child: Text(
              //         value,
              //         style: TextStyle(fontSize: 12, color: KPrimaryColor),
              //       ),
              //     ),
              //     toggledChild: Container(
              //       color: KPrimaryColor.withOpacity(0.4),
              //       child: filButton,
              //     ),
              //     divider: Container(
              //       height: 1,
              //     ),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(4),
              //         topRight: Radius.circular(4),
              //       ),
              //       color: KWhiteColor,
              //     ),

              //     // onMenuButtonToggle: (isToggle) {
              //     //   print(isToggle);
              //     //     selectedItem = isToggle;
              //     // },
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              Text(
                "SKU No",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              addProduct(controller: productSKuNo, label: 'SKU No'),
              SizedBox(
                height: 30,
              ),
              Text(
                "Category Despriction",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              addProduct(
                  controller: productCategoryDescripation,
                  label: 'CategoryDespriction'),
              //// Here We Just use for checking the data will send the firebase .. or not

              // Container(
              //   child: MenuButton(
              //     child: button,
              //     items: catItems,
              //     // Widget displayed as the button
              //     selectedItem: (value) {
              //       selectedItem = value;
              //     },
              //     onItemSelected: (value) {
              //       setState(
              //         () {
              //           selectedItem = value;
              //         },
              //       );
              //       // Action when new item is selected
              //     },

              //     // scrollPhysics: AlwaysScrollableScrollPhysics(),
              //     // Change the physics of opened menu (example: you can remove or add scroll to menu)
              //     itemBuilder: (value) => Container(
              //       height: 40,
              //       alignment: Alignment.centerLeft,
              //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              //       child: Text(
              //         value,
              //         style: TextStyle(fontSize: 12, color: KPrimaryColor),
              //       ),
              //     ),
              //     toggledChild: Container(
              //       color: KPrimaryColor.withOpacity(0.4),
              //       child: button,
              //     ),
              //     divider: Container(
              //       height: 1,
              //     ),
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(4),
              //           topRight: Radius.circular(4),
              //         ),
              //         color: KWhiteColor),

              //     // onMenuButtonToggle: (isToggle) {
              //     //   print(isToggle);
              //     //     selectedItem = isToggle;
              //     // },
              //   ),
              // ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Product Description",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              addProduct(
                  controller: productDescripation,
                  label: 'Product Description'),
              SizedBox(
                height: 30,
              ),
              Text(
                "Price",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              addProduct(controller: productPrice, label: 'price'),
              //Button
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 60),
                  width: MediaQuery.of(context).size.width * 0.82,
                  height: 48,
                  child: MaterialButton(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    color: KPrimaryColor,
                    textColor: KWhiteColor,
                    onPressed: validation,
                    child: Text("Add item"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
