import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widgetTree/wiget_tree.dart';
//Providers
import 'package:provider/provider.dart';
import 'Provider/theme_provider.dart';
import 'package:firebase_core/firebase_core.dart';

//global object for accessing device screen size
late Size mq;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // name: "chat-app",
      // options: DefaultFirebaseOptions.currentPlatform;
      options: const FirebaseOptions(
          apiKey: "AIzaSyDoXsZdlqisde5LJsCEc6Rpyr7lB6jd05Y",
          authDomain: "chat-app-b9063.firebaseapp.com",
          projectId: "chat-app-b9063",
          storageBucket: "chat-app-b9063.appspot.com",
          messagingSenderId: "408619027605",
          appId: "1:408619027605:web:76ff2993efaf6b0e605f9c"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (ctx, themeObject, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Messenger',
          themeMode: themeObject.mode,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                iconTheme: IconThemeData(color: Colors.black)),
            inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: const Color.fromARGB(255, 233, 233, 233),
                hintStyle: TextStyle(color: Colors.grey[900]),
                suffixIconColor: Colors.black26),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              unselectedItemColor: Colors.black54,
              unselectedIconTheme: IconThemeData(color: Colors.black54),
            ),
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                unselectedItemColor: Colors.white,
                unselectedIconTheme: IconThemeData(color: Colors.white)),
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[850],
                iconTheme: const IconThemeData(color: Colors.white60)),
            inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.grey[700],
                hintStyle: const TextStyle(color: Colors.white54),
                suffixIconColor: Colors.grey),
            brightness: Brightness.dark,
          ),
          home: const WidgetTree(),
        ),
      ),
    );
  }
}
