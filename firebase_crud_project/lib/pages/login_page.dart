import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_project/components/my_button.dart';
import 'package:firebase_crud_project/components/my_textfield.dart';
import 'package:firebase_crud_project/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // textcontrollers
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void login() async{

    // show loadling circle
    showDialog(context: context,
      builder: (context) => const Center(child: CircularProgressIndicator(),
    ),
    );

    //try sign in
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text);

      // pop loading circle
      if(context.mounted) Navigator.pop(context);

    } //display any errors
    on FirebaseAuthException catch(e){
      // pop loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.inversePrimary,
                size: 80,
              ),

              const SizedBox(height: 15,),

              // app name
              Text("M I N I M A L",style: TextStyle(fontSize: 20),),

              const SizedBox(height: 50,),

              //email textfield
              MyTextfield(hintText: "Email", obscureText: false, controller: emailController),

              const SizedBox(height: 15,),

              // password Textfield
              MyTextfield(hintText: "Password", obscureText: true, controller: passwordController),

              // forgot button
              Row(mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: () {

                  }, child: Text("Forgot Password?",
                    style: TextStyle(color: Theme.of(context).colorScheme.secondary)
                    ,)
                  ),
                ],
              ),

              const SizedBox(height: 15,),

              //sign in button
              MyButton(text: "Login",onTap: () {
                login();
              },
              ),

              const SizedBox(height: 16,),

              // dont have a account register here
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have a account?",
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),

                  const SizedBox(width: 10,),

                  GestureDetector(onTap: widget.onTap,
                      child: Text("Register Here", style: TextStyle(fontWeight: FontWeight.bold,),
                      )
                  ),
                ],
              )
            ],

          ),
        ),
      ),
    );
  }
}
