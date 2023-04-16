import 'package:flutter/material.dart';
import '../buildScreen/homeScreen.dart';
import '../buildScreen/fourthScreen.dart';
import '../buildScreen/secondScreen.dart';
import '../buildScreen/thirdScreen.dart';

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidget();
}

class _MyStatefulWidget extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> widgetOptions = <Widget>[
      ChatPage(),
      buildSecondScreen(context),
      buildThirdScreen(context),
      buildFourthScreen(context)
    ];
    return Scaffold(
        body: SafeArea(
          child: widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          unselectedItemColor:
              Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.blue,
          unselectedIconTheme:
              Theme.of(context).bottomNavigationBarTheme.unselectedIconTheme,
          selectedIconTheme: const IconThemeData(color: Colors.blue),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.message_sharp),
              label: 'Đoạn chat',
              // backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_call_sharp),
              label: 'Cuộc gọi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_alt_sharp),
              label: 'Danh bạ',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.pages),
              label: 'Tin',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ));
  }
}
