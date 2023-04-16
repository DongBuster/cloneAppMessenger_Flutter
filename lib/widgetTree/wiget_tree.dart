import 'package:flutter/material.dart';
import 'package:flutter_application_1/buildScreen/login_register_page.dart';
import 'MyStateFullWidget.dart';
import '../AuthSevice/auth.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    // return MyStatefulWidget();
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          return MyStatefulWidget();
        } else {
          return const loginPage();
        }
      },
    );
  }
}
