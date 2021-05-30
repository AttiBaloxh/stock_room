import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../model/user_model.dart';
class UserData with ChangeNotifier {
  List<UserModel> _userDataModelList = [];
  UserModel userDataModel;

  Future<void> fetchUserList() async {
    List<UserModel> _newUserDataModel = [];
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection("Users").get();
    query.docs.forEach((element) {
      String email = element.data()['UserEmail'];
      String password = element.data()['UserPassword'];
      String photoUrl = element.data()['UserImage'];
      String userName = element.data()['UserName'];
      String userUid = element.data()['UserUid'];
      String confirmPassword = element.data()['UserConfirmPassword'];
      userDataModel = UserModel(
          email: email,
          password: password,
          photoUrl: photoUrl,
          userName: userName,
          userUid: userUid,
          confirmPassword: confirmPassword);
      _newUserDataModel.add(userDataModel);
    });
    _userDataModelList = _newUserDataModel;
    notifyListeners();
  }

  List<UserModel> get getUserDataList => List.from(_userDataModelList);
}
