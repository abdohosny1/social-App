
class PostModel{


  var name;
  var uid;
  var images;
  var dateTime;
  var text;
  var PostImage;


  PostModel({this.dateTime,this.name,this.text,this.uid,this.PostImage,this.images,});

  PostModel.fromjson(Map<String,dynamic> json){
    dateTime=json['dateTime'];
    name=json['name'];
    text=json['text'];
    uid=json['uid'];
    images=json['images'];
    PostImage=json['PostImage'];

  }

  Map<String,dynamic> tomap(){
    return {
      'name': name,
      'dateTime': dateTime,
      'text': text,
      'uid': uid,
      'PostImage': PostImage,
      'images': images,

    };
  }

}