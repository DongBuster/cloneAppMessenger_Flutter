class Messages {
  Messages({
    required this.senderID,
    required this.read,
    required this.receiverID,
    required this.message,
    required this.type,
    required this.sent,
  });
  late final String senderID;
  late final String read;
  late final String receiverID;
  late final String message;
  late final Type type;
  late final String sent;

  Messages.fromJson(Map<String, dynamic> json) {
    senderID = json['senderID'].toString();
    read = json['read'].toString();
    receiverID = json['receiverID'].toString();
    message = json['message'].toString();
    type = json['type'].toString() == Type.image.name ? Type.image : Type.text;
    sent = json['sent'].toString();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['senderID'] = senderID;
    data['read'] = read;
    data['receiverID'] = receiverID;
    data['message'] = message;
    data['type'] = type.name;
    data['sent'] = sent;
    return data;
  }
}

enum Type { text, image }
