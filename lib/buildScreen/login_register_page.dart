import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/AuthSevice/auth.dart';
import 'package:flutter_application_1/api/APIs.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'homeScreen.dart';

class loginPage extends StatefulWidget {
  const loginPage({Key? key}) : super(key: key);
  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  String? errorMessage = "";
  bool isLogin = true;

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await APIs.auth.signInWithCredential(credential);
  }

  _handleGoogleBtnClick() {
    _signInWithGoogle().then((user) async {
      // log('\nUser: ${user.user}');
      // log('\nUserAdditionalInfo: ${user.additionalUserInfo}');
      // Dialogs.showProgressBar(context);
      if ((await APIs.userExists())) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => ChatPage()));
      } else {
        await APIs.createUser();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => ChatPage()));
      }
    });
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => ChatPage()));
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text,
          password: _controllerPassword.text,
          name: _controllerName.text);
      // Dialogs.showProgressBar(context);
      // if ((await APIs.userExists())) {
      //   Navigator.pushReplacement(
      //       context, MaterialPageRoute(builder: (_) => ChatPage()));
      // } else {
      await APIs.createUser().then((value) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => ChatPage()));
      });
      // }
      // final User? user = Auth().currentUser;
      // DatabaseService(uid: user!.uid).updateUserData();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ? $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'login' : 'register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }

  Widget _loginWithGoogle() {
    return InkWell(
      onTap: () => _handleGoogleBtnClick(),
      child: Container(
        height: 30,
        width: 30,
        decoration: BoxDecoration(
            image: const DecorationImage(
              image: NetworkImage(
                  'https://cdn-icons-png.flaticon.com/512/300/300221.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(microseconds: 1000));
  }

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _entryField('email', _controllerEmail),
            _entryField('password', _controllerPassword),
            // _entryField('name', _controllerName),
            _errorMessage(),
            _submitButton(),
            _loginOrRegisterButton(),
            _loginWithGoogle(),
          ],
        ),
      ),
    );
  }
}
