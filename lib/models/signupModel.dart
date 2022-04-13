class UserModel {
    String? email;
    String? uId;
     String? name;
    String? image;
    String? phone;

  UserModel({
    required this.email,
    required this.uId,
     required this.image,
    required this.name,
    required this.phone,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    uId = json['uId'];
     image = json['image'];
    name = json['name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toMap() {
    return  {
      'name':name,
      'email':email,
      'uId':uId,
      'image':image,
      'phone':phone,

    };
  }
}
