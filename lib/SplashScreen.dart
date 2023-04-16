import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/api/APIs.dart';
import 'package:flutter_application_1/buildScreen/login_register_page.dart';

import 'widgetTree/MyStateFullWidget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  // const SplashScreen({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (APIs.auth.currentUser != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MyStatefulWidget()));
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const loginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Image.network(
                    "https://cdn-icons-png.flaticon.com/512/1041/1041916.png",
                    height: 100.0,
                    width: 100.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
