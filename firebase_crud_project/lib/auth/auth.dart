import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_project/auth/register_or_login.dart';
import 'package:flutter/material.dart';

import '../pages/social_home_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  //Bu AuthPage adlı widget, Flutter'da kullanıcının oturum durumunu izleyen ve yöneten bir widgettır
  // bu widget main.dartta homedur

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
      // if user log in
      if(snapshot.hasData){
        return SocialHomePage();
      }
      // if user is NOT login
      else{
        return RegisterOrLogin();
      }
    },
    ),
    );
  }
}
