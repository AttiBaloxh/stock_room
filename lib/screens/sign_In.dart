import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:stock_room_app/phone_auth/check_login_page.dart';
import 'package:stock_room_app/provider/product.dart';
import 'package:stock_room_app/screens/map_Screens/welcome.dart';
import '../constant.dart';
import 'alert_Dialouges/select_User.dart';
import 'forgot_Password/retreieve_Password.dart';

var usersRef = FirebaseFirestore.instance.collection('Users');

class SignIn extends StatefulWidget {
  final character;
  static String id = "SignIn";
  SignIn({this.character});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController phoneController = TextEditingController();
  Future<void> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final User user = (await _auth.signInWithCredential(credential)).user;
      print("signed in " + user.displayName);
      await productProvider.boolData(
        user: user,
        enumData: widget.character,
      );

      return user;
    } catch (e) {
      print(e.message);
    }
  }

  ProductProvider productProvider;

  Future<void> signUpWithFacebook() async {
    try {
      var facebookLogin = new FacebookLogin();
      facebookLogin.loginBehavior = FacebookLoginBehavior.webOnly;

      var result = await facebookLogin.logIn([
        'email',
      ]);

      if (result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.credential(
          result.accessToken.token,
        );
        final User user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        await productProvider.boolData(
          user: user,
          enumData: widget.character,
        );
        return user;
      }
    } catch (e) {
      print(e.message);
    }
  }

  void submit() async {
    
      ConfirmationResult confirmationResult =
          await FirebaseAuth.instance.signInWithPhoneNumber(
              '+92 335 2580282',
              RecaptchaVerifier(
                onSuccess: () => print('reCAPTCHA Completed!'),
                onError: (FirebaseAuthException error) => print(error),
                onExpired: () => print('reCAPTCHA Expired!'),
                container: 'recaptcha',
                size: RecaptchaVerifierSize.compact,
                theme: RecaptchaVerifierTheme.dark,
              ));
    
          await confirmationResult.confirm('123456');
    
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    print(widget.character);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        title: Container(
          child: Image.asset(
            'assets/StockRoom.png',
            height: 15.85,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Sign In to\nContinue",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
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
              TextFormField(
                controller: phoneController,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: KPrimaryColor,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: KBlackColor,
                ),
                decoration: InputDecoration(),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Password",
                style: TextStyle(
                  color: KPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                //controller: passwordController,
                obscureText: true,
                textAlignVertical: TextAlignVertical.center,
                cursorColor: KPrimaryColor,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: KBlackColor),
                decoration: InputDecoration(),
              ),
              SizedBox(
                height: 18,
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
                    onPressed: () async {
                      submit();
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute(
                      //     builder: (context) =>
                      //         CheckingLoginPage(character: widget.character),
                      //   ),
                      // );
                    },
                    child: Text(
                      "Log in",
                      style: TextStyle(
                        color: KSecondaryColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Or Log In with Fingerprint",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: KBlackColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Center(
                child: Image.asset(
                  'assets/Group.png',
                  height: 47,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Divider(
                        endIndent: 15,
                        color: Color(0xffD5DDE0),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Or sign IN with".toUpperCase(),
                        style: TextStyle(
                          fontSize: 12,
                          color: KBlackColor,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        indent: 15,
                        color: Color(0xffD5DDE0),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        signUpWithFacebook().then((value) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Welcome(),
                            ),
                          );
                        });
                      },
                      child: Image.asset(
                        'assets/fb-removebg-preview.png',
                        height: 27,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Image.asset(
                        'assets/twitter-removebg-preview.png',
                        height: 27,
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _googleSignUp().then(
                          (value) => Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => Welcome(),
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/google-removebg-preview.png',
                        height: 27,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: KSecondaryColor,
        elevation: 0,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RetreievePassword(),
                    ),
                  );
                },
                child: RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Forget your Password?",
                      style: TextStyle(
                        color: KPrimaryColor,
                        fontFamily: "Montserrat",
                      ),
                    ),
                    TextSpan(
                      text: " Tap here",
                      style: TextStyle(
                        color: KPrimaryColor,
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
