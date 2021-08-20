class MassageModel{
  var senderid;
  var reciverid;
  var datetime;
  var text;

  MassageModel({
    this.datetime,this.reciverid,this.senderid,this.text
});
  MassageModel.fromJson(Map<String,dynamic> json){
    senderid=json['senderid'];
    reciverid=json['reciverid'];
    datetime=json['datetime'];
    text=json['text'];
  }

  Map<String,dynamic> toMap(){
    return {
  'senderid' :senderid,
  'reciverid' :reciverid,
  'datetime' :datetime,
  'text' :text,
    };

  }
}