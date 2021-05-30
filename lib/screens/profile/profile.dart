import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:menu_button/menu_button.dart';
import 'package:stock_room_app/constant.dart';

List filItems = [
  "Select your trade",
];
var selectedFilter = 0;

class Profile extends StatefulWidget {
  static String id = "Profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  TextEditingController otpChecker = TextEditingController();
  var buttonColor = KPrimaryColor;
  var buttonTextColor = KSecondaryColor;
  var buttonBorderColor = KPrimaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
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
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Center(
              child: Text(
                "Skip",
                style: TextStyle(color: KSecondaryColor.withOpacity(0.5)),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 124,
                  height: 124,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/jurica-koletic-317414-unsplash.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
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
                            initialSelection: 'IT',
                            favorite: ['+1', 'US'],
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

                  // onMenuButtonToggle: (isToggle) {
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
                  onChanged: (value) {
                    setState(
                          () {
                        if (otpChecker.text.isNotEmpty) {
                          buttonColor = KPrimaryColor;
                          buttonTextColor = KSecondaryColor;
                        } else {
                          buttonColor = KSecondaryColor;
                          buttonTextColor = KPrimaryColor;
                        }
                      },
                    );
                  },
                  controller: otpChecker,
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
                  child: MaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    color: buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Finish Set Up",
                      style: TextStyle(
                        color: buttonTextColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
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
