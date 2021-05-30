import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/phone_auth/check_login_page.dart';
import 'package:stock_room_app/provider/product.dart';
import 'package:stock_room_app/screens/add_Items/products/my_Products.dart';
import 'package:stock_room_app/screens/sign_In.dart';

enum SingingCharacter { buyer, seller }

class LoginUser extends StatefulWidget {
  static String id = "LoginUser";

  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {

  var buyers;
  var character = SingingCharacter.buyer;
  @override
  Widget build(BuildContext context) {
    character ==  SingingCharacter.buyer? buyers = 'buyers':buyers = 'sellers';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: EdgeInsets.zero,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              height: 300,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          "Select User",
                          style: TextStyle(
                              fontSize: 20,
                              color: KPrimaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Choose the type of user.",
                          style: TextStyle(
                            fontSize: 14,
                            color: KPrimaryColor.withOpacity(0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: KPrimaryColor.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: RadioListTile(
                            value: SingingCharacter.seller,
                            groupValue: character,
                            activeColor: KPrimaryColor,
                            onChanged: (SingingCharacter value) {
                              setState(() {
                                character = value;
                              });
                            },
                            title: Text(
                              "Seller",
                              style:
                                  TextStyle(fontSize: 14, color: KBlackColor),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: KPrimaryColor.withOpacity(0.3),
                              ),
                              borderRadius: BorderRadius.circular(5)),
                          child: RadioListTile(
                            value: SingingCharacter.buyer,
                            groupValue: character,
                            activeColor: KPrimaryColor,
                            onChanged: (SingingCharacter value) {
                              setState(() {
                                character = value;
                              });
                            },
                            title: Text(
                              "buyer",
                              style:
                                  TextStyle(fontSize: 14, color: KBlackColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.82,
                      height: 48,
                      child: MaterialButton(
                        elevation: 0,
                        highlightElevation: 0,
                        color: KPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        onPressed: () async{
                     
                        await  Navigator.push(
                            context,
                             MaterialPageRoute(
                                builder: (context) => SignIn(character:buyers)),
                          );
                        },
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            color: KSecondaryColor,
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
        ],
      ),
    );
  }
}
