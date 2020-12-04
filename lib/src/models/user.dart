
class UserModel {
  String uid;
  String email;
  String firstName;
  String lastName;
  String photoUrl;


  UserModel({
    this.uid, this.email, this.firstName, this.lastName, this.photoUrl
  });

  factory UserModel.fromMap(Map data){
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'],
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() =>
  {"uid": uid, "email": email, "firstName": firstName,"lastName": lastName, "photUrl": photoUrl};

}
