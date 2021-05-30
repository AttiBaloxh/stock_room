import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:stock_room_app/chat/const.dart';
import 'package:stock_room_app/chat/full_photo.dart';
import 'package:stock_room_app/screens/map_Screens/welcome.dart';

import '../constant.dart';

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

class MineChatScreen extends StatefulWidget {
  final String peerId;
  final String userImage;
  final String userName;
  MineChatScreen({
    this.peerId,
    this.userImage,
    this.userName,
  });

  @override
  State createState() =>
      MineChatScreenState(peerId: peerId, peerAvatar: userImage);
}

class MineChatScreenState extends State<MineChatScreen> {
  MineChatScreenState({@required this.peerId, @required this.peerAvatar});
  var connectivityResults;
  String peerId;
  String peerAvatar;
  String id;
  var image;

  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  int _limit = 20;
  final int _limitIncrement = 20;
  String groupChatId;
  // SharedPreferences prefs;
  final GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  File imageFile;
  bool isLoading;
  bool isShowSticker;
  String imageUrl;
  bool show;
  TextEditingController textEditingController;
  final ScrollController listScrollController = ScrollController();
  final FocusNode focusNode = FocusNode();

  var _message = '';
  _scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the bottom");
      setState(() {
        print("reach the bottom");
        _limit += _limitIncrement;
      });
    }
    if (listScrollController.offset <=
            listScrollController.position.minScrollExtent &&
        !listScrollController.position.outOfRange) {
      print("reach the top");
      setState(() {
        print("reach the top");
      });
    }
  }

  @override
  void initState() {
    super.initState();
    show = false;
    focusNode.addListener(
      () {
        if (focusNode.hasFocus) {
          setState(() {
            isShowSticker = false;
          });
        }
      },
    );

    listScrollController.addListener(_scrollListener);

    groupChatId = '';

    isLoading = false;
    isShowSticker = false;
    imageUrl = '';

    readLocal();
    textEditingController = new TextEditingController()
      ..addListener(() {
        setState(() {
          _message = textEditingController.text;
        });
      });
  }

  Future<bool> onBackPress() {
    if (show) {
      setState(() {
        show = false;
      });
    } else {
      Navigator.pop(context);
    }

    return Future.value(false);
  }

  File filePaths;

  // getFileImage() async {
  //   try {
  //     // File result = await FilePicker.getFile(
  //     //   type: FileType.image,
  //     // );
  //     FilePickerResult result = await FilePicker.platform.pickFiles(
  //       type: FileType.image,
  //     );

  //     if (result != null) {
  //       setState(() {
  //         result.files.first;
  //       });
  //       var fileUrl;
  //       fileUrl = await uploadFile(filePaths, 1);
  //       onSendMessage(fileUrl, 1);
  //       setState(() {
  //         isDoc = false;
  //       });
  //     }
  //   } on PlatformException catch (e) {
  //     _scafoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         backgroundColor: Theme.of(context).errorColor,
  //         content: Text(e.toString()),
  //       ),
  //     );
  //   }
  // }

  Widget _buildFile(text, Color color, Color iconColor) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 100.0,
        maxWidth: 280.0,
      ),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(3),
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/4/42/Pdf-2127829.png',
                height: 50,
              ),
              Text('PDF FILE')
            ],
          ),
          // GestureDetector(
          //   onTap: () {
          //     Downloader.download(text, 'pdf file', extension);
          //   },
          //   child: ClipOval(
          //     child: Container(
          //       color: iconColor,
          //       child: Padding(
          //         padding: const EdgeInsets.all(8.0),
          //         child: Icon(Icons.file_download, color: Colors.white),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  String fileName;

  var extension;
  // getFile() async {
  //   try {
  //     FilePickerResult result = await FilePicker.platform.pickFiles(
  //         type: FileType.custom,
  //         allowedExtensions: ['jpg', 'pdf', 'doc'],
  //       );

  //     if (result != null) {
  //       setState(() {
  //         filePaths = File(result.path);
  //       });

  //       fileName = result.path.split('/').last;
  //       extension = p.extension(result.path);
  //       var fileUrl;
  //       fileUrl = await uploadFile(filePaths, 5);
  //       onSendMessage(fileUrl, 5);
  //       setState(() {
  //         isDoc = false;
  //       });
  //     }
  //   } on PlatformException catch (e) {
  //     _scafoldKey.currentState.showSnackBar(
  //       SnackBar(
  //         backgroundColor: Theme.of(context).errorColor,
  //         content: Text(e.toString()),
  //       ),
  //     );
  //   }
  // }

  User currentUser = FirebaseAuth.instance.currentUser;

  readLocal() async {
    // prefs = await SharedPreferences.getInstance();
    id = currentUser.uid ?? "";
    if (id.hashCode <= peerId.hashCode) {
      groupChatId = '$id-$peerId';
    } else {
      groupChatId = '$peerId-$id';
    }

    FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'chattingWith': peerId});

    setState(() {});
  }

  File imageFiles;
  Future<void> getImages(ImageSource source) async {
    var image = await ImagePicker().getImage(source: source);
    setState(() {
      imageFiles = File(image.path);
    });
    await uploadFile(imageFiles, 1);
  }

  bool isDoc = false;
  void getDoc() {
    // Hide keyboard when sticker appear
    focusNode.unfocus();
    setState(() {
      isDoc = !isDoc;
    });
  }

  Widget flatButton(
      {IconData icondata, String title, Color color, Function onTap}) {
    return MaterialButton(
      onPressed: onTap,
      child: Column(
        children: [
          CircleAvatar(
              backgroundColor: color,
              child: Icon(
                icondata,
                color: Colors.white,
              )),
          SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  Widget buildDoc() {
    return Container(
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Wrap(
            children: <Widget>[
              flatButton(
                onTap: () {},
                icondata: Icons.picture_as_pdf,
                title: 'PDF',
              ),
              flatButton(
                onTap: () {
                  // getFileImage();
                },
                color: Colors.purple,
                icondata: Icons.image,
                title: 'Gallery',
              ),
            ],
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey, width: 0.5)),
          color: Colors.white),
      padding: EdgeInsets.all(5.0),
      height: 180.0,
    );
  }

  Future uploadFile(var file, int type) async {
    setState(() {
      isLoading = true;
    });
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    var reference = FirebaseStorage.instance.ref().child(fileName);
    var uploadTask = reference.putFile(file);
    var storageTaskSnapshot = await uploadTask;
    storageTaskSnapshot.ref.getDownloadURL().then((downloadUrl) {
      imageUrl = downloadUrl;
      setState(() {
        isLoading = false;
        onSendMessage(imageUrl, type);
      });
    }, onError: (err) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: 'This file is not an image');
    });
  }

  void onSendMessage(var content, int type) async {
    // prefs = await SharedPreferences.getInstance();
    // type: 0 = text, 1 = image, 2 = sticker
    if (content.trim() != '') {
      textEditingController.clear();

      var documentReference = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(
          documentReference,
          {
            'idFrom': id,
            'idTo': peerId,
            'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
            'content': content,
            'type': type,
          },
        );
      });
      MessagedUser messagedUser = MessagedUser(
          peerId: widget.peerId,
          userImage: widget.userImage,
          userName: widget.userName);

      List<MessagedUser> userMessageDetails = [messagedUser];
      FirebaseFirestore.instance
          .collection("homemessage")
          .doc(currentUser.uid)
          .set({
        "userId": FirebaseAuth.instance.currentUser.uid,
        "userName": currentUser.displayName,
        "userImage": currentUser.photoURL,
        "chatWith": userMessageDetails
            .map((e) => {
                  "messagedUserId": e.peerId,
                  "messagedUserName": e.userName,
                  "messagedUserImage": e.userImage,
                })
            .toList(),
      });

      if (listScrollController.hasClients) {
        listScrollController.animateTo(0.0,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send',
          backgroundColor: Colors.black,
          textColor: Colors.red);
    }
  }

  var connectivityResult;

  final constraints = BoxConstraints(
    maxWidth: 250.0,
    minWidth: 50.0,
  );

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document.data()['idFrom'] == id) {
      return Row(
        children: <Widget>[
          document.data()['type'] == 0
              // Text
              ? Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5),
                        constraints: BoxConstraints(
                          minWidth: 100.0,
                        ),
                        child: Text(
                          document.data()['content'],
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: 100.0,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  width: 4.0,
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  constraints: BoxConstraints(
                    minWidth: 100.0,
                    maxWidth: 280.0,
                  ),
                  padding: const EdgeInsets.all(8.0),

                  decoration: BoxDecoration(
                    color: Color(0xff000000),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(0),
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50),
                    ),
                  ), // decoration: BoxDecoration(

                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                )
              : document.data()['type'] == 1
                  // Image
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: MaterialButton(
                        child: Material(
                          child: Stack(
                            children: [
                              Container(
                                height: 255,
                                width: 255,
                                color: greyColor2,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          themeColor),
                                    ),
                                    padding: EdgeInsets.all(70.0),
                                    decoration: BoxDecoration(
                                      color: greyColor2,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Material(
                                    child: Image.asset(
                                      'images/img_not_available.jpeg',
                                      width: 245.0,
                                      height: 245.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  imageUrl: document.data()['content'],
                                  width: 245.0,
                                  height: 245.0,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                          clipBehavior: Clip.hardEdge,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FullPhoto(
                                      url: document.data()['content'])));
                        },
                        padding: EdgeInsets.all(0),
                      ),
                    )
                  // Sticker

                  : document.data()['type'] == 5
                      ? Container()
                      : Container(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: Image.asset(
                            'assets/${document.data()['content']}.gif',
                            width: 80.0,
                            height: 80.0,
                            fit: BoxFit.cover,
                          ),
                        ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,
      );
    } else {
      return Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                document.data()['type'] == 0
                    ? Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints(
                                minWidth: 100.0,
                              ),
                              child: Text(
                                document.data()['content'],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 8.0),
                        constraints: BoxConstraints(
                          minWidth: 100.0,
                          maxWidth: 280.0,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              new BoxShadow(
                                  color: Colors.grey,
                                  offset: new Offset(1.0, 1.0),
                                  blurRadius: 1.0)
                            ],
                            borderRadius: BorderRadius.circular(8.0)),
                        margin: EdgeInsets.only(left: 10.0),
                      )
                    : document.data()['type'] == 1
                        ? Container(
                            child: MaterialButton(
                              child: Material(
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          themeColor),
                                    ),
                                    width: 50.0,
                                    height: 50.0,
                                    padding: EdgeInsets.all(70.0),
                                    decoration: BoxDecoration(
                                      color: greyColor2,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(8.0),
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Material(
                                    child: Image.asset(
                                      'images/img_not_available.jpeg',
                                      width: 180.0,
                                      height: 180.0,
                                      fit: BoxFit.cover,
                                    ),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8.0),
                                    ),
                                    clipBehavior: Clip.hardEdge,
                                  ),
                                  imageUrl: document.data()['content'],
                                  width: 180.0,
                                  height: 180.0,
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                clipBehavior: Clip.hardEdge,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FullPhoto(
                                            url: document.data()['content'])));
                              },
                              padding: EdgeInsets.all(0),
                            ),
                            margin: EdgeInsets.only(left: 10.0),
                          )
                        : document.data()['type'] == 5
                            ? _buildFile(document.data()['content'], greyColor2,
                                Colors.black)
                            : Container(
                                child: Image.asset(
                                  'images/${document.data()['content']}.gif',
                                  width: 80.0,
                                  height: 80.0,
                                  fit: BoxFit.cover,
                                ),
                              )
              ],
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        margin: EdgeInsets.only(bottom: 10.0),
      );
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        });
  }

  // Users sereceivernder, ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scafoldKey,
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
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Welcome(),
                    ),
                  );
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
                widget.userName,
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
          CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(
              widget.userImage,
            ),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            // image: DecorationImage(
            //   fit: BoxFit.cover,
            //   image: AssetImage('assets/background.jpg'),
            // ),
            ),
        child: WillPopScope(
          child: Stack(
            children: <Widget>[
              isLoading == false
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        // your list goes here

                        // Input content
                        buildListMessage(),
                        buildInput(),

                        // Sticker
                        // (isShowSticker ? buildSticker() : Container()),
                        (isDoc ? buildDoc() : Container()),
                      ],
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ],
          ),
          onWillPop: onBackPress,
        ),
      ),
    );
  }

  Widget buildInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(const Radius.circular(30.0)),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      // IconButton(
                      //     padding: const EdgeInsets.all(0.0),
                      //     icon: Icon(Icons.insert_emoticon),
                      //     onPressed: () {
                      //       setState(() {
                      //         focusNode.unfocus();
                      //         focusNode.canRequestFocus;
                      //         isShowSticker = !isShowSticker;
                      //       });
                      //     })
                      Image.asset(
                        'assets/ic_img-removebg-preview.png',
                        height: 40,
                      ),
                      Flexible(
                        child: TextField(
                          focusNode: focusNode,
                          controller: textEditingController,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            // border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(10.0),
                            hintText: 'Type a message',
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                            ),
                            counterText: '',
                          ),
                          onSubmitted: (String text) {
                            onSendMessage(textEditingController.text, 0);
                          },
                          keyboardType: TextInputType.multiline,
                          // maxLines: null,
                          // maxLength: 100,
                        ),
                      ),
                      // IconButton(
                      //   // color: iconColor,
                      //   icon: Icon(Icons.link),
                      //   onPressed: getDoc,
                      // ),
                      // _message.isEmpty || _message == null
                      //     ? CupertinoButton(
                      //         child:
                      //             Icon(Icons.camera_alt, color: Colors.black),
                      //         onPressed: () {
                      //           showCupertinoModalPopup(
                      //             context: context,
                      //             builder: (BuildContext context) =>
                      //                 CupertinoActionSheet(
                      //               message: const Text('your choise '),
                      //               actions: [
                      //                 CupertinoActionSheetAction(
                      //                   child: const Text('Camera'),
                      //                   onPressed: () {
                      //                     getImages(ImageSource.camera);
                      //                     Navigator.of(context).pop();
                      //                   },
                      //                 ),
                      //                 CupertinoActionSheetAction(
                      //                   child: const Text('gallery'),
                      //                   onPressed: () {
                      //                     getImages(ImageSource.gallery);
                      //                     Navigator.of(context).pop();
                      //                   },
                      //                 )
                      //               ],
                      //             ),
                      //           );

                      //           // _settingModalBottomSheet(context);
                      //         },
                      //       )
                      //     : Container(),
                    ],
                  ),
                ),
              ),
              _message.isEmpty || _message == null
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: FloatingActionButton(
                        elevation: 2.0,
                        backgroundColor: Color(0xff00897b),
                        foregroundColor: Colors.white,
                        child: Icon(Icons.send),
                        onPressed: () =>
                            onSendMessage(textEditingController.text, 0),
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }

  // Widget buildSticker() {
  //   return EmojiPicker(
  //     rows: 3,
  //     columns: 7,
  //     buttonMode: ButtonMode.MATERIAL,
  //     numRecommended: 10,
  //     onEmojiSelected: (emoji, category) {
  //       textEditingController.text = textEditingController.text += emoji.emoji;
  //     },
  //   );
  // }

  Widget buildListMessage() {
    return Flexible(
      child: groupChatId == ''
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(themeColor)))
          : StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .doc(groupChatId)
                  .collection(groupChatId)
                  .orderBy('timestamp', descending: true)
                  .limit(_limit)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(themeColor)));
                } else {
                  listMessage.addAll(snapshot.data.docs);
                  return ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemBuilder: (context, index) {
                      return buildItem(index, snapshot.data.docs[index]);
                    },
                    itemCount: snapshot.data.docs.length,
                    reverse: true,
                    controller: listScrollController,
                  );
                }
              },
            ),
    );
  }
}
