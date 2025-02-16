import 'package:firebase_crud_project/auth/auth.dart';
import 'package:firebase_crud_project/auth/register_or_login.dart';
import 'package:firebase_crud_project/pages/home_page.dart';
import 'package:firebase_crud_project/pages/login_page.dart';
import 'package:firebase_crud_project/pages/profile_page.dart';
import 'package:firebase_crud_project/pages/register_page.dart';
import 'package:firebase_crud_project/pages/social_home_page.dart';
import 'package:firebase_crud_project/pages/users_page.dart';
import 'package:firebase_crud_project/theme/light_mode.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'theme/dark_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/register_or_login_page': (context)=> RegisterOrLogin(),
        '/social_home_page' : (context)=> SocialHomePage(),
        '/profile_page' : (context)=> ProfilePage(),
        '/users_page' : (context)=> UsersPage(),
      },
    );
  }
}

