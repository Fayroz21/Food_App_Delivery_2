
class MessageData {
  MessageData({
       this.toId,
       this.msg,
       this.sentTime,
       this.fromId,});

  MessageData.fromJson(dynamic json) {
    toId = json['toId'];
    msg = json['msg'];
    sentTime = json['sentTime'];
    fromId = json['fromId'];
  }
  String? toId;
  String? msg;
  String? sentTime;
  String? fromId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['toId'] = toId;
    map['msg'] = msg;
    map['sentTime'] = sentTime;
    map['fromId'] = fromId;
    return map;
  }

}