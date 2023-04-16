import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/apis.dart';
import 'package:flutter_application_1/buildWidget/chatUserCard.dart';
import 'package:flutter_application_1/buildWidget/widgetPublic.dart';
import 'package:flutter_application_1/screenRouter/screenUser.dart';
import '../AuthSevice/auth.dart';
import '../screenRouter/screenPost.dart';
import '../model/chatUser.dart';

class ChatPage extends StatefulWidget {
  final User? user = Auth().currentUser;

  ChatPage({super.key});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final User? user = Auth().currentUser;

  // ChatController chatController = ChatController();

  List<ChatUser> list = [];
  List<ChatUser> searchList = [];
  bool isSearch = false;

  final myController = TextEditingController();
  @override
  void initState() {
    super.initState();
    APIs.getSelfInfo();
  }

  // @override
  // void dispose() {
  //   myController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 0.0),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Profile_Screen(
                              user: APIs.me,
                            ))),
                    child: buildAvartar(APIs.me.image, 'false')),
                Text(
                  'Message',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Wrap(
                  spacing: 15.0,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black12,
                        ),
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        width: 30,
                        height: 30,
                        child: const Center(
                          child: IconButton(
                            onPressed: null,
                            icon: Icon(Icons.camera_alt_sharp),
                            iconSize: 18,
                            padding: EdgeInsets.all(0),
                            color: Colors.black,
                          ),
                        )),
                    Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black12,
                        ),
                        width: 30,
                        height: 30,
                        child: Center(
                          child: IconButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LocalDB())),
                            icon: const Icon(Icons.post_add_sharp),
                            iconSize: 18,
                            padding: const EdgeInsets.all(0),
                            color: Colors.black,
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20, 30, 20, 20),
              child: TextFormField(
                controller: myController,
                style: const TextStyle(
                  fontSize: 15,
                ),
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40.0),
                      borderSide: BorderSide.none),
                  suffixIcon: Icon(
                    Icons.search,
                    color:
                        Theme.of(context).inputDecorationTheme.suffixIconColor,
                  ),
                  hintText: 'Enter a search term',
                  contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  filled: true,
                  fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                ),
                onTap: () {
                  setState(() {
                    isSearch = !isSearch;
                  });
                },
                onTapOutside: (PointerDownEvent event) {
                  FocusScope.of(context).unfocus();
                  myController.text = '';
                  isSearch = false;
                },
                onChanged: (value) {
                  searchList.clear();
                  for (var i in list) {
                    if (i.name.toLowerCase().contains(value.toLowerCase())) {
                      searchList.add(i);
                    }
                    setState(() {
                      searchList;
                    });
                  }
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.only(left: 20),
                    height: 40,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: APIs.getAllUsers(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          switch (snapshot.connectionState) {
                            // if data is loading
                            case ConnectionState.waiting:
                            case ConnectionState.none:
                            // return const Center(
                            //   child: CircularProgressIndicator(),
                            // );
                            //if some data or all data is loaded then show it
                            case ConnectionState.active:
                            case ConnectionState.done:
                              final data = snapshot.data?.docs;
                              list = data
                                      ?.map((e) => ChatUser.fromJson(
                                          e.data() as Map<String, dynamic>))
                                      .toList() ??
                                  [];
                              return ListView.builder(
                                // padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                    child: buildAvartar(list[index].image,
                                        list[index].isOnline),
                                  );
                                },
                                // buildCircleImage(
                                //     'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbpbjUU1mnP1ymtnMIgzXk0Q2ESozCUX1q2Q&usqp=CAU',
                                //     Icons.circle),
                              );
                          }
                        }))
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream: APIs.getAllUsers(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  switch (snapshot.connectionState) {
                    // if data is loading
                    case ConnectionState.waiting:
                    case ConnectionState.none:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    //if some data or all data is loaded then show it
                    case ConnectionState.active:
                    case ConnectionState.done:
                      final data = snapshot.data?.docs;
                      list = data
                              ?.map((e) => ChatUser.fromJson(
                                  e.data() as Map<String, dynamic>))
                              .toList() ??
                          [];

                      if (list.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: isSearch ? searchList.length : list.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: ((context, index) {
                            // return Text(list[index].isOnline);
                            return chatUserCard(
                                user:
                                    isSearch ? searchList[index] : list[index]);
                          }),
                        );
                      } else {
                        return const Center(
                          child: Text(
                            'No Connections found!',
                            style: TextStyle(fontSize: 20),
                          ),
                        );
                      }
                  }
                }),
          ])))
        ]),
      ),
    );
  }
}
