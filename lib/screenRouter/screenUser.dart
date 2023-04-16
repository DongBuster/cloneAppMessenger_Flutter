import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/AuthSevice/auth.dart';
import 'package:flutter_application_1/api/apis.dart';
import 'package:flutter_application_1/buildScreen/login_register_page.dart';
import 'package:flutter_application_1/helper/Dialogs.dart';
import 'package:flutter_application_1/model/chatUser.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../Provider/theme_provider.dart';

enum SingingCharacter { turnOff, turnOn, system }

class Profile_Screen extends StatefulWidget {
  final ChatUser user;
  const Profile_Screen({super.key, required this.user});
  @override
  State<Profile_Screen> createState() => _MyProfile_ScreenState();
}

class _MyProfile_ScreenState extends State<Profile_Screen> {
  final User? user = Auth().currentUser;
  final _formKey = GlobalKey<FormState>();

  bool isEdit = false;
  String? _image;
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
        ),
        title: Text(
          'Tôi',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // shrinkWrap: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 23),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            _image != null
                                ? Container(
                                    height: mq.height * .3,
                                    width: mq.width * .5,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            mq.height * .2)),
                                    child: Image.file(
                                      File(_image!),
                                      fit: BoxFit.fill,
                                    ))
                                : Container(
                                    height: mq.height * .3,
                                    width: mq.width * .5,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            mq.height * .2)),
                                    child: CachedNetworkImage(
                                      imageUrl: widget.user.image,
                                      fit: BoxFit.fill,
                                      errorWidget: (context, url, error) =>
                                          const CircleAvatar(
                                        child: Icon(
                                          Icons.person,
                                          size: 70,
                                        ),
                                      ),
                                    ),
                                  ),
                            Positioned(
                                right: -5,
                                bottom: 0,
                                child: MaterialButton(
                                  onPressed: () {
                                    setState(() {
                                      isEdit = !isEdit;
                                    });
                                    showBottomSheet();
                                  },
                                  shape: const CircleBorder(),
                                  color: Colors.white,
                                  child: const Icon(
                                    Icons.edit,
                                    size: 15,
                                    color: Colors.blueAccent,
                                  ),
                                ))
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 23, bottom: 0),
                          child: Text(
                            widget.user.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 23),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 23),
                          child: Text(
                            widget.user.about,
                            style: const TextStyle(
                                color: Colors.black45, fontSize: 17),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              isEdit
                  ? EditSelfInfo(
                      formkey: _formKey,
                      isEdit: isEdit,
                    )
                  : const SizedBox(),
              InkWell(
                  onTap: () async {
                    // Navigator.pop(context);
                    // APIs.auth.signOut();
                    // Navigator.pushReplacement(context,
                    //     MaterialPageRoute(builder: (_) => const loginPage()));
                    Dialogs.showProgressBar(context);
                    await APIs.auth.signOut().then((value) async {
                      await GoogleSignIn().signOut().then((value) {
                        Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const loginPage()));
                      });
                    });
                  },
                  child: Container(
                      margin: const EdgeInsets.only(left: 20),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [Text('LogOut')]))),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const detailsTheme())),
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.black,
                        ),
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        width: 40,
                        height: 40,
                        child: const Center(
                          child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.bedtime,
                              color: Colors.white,
                            ),
                            iconSize: 18,
                            padding: EdgeInsets.all(0),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 23),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Chế độ tối',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text('Hệ thống',
                                    style: TextStyle(
                                      fontSize: 13,
                                    )),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const message_waiting())),
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.blue,
                        ),
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        width: 40,
                        height: 40,
                        child: const Center(
                          child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.message_outlined,
                              color: Colors.white,
                            ),
                            iconSize: 18,
                            padding: EdgeInsets.all(0),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 23),
                          child: Column(
                            children: const [
                              Text(
                                'Tin nhắn đang chờ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: null,
                child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.purple,
                        ),
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        width: 40,
                        height: 40,
                        child: const Center(
                          child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.newspaper,
                              color: Colors.white,
                            ),
                            iconSize: 18,
                            padding: EdgeInsets.all(0),
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(left: 23),
                          child: Column(
                            children: const [
                              Text(
                                'Đoạn chat đã lưu trữ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w400),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 30, bottom: 20),
                child: Text(
                  'Trang cá nhân',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              buildListSystem(Colors.purple, Icons.sentiment_satisfied,
                  'Trạng thái tùy chỉnh', ''),
              buildListSystem(Colors.blue, Icons.circle, 'Trạng thái hoạt động',
                  'Đang bật'),
              buildListSystem(
                  Colors.purple, Icons.alternate_email, 'Tên người dùng', ''),
              const Padding(
                padding: EdgeInsets.only(top: 10, left: 30, bottom: 20),
                child: Text(
                  'Trang cá nhân',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              buildListSystem(Colors.purple, Icons.sentiment_satisfied,
                  'Trạng thái tùy chỉnh', ''),
              buildListSystem(Colors.blue, Icons.circle, 'Trạng thái hoạt động',
                  'Đang bật'),
              buildListSystem(
                  Colors.purple, Icons.alternate_email, 'Tên người dùng', ''),
            ],
          ),
        ),
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        builder: (_) {
          return Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Center(
                child: Text(
                  'Pick Profile update',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: Size(100, 100)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          setState(() {
                            _image = image.path;
                            log(image.path);
                          });
                          APIs.updateProfilePicture(File(_image!));

                          Navigator.pop(context);
                        }
                      },
                      child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/5460/5460486.png')),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: Size(100, 100)),
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.camera);
                        if (image != null) {
                          setState(() {
                            _image = image.path;
                          });
                          APIs.updateProfilePicture(File(_image!));
                          Navigator.pop(context);
                        }
                      },
                      child: Image.network(
                          'https://cdn-icons-png.flaticon.com/512/1042/1042413.png')),
                ],
              )
            ],
          );
        });
  }
}

