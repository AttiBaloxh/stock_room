import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';
import 'package:stock_room_app/screens/add_Items/add_Product_New.dart';
import 'package:stock_room_app/screens/add_Items/products/my_Products.dart';
import 'package:stock_room_app/screens/map_Screens/welcome.dart';
import 'package:stock_room_app/screens/profile/profile_Menu.dart';
import '../histoy.dart/history.dart';
import '../chat/chatHome.dart';
class MyDrawer extends StatefulWidget {
  static String id = "MyDrawer";

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: KPrimaryColor,
        child: ListView(
          children: [
            Container(
              height: 130,
              child: Center(
                child: ListTile(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context, false);
                      },
                      icon: Image.asset(
                        'assets/Group 77.1.png',
                        height: 13,
                      )),
                  title: Image.asset(
                    'assets/StockRoom.png',
                    height: 18,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Welcome(),
                  ),
                );
              },
              leading: Image.asset(
                'assets/Group 317.png',
                height: 16,
              ),
              title: Text(
                "Home",
                style: TextStyle(
                  fontSize: 16,
                  color: KGreyColor.withOpacity(0.5),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => MyProducts(),
                  ),
                );
              },
              leading: Image.asset(
                'assets/Group 298.png',
                height: 16,
              ),
              title: Text(
                "My Products",
                style: TextStyle(
                  fontSize: 16,
                  color: KGreyColor.withOpacity(0.5),
                ),
              ),
            ),
            ListTile(
              onTap: () {},
              leading: Image.asset(
                'assets/Group 314.png',
                height: 16,
              ),
              title: Text(
                "Manage Orders",
                style: TextStyle(
                  fontSize: 16,
                  color: KGreyColor.withOpacity(0.5),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => ChatHome(),
                  ),
                );
              },
              leading: Icon(Icons.chat,color: Colors.white30,),
              title: Text(
                "Chats",
                style: TextStyle(
                  fontSize: 16,
                  color: KGreyColor.withOpacity(0.5),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => History(),
                  ),
                );
              },
              leading: Image.asset(
                'assets/Group 316.png',
                height: 16,
              ),
              title: Text(
                "Order History",
                style: TextStyle(
                  fontSize: 16,
                  color: KGreyColor.withOpacity(0.5),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (context) => ProfileMenu(),
                  ),
                );
              },
              leading: Image.asset(
                'assets/Group 313.png',
                height: 16,
              ),
              title: Text(
                "Settings",
                style: TextStyle(
                  fontSize: 16,
                  color: KGreyColor.withOpacity(0.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
