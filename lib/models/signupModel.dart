class UserModel {
    String? email;
    String? uId;
     String? name;
    String? image;
    String? phone;
    String? shipAddress;
    String? dateJoined;
    bool isVerified=false;

  UserModel({
    required this.email,
    required this.uId,
     required this.image,
    required this.name,
    required this.phone,
    required this.shipAddress,
    required this.dateJoined,
    required this.isVerified,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uId = json['uId'];
     image = json['image'];
    name = json['name'];
    phone = json['phone'];
    shipAddress = json['shipAddress'];
    dateJoined = json['dateJoined'];
    // isVerified = json['isVerified'];
  }

  Map<String, dynamic> toMap() {
    return  {
      'name':name,
      'email':email,
      'uId':uId,
      'image':image,
      'phone':phone,
      'shipAddress':shipAddress,
      'dateJoined':dateJoined,
      'isVerified':isVerified,

    };
  }
}
