import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_button/menu_button.dart';
import 'package:stock_room_app/constant.dart';
import '../../model/user_model.dart';

List filItems = [
  "Select your trade",
];
var selectedFilter = 0;

class EditProfile extends StatefulWidget {
  final userImage;
  EditProfile({this.userImage});
  static String id = "EditProfile";

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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

  var buttonColor = KPrimaryColor;
  var buttonTextColor = KSecondaryColor;
  var buttonBorderColor = KPrimaryColor;
  UserModel userModel = UserModel();
  String userName;
  User currentUser = FirebaseAuth.instance.currentUser;
  //  UserModel currentUser;
  // ignore: missing_return
  TextEditingController fullname = TextEditingController();
  TextEditingController number = TextEditingController();

  var imageUrl;
  File image;

  Future uploadFile(
    var file,
  ) async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var reference = FirebaseStorage.instance.ref().child(fileName);
    var uploadTask = reference.putFile(file);
    var storageTaskSnapshot = await uploadTask;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        updateUsers(imageUrl);
      });
    }, onError: (err) {
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  Future getImage({ImageSource imageSource}) async {
    PickedFile pickedFile = await ImagePicker().getImage(source: imageSource,maxHeight: 450,maxWidth: 450,);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    uploadFile(image);
  }

  bool isLoadiing = false;
  void updateUsers(url) async {
    setState(() {
      isLoadiing = true;
    });
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser.uid)
        .set(
      {
        'UserImage': url,
      },
    );
    setState(() {
      isLoadiing = false;
    });
  }

  updateUserProfile() async {
    setState(() {
      isLoadiing = true;
    });
    await currentUser.updateProfile(
      displayName: userName,
    );
    setState(() {
      isLoadiing = false;
    });
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
          "Add Profile Image"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(
        elevation: 0,
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
          "Profile",
          style: TextStyle(
            fontSize: 16,
            color: KWhiteColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size(0, 200),
          child: Container(
            padding: EdgeInsets.only(bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  // decoration: BoxDecoration(
                  //   color: Colors.blueGrey.withOpacity(0.6),
                  //   shape: BoxShape.circle,
                  // ),
                  child: Stack(
                    children: [
                      Padding(
                          padding: const EdgeInsets.only(top: 2.0, left: 0),
                          child: Container(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: image == null
                                  ? Image.network(
                                      widget.userImage == null
                                          ? currentUser.photoURL
                                          : widget.userImage,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.file(
                                      image,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          )),
                      Positioned(
                        bottom: 3,
                        right: 7,
                        child: GestureDetector(
                          onTap: () {
                            showAlertDialog(context);
                          },
                          child: Container(
                            height: 23,
                            width: 23,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: KWhiteColor,
                            ),
                            child: Center(
                              child: Image.asset(
                                'assets/Group 302.png',
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  currentUser.displayName,
                  style: TextStyle(
                    fontSize: 16,
                    color: KWhiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  currentUser.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: KWhiteColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Full Name",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: KWhiteColor,
                child: TextField(
                  onChanged: (name) {
                    userName = name;
                  },
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
                    hintText: "Full Name",
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Phone Number",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                controller: number,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
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
                  prefixIcon: Container(
                    width: 123,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                            color: KBlackColor,
                          ),
                        ),
                        Container(
                          child: CountryCodePicker(
                            onChanged: print,
                            // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                            initialSelection: 'Pakistan',
                            favorite: ['+92', 'Pakistan'],
                            // optional. Shows only country name and flag
                            showCountryOnly: false,
                            // optional. Shows only country name and flag when popup is closed.
                            showOnlyCountryWhenClosed: false,
                            // optional. aligns the flag and the Text left
                            alignLeft: false,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Add Payment Card",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: KWhiteColor,
                child: TextField(
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
                    suffixIcon: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 32,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: KPrimaryColor.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: Image.asset(
                              'assets/ic_mastercard.png',
                              height: 24,
                            ),
                          ),
                        )
                      ],
                    ),
                    hintText: "6775 6677 6667 8295",
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Choose your Trade",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: MenuButton(
                  child: filButton,
                  items: filItems,
                  // Widget displayed as the button
                  selectedItem: (value) {
                    selectedFilter = value;
                  },
                  onItemSelected: (value) {
                    setState(
                      () {
                        selectedFilter = value;
                      },
                    );
                    // Action when new item is selected
                  },

                  // scrollPhysics: AlwaysScrollableScrollPhysics(),
                  // Change the physics of opened menu (example: you can remove or add scroll to menu)
                  itemBuilder: (value) => Container(
                    height: 40,
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 12, color: KPrimaryColor),
                    ),
                  ),
                  toggledChild: Container(
                    color: KPrimaryColor.withOpacity(0.4),
                    child: filButton,
                  ),
                  divider: Container(
                    height: 1,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4),
                    ),
                    color: KWhiteColor,
                  ),

                  // onMenuButtonToggle: (isToggle)  {
                  //   print(isToggle);
                  //     selectedItem = isToggle;
                  // },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Set your Availability",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                color: KWhiteColor,
                child: TextField(
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
                    hintText: "** Hours",
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.82,
                    decoration: BoxDecoration(
                      border: Border.all(color: buttonBorderColor),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 46,
                    child: isLoadiing == false
                        ? MaterialButton(
                            elevation: 0,
                            highlightElevation: 0,
                            color: buttonColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onPressed: () async {
                              if (userName != null) {
                                updateUserProfile();
                              } else {
                                Navigator.of(context).pop();
                              }
                            },
                            // () {
                            //   // Navigator.push(
                            //   //   context,
                            //   //   new MaterialPageRoute(
                            //   //     builder: (context) => SignUpOtpCode(),
                            //   //   ),
                            //   // );
                            // },
                            child: Text(
                              "Save Changes",
                              style: TextStyle(
                                color: buttonTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