Widget buildListSystem(
    Color backgroundColor, IconData icon, String title, String subtitle) {
  if (subtitle == '') {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      padding: const EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: backgroundColor,
            ),
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            width: 40,
            height: 40,
            child: Center(
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  icon,
                  color: Colors.white,
                  size: 23,
                ),
                iconSize: 18,
                padding: const EdgeInsets.all(0),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 23),
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ],
              )),
        ],
      ),
    );
  } else {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: backgroundColor,
            ),
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.all(0),
            width: 40,
            height: 40,
            child: Center(
              child: IconButton(
                onPressed: null,
                icon: Icon(
                  icon,
                  color: Colors.white,
                  size: 23,
                ),
                iconSize: 18,
                padding: const EdgeInsets.all(0),
              ),
            ),
          ),
          Container(
              margin: const EdgeInsets.only(left: 23),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(subtitle,
                        style: const TextStyle(
                          fontSize: 13,
                        )),
                  )
                ],
              )),
        ],
      ),
    );
  }
}

///
class detailsTheme extends StatefulWidget {
  const detailsTheme({super.key});
  @override
  State<detailsTheme> createState() => _detailsTheme();
}

class _detailsTheme extends State<detailsTheme> {
  int isOn = 0;

  SingingCharacter? _character = SingingCharacter.system;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).appBarTheme.iconTheme,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
          ),
        ),
        title: Text(
          'Trở về',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 20, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text('Chế độ tối',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    )),
              ),
              ListTile(
                // contentPadding: const EdgeInsets.only(top: 10),
                title: const Text('Tắt'),
                leading: Radio<SingingCharacter>(
                    value: SingingCharacter.turnOff,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      HapticFeedback.mediumImpact();
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleMode();
                      setState(() {
                        _character = value;
                        isOn == 0 ? isOn = 1 : isOn = 0;
                      });
                    }),
              ),
              ListTile(
                title: const Text('Bật'),
                leading: Radio<SingingCharacter>(
                    value: SingingCharacter.turnOn,
                    groupValue: _character,
                    onChanged: (SingingCharacter? value) {
                      HapticFeedback.mediumImpact();
                      Provider.of<ThemeProvider>(context, listen: false)
                          .toggleMode();
                      setState(() {
                        _character = value;
                        isOn == 0 ? isOn = 1 : isOn = 0;
                      });
                    }),
              ),
              // ListTile(
              //   title: const Text('Hệ thống'),
              //   leading: Radio<SingingCharacter>(
              //     value: SingingCharacter.system,
              //     groupValue: _character,
              //     onChanged: (SingingCharacter? value)=>setState(() {
              //       _character =value;
              //     })
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

///

class message_waiting extends StatefulWidget {
  const message_waiting({super.key});
  @override
  State<message_waiting> createState() => _message_waiting();
}

class _message_waiting extends State<message_waiting> {
  late Color color1;
  Color color2 = Color.fromARGB(255, 254, 252, 251);

  @override
  void initState() {
    color1 = Colors.black12;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 70,
              padding: const EdgeInsets.only(left: 15, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 23,
                            color: Colors.black,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 18),
                          child: Text(
                            'Tin nhắn đang chờ',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'CHỈNH SỬA',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.3),
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 30, right: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            splashColor: color1,
                            onTap: () => setState(() {
                              if (color1 ==
                                  Color.fromARGB(255, 254, 252, 251)) {
                                color2 = Color.fromARGB(255, 254, 252, 251);
                                color1 = Colors.black12;
                              }
                            }),
                            child: Container(
                              width: 200,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: color1,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                child: Text(
                                  'Bạn có thể biết',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: color2,
                            onTap: () => setState(() {
                              if (color2 ==
                                  Color.fromARGB(255, 254, 252, 251)) {
                                color2 = Colors.black12;
                                color1 = Color.fromARGB(255, 254, 252, 251);
                              }
                            }),
                            child: Container(
                              width: 200,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: color2,
                                  borderRadius: BorderRadius.circular(8)),
                              child: const Center(
                                child: Text(
                                  'Spam',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditSelfInfo extends StatefulWidget {
  GlobalKey<FormState> formkey;
  bool isEdit;
  EditSelfInfo({super.key, required this.formkey, required this.isEdit});

  @override
  State<EditSelfInfo> createState() => _EditSelfInfoState();
}

class _EditSelfInfoState extends State<EditSelfInfo> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: APIs.me.name,
              onSaved: (value) => APIs.me.name = value ?? '',
              validator: (value) =>
                  value != null && value.isNotEmpty ? null : 'required field',
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'eg. happy',
                  label: const Text('name')),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              initialValue: APIs.me.about,
              onSaved: (value) => APIs.me.about = value ?? '',
              validator: (value) =>
                  value != null && value.isNotEmpty ? null : 'required field',
              decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.info_outline,
                    color: Colors.blue,
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  hintText: 'eg. feeling happy',
                  label: const Text('about')),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 15),
                child: ElevatedButton.icon(
                  onPressed: () {
                    if (widget.formkey.currentState!.validate()) {
                      widget.formkey.currentState!.save();
                      APIs.updateUserInfo().then((value) => {
                            Dialogs.showSnackBar(
                                context, 'Profile update successfully')
                          });
                      setState(() {
                        widget.isEdit = !widget.isEdit;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    minimumSize: const Size(60, 50),
                  ),
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  label: const Text(
                    'Update',
                    style: TextStyle(fontSize: 16),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
