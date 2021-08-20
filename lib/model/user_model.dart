class UserModel{

  var email;
  var name;
  var phone;
  var uid;
  var isEmailVerfied;
  var images;
  var bio;
  var cover;

  UserModel({this.phone,this.name,this.email,this.uid,this.isEmailVerfied,this.images,this.bio,this.cover});

  UserModel.fromjson(Map<String,dynamic> json){
    email=json['email'];
    name=json['name'];
    phone=json['phone'];
    uid=json['uid'];
    isEmailVerfied=json['isEmailVerfied'];
    images=json['images'];
    bio=json['bio'];
    cover=json['cover'];

  }

  Map<String,dynamic> tomap(){
    return {
     'name': name,
     'email': email,
     'phone': phone,
     'uid': uid,
     'isEmailVerfied': isEmailVerfied,
     'images': images,
     'bio': bio,
     'cover': cover,
    };
  }

}