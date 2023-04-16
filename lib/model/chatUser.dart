class ChatUser {
  ChatUser({
    required this.image,
    required this.name,
    required this.id,
    required this.isOnline,
    required this.email,
    required this.about,
  });
  late String image;
  late String name;
  late String id;
  late String isOnline;
  late String email;
  late String about;

  ChatUser.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    name = json['name'] ?? '';
    id = json['id'] ?? '';
    isOnline = json['isOnline'] ?? '';
    email = json['email'] ?? '';
    about = json['about'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['name'] = name;
    data['id'] = id;
    data['isOnline'] = isOnline;
    data['email'] = email;
    data['about'] = about;
    return data;
  }
}
