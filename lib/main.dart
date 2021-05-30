import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:stock_room_app/constant.dart';
import './phone_auth/check_login_page.dart';
import 'package:stock_room_app/screens/add_Items/add_Product_New.dart';
import 'package:stock_room_app/screens/add_Items/products/my_Products.dart';
import 'package:stock_room_app/screens/add_Items/scan_Barcodes/scan_Barcode.dart';
import 'package:stock_room_app/screens/add_Items/sell_Part.dart';
import 'package:stock_room_app/screens/alert_Dialouges/confirm_Email_Pop_Up.dart';
import 'package:stock_room_app/screens/alert_Dialouges/locating_Nearest_Seller.dart';
import 'package:stock_room_app/screens/alert_Dialouges/order_Confirmation.dart';
import 'package:stock_room_app/screens/alert_Dialouges/product_successfuly_Added.dart';
import 'package:stock_room_app/screens/alert_Dialouges/select_User.dart';
import 'package:stock_room_app/screens/bottom_Sheets/order_In_Progress_Call_Seller_BSheet.dart';
import 'package:stock_room_app/screens/bottom_Sheets/rate_Order.dart';
import 'package:stock_room_app/screens/bottom_Sheets/rate_Order_Done.dart';
import 'package:stock_room_app/screens/bottom_Sheets/scan_Image_Search_Image.dart';
import 'package:stock_room_app/screens/drawer/drawer.dart';
import 'package:stock_room_app/screens/forgot_Password/retreieve_Password.dart';
import 'package:stock_room_app/screens/forgot_Password/retreieve_Password_Confirm_Email.dart';
import 'package:stock_room_app/screens/get_Started.dart';
import 'package:stock_room_app/screens/map_Screens/locale_Parts.dart';
import 'package:stock_room_app/screens/map_Screens/order_In_Progress/order_In_Progress_Call_Seller.dart';
import 'package:stock_room_app/screens/map_Screens/welcome.dart';
import 'package:stock_room_app/screens/profile/add_Payment_Card.dart';
import 'package:stock_room_app/screens/profile/change_Password.dart';
import 'package:stock_room_app/screens/chat/chat_Screen.dart';
import 'package:stock_room_app/screens/profile/edit_Profile.dart';
import 'package:stock_room_app/screens/profile/profile.dart';
import 'package:stock_room_app/screens/profile/profile_Menu.dart';
import 'package:stock_room_app/screens/profile/term_And_Conditions.dart';
import 'package:stock_room_app/screens/sign_In.dart';
import 'package:stock_room_app/screens/sign_Up_Enter_Phone.dart';
import 'package:stock_room_app/screens/sign_Up_Otp_Code.dart';
import 'package:stock_room_app/screens/sign_Up_Set_Password.dart';
import 'package:stock_room_app/screens/splash_Screen.dart';
import './provider/user_data.dart';
import 'provider/product.dart';
import 'screens/stripe_payment/existe_cards.dart';
import 'screens/stripe_payment/stripe_home.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (BuildContext context) => ProductProvider(),
        ),
        ChangeNotifierProvider<UserData>(
          create: (BuildContext context) => UserData(),
        ),
      ],
      child: MaterialApp(
        debugShowMaterialGrid: false,
        debugShowCheckedModeBanner: false,
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapShot) {
            if(!snapShot.hasData){

            return SplashScreen();
            }
            return Welcome();
          },
        ),
        theme: ThemeData(
          scaffoldBackgroundColor: KSecondaryColor,
          fontFamily: "Montserrat",
          primaryColor: Color(0xff1D2D61),
          accentColor: KPrimaryColor.withOpacity(0.2),
          canvasColor: Colors.transparent,
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w400, color: KBlackColor),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: KPrimaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(
                color: KPrimaryColor,
              ),
            ),
          ),
          buttonTheme: ButtonThemeData(
            splashColor: KPrimaryColor.withOpacity(0.5),
          ),
        ),
        // StripeHome.id,
        //ExisteCards.id,
        //GatewayIntegration.id,
        //  ScanBarcode.id,
        //ChatScreen.id,
        //  SplashScreen.id,
        //SignUpEnterPhone.id,
        //  CheckingLoginPage.id,
        //ChatScreen.id,
        //MyDrawer.id,
        //MyProducts.id,
        //CheckingLoginPage.id,
        // SignUpEnterPhone.id,
        routes: {
          StripeHome.id: (context) => StripeHome(),
          ExisteCards.id: (context) => ExisteCards(),
          SplashScreen.id: (context) => SplashScreen(),
          GetStarted.id: (context) => GetStarted(),
          SignIn.id: (context) => SignIn(),
          CheckingLoginPage.id: (context) => CheckingLoginPage(),
          SignUpEnterPhone.id: (context) => SignUpEnterPhone(),
          SignUpOtpCode.id: (context) => SignUpOtpCode(),
          SignUpSetPassword.id: (context) => SignUpSetPassword(),
          //Routes for forgot pass
          RetreievePassword.id: (context) => RetreievePassword(),
          RetreievePasswordConfirmEmail.id: (context) =>
              RetreievePasswordConfirmEmail(),
          //Routes for forgot pass end here

          //Chat screen
          ChatScreen.id: (context) => ChatScreen(),
          //Chat Screen

          //Maps Screens
          Welcome.id: (context) => Welcome(),
          LocalParts.id: (context) => LocalParts(),
          OrderInProgressCallSeller.id: (context) =>
              OrderInProgressCallSeller(),
          //Maps Screens
          //Add Items Start
          SellPart.id: (context) => SellPart(),
          //Barcode Scan
          ScanBarcode.id: (context) => ScanBarcode(),
          //Barcode Scan
          AddProductNew.id: (context) => AddProductNew(),
          //MyProducts
          MyProducts.id: (context) => MyProducts(),
          //Add Items End

          //Profile Screens
          ProfileMenu.id: (context) => ProfileMenu(),
          Profile.id: (context) => Profile(),
          EditProfile.id: (context) => EditProfile(),
          //Terms and Conditions
          TermsAndConditions.id: (context) => TermsAndConditions(),
          ChangePassword.id: (context) => ChangePassword(),
          AddPaymentCard.id: (context) => AddPaymentCard(),
          //Profile Screens end
          //  Popup routes
          SelectUser.id: (context) => SelectUser(),
          //Recover Email
          ConfirmEmailPopUp.id: (context) => ConfirmEmailPopUp(),
          //When product will be added
          ProductSuccessfullyAdded.id: (context) => ProductSuccessfullyAdded(),
          //Nearest seller locating
          LocationNearestSeller.id: (context) => LocationNearestSeller(),
          //Order Confirmation
          OrderConfirmation.id: (context) => OrderConfirmation(),
          //  Popup routes

          //Bottom Sheets
          ScanImageSearchImage.id: (context) => ScanImageSearchImage(),
          OrderInProgressCallSellerBSheet.id: (context) =>
              OrderInProgressCallSellerBSheet(),
          RateOrder.id: (context) => RateOrder(),
          RateOrderDone.id: (context) => RateOrderDone(),

          //Bottom Sheets
          //  Drawer
          MyDrawer.id: (context) => MyDrawer(),
        },
      ),
    );
  }
}
