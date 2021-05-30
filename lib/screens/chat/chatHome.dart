import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stock_room_app/chat/chat_screen.dart';

class MessagedUser {
  final String peerId;
  final String userImage;
  final String userName;
  MessagedUser({
    this.peerId,
    this.userImage,
    this.userName,
  });
}

class ChatHome extends StatefulWidget {
  @override
  _ChatHomeState createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  User currentUser = FirebaseAuth.instance.currentUser;
  List<MessagedUser> messageUserList = [];
  MessagedUser messagedUser;
  void getData() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("homemessage").get();
    querySnapshot.docs.forEach((element) {
      element.data()["chatWith"].forEach((messages) {
        if (currentUser.uid == messages["messagedUserId"]) {
          setState(() {
            messagedUser = MessagedUser(
              userName: element.data()["userName"],
              userImage: element.data()["userImage"],
              peerId: element.data()["userId"],
            );
            messageUserList.add(messagedUser);
          });
        }
      });
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Chat Screen'),
      ),
      body: messageUserList.isEmpty
          ? Center(
              child: Text(
              "No Data",
              style: TextStyle(color: Colors.black),
            ))
          : ListView.builder(
              itemCount: messageUserList.length,
              itemBuilder: (ctx, index) => ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage:
                          NetworkImage(messageUserList[index].userImage),
                    ),
                    title: Text(messageUserList[index].userName),
                    subtitle: Text("Hi i am useing Stock Room app"),
                    dense: false,
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => MineChatScreen(
                            peerId: messageUserList[index].peerId,
                            userImage: messageUserList[index].userImage,
                            userName: messageUserList[index].userName,
                          ),
                        ),
                      );
                    },
                  )),
    );
  }
}
