
class UserModel {
  final password;
  final confirmPassword;
  final userName;
  final userUid;
  final email;
  final photoUrl;
  UserModel({
    this.confirmPassword,
    this.password,
    this.email,
    this.photoUrl,
    this.userName,
    this.userUid,
  });
  // factory UserModel.fromDocs(DocumentSnapshot docs) {
  //   return UserModel(
  //     confirmPassword: docs['confirmPassword'],
  //     email: docs['email'],
  //     password: docs['password'],
  //     photoUrl: docs['photoUrl'],
  //     userName: docs['userName'],
  //     userUid: docs['userUid'],

  //   );
  // }
}
