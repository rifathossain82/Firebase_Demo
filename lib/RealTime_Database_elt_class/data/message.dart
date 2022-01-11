class Message {
  String text;
  DateTime date;

  Message(this.text, this.date);

  Message.fromJson(Map<dynamic, dynamic> json)
      : text = json['text'] as String,
        date = DateTime.parse(json['date'] as String);

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    data['text']=this.text;
    data['date']=this.date.toString();

    return data;
  }
}
