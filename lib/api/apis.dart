import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_application_1/model/chatUser.dart';
import 'package:flutter_application_1/model/messageModel.dart';

class APIs {
  // static var mq_heigt = MediaQuery.of(context)

  // for authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for accessing cloud firestore database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  static FirebaseStorage storage = FirebaseStorage.instance;

  // return current user
  static User get user => auth.currentUser!;

  // for storing self information
  static ChatUser me =
      ChatUser(image: '', name: '', id: '', isOnline: '', email: '', about: '');

  // for getting current user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('users').doc(user.uid).get().then((user) async {
      if (user.exists) {
        me = ChatUser.fromJson(user.data()!);
        // log('${me.image}');
      } else {
        await createUser().then((value) => getSelfInfo());
      }
    });
  }

  // for checking id user exists or not?
  static Future<bool> userExists() async {
    return (await firestore.collection('users').doc(user.uid).get()).exists;
  }

  // for create a new user
  static Future<void> createUser() async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final chatUser = ChatUser(
      id: user.uid,
      name: user.displayName.toString(),
      image: user.photoURL.toString(),
      isOnline: 'false',
      email: user.email.toString(),
      about: '',
    );

    return await firestore
        .collection('users')
        .doc(user.uid)
        .set(chatUser.toJson());
  }

  // getting all users from the firestore
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsers() {
    return firestore
        .collection('users')
        .where('id', isNotEqualTo: user.uid)
        .snapshots();
  }

  // for create conversation
  static String getConversationId(String id) => user.uid.hashCode <= id.hashCode
      ? '${user.uid}_$id'
      : '${id}_${user.uid}';
  // for get all messages of a specific conversation from the firestore database
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUser user) {
    return firestore
        .collection('chats/${getConversationId(user.id)}/messages/')
        .snapshots();
  }

  static Future<void> SendMessage(ChatUser chatUser, String msg) async {
    final time = DateTime.now().microsecondsSinceEpoch.toString();

    final Messages message = Messages(
        senderID: chatUser.id,
        read: '',
        receiverID: user.uid,
        message: msg,
        type: Type.text,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationId(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());
  }

  static Future<void> updateUserInfo() async {
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'name': me.name, 'about': me.about});
  }

  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split('.').last;
    final ref = storage.ref().child('profile_picture/${user.uid}.$ext');
    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext'));

    me.image = await ref.getDownloadURL();
    await firestore
        .collection('users')
        .doc(user.uid)
        .update({'image': me.image});
  }

  static Future<void> updateMessageReadStatus(Messages msg) async {
    firestore
        .collection('chats/${getConversationId(msg.receiverID)}/messages/')
        .doc(msg.sent)
        .update({'read': DateTime.now().microsecondsSinceEpoch.toString()});
  }
}
