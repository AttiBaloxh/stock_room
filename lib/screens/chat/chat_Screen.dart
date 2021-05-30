import 'package:flutter/material.dart';
import 'package:stock_room_app/constant.dart';

class ChatScreen extends StatefulWidget {
  static String id = "ChatScreen";

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KWhiteColor,
      appBar: AppBar(
        leadingWidth: 60,
        toolbarHeight: 80,
        elevation: 0,
        backgroundColor: KWhiteColor,
        leading: Center(
          child: Card(
            margin: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
            elevation: 5,
            child: Container(
              padding: EdgeInsets.only(left: 1.5),
              width: 30,
              height: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 15,
                  color: KBlackColor,
                ),
              ),
            ),
          ),
        ),
        title: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Patrick",
                style: TextStyle(
                  color: Color(0xff3E4958),
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "San Franscio, 5km Away",
                style: TextStyle(
                  color: Color(0xff97ADB6),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  wordSpacing: 2,
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
        actions: [
          Center(
            child: Container(
              margin: EdgeInsets.only(right: 15),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.asset(
                  'assets/jurica-koletic-317414-unsplash.png',
                  height: 50,
                ),
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.84,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LeftBubble(
                    msg: "Hey, I’m on your way",
                    time: "2:36 AM",
                  ),
                  RightBubble(
                    msg: "Ok, waiting for you near\nsupermarket",
                    time: "2:38 AM",
                  ),
                  LeftBubble(
                    msg: "Hold on, i will be in 5 minutes",
                    time: "",
                  ),
                  EmojiClass(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Card(
              margin: EdgeInsets.zero,
              elevation: 5,
              child: Container(
                height: 56,
                child: ListTile(
                  leading: Image.asset(
                    'assets/ic_img-removebg-preview.png',
                    height: 40,
                  ),
                  title: Container(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Color(0xffD5DDE0),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide(
                            color: Color(0xffD5DDE0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LeftBubble extends StatefulWidget {
  final msg;
  final emoji;
  final time;

  LeftBubble({
    this.msg,
    this.emoji,
    this.time,
  });

  @override
  _LeftBubbleState createState() => _LeftBubbleState();
}

class _LeftBubbleState extends State<LeftBubble> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            decoration: BoxDecoration(
              color: Color(0xffF7F8F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Text(
              widget.msg,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xff3E4958),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.time,
            style: TextStyle(
              color: Color(0xff97ADB6),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class RightBubble extends StatefulWidget {
  final msg;
  final emoji;
  final time;

  RightBubble({
    this.msg,
    this.emoji,
    this.time,
  });

  @override
  _RightBubbleState createState() => _RightBubbleState();
}

class _RightBubbleState extends State<RightBubble> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            margin: EdgeInsets.only(top: 30),
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            decoration: BoxDecoration(
              color: Color(0xff000000),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Text(
              widget.msg,
              style: TextStyle(
                fontSize: 15,
                color: KWhiteColor,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.time,
            style: TextStyle(
              color: Color(0xff97ADB6),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class EmojiClass extends StatefulWidget {
  @override
  _EmojiClassState createState() => _EmojiClassState();
}

class _EmojiClassState extends State<EmojiClass> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            decoration: BoxDecoration(
              color: Color(0xffF7F8F9),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Image.asset(
              'assets/🙂.png',
              height: 18,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "8:38 AM",
            style: TextStyle(
              color: Color(0xff97ADB6),
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
