import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_project/components/my_button.dart';
import 'package:firebase_crud_project/components/my_textfield.dart';
import 'package:firebase_crud_project/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // textcontrollers
  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPwdController = TextEditingController();

  // register user method
  void registerUser() async{
    // show loading circle
    showDialog(context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()
      ),
    );

    // make sure password matching
    if(passwordController.text != confirmPwdController.text){
      //pop loading circle
      Navigator.pop(context);

      // show error message to user
      displayMessageToUser("Passwords don't match", context);

    }
    else{ // if passwords match
      // try create user
      try{

        // kullanıcı auth kaydı olusturma
        UserCredential? userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email:emailController.text, password: passwordController.text);

        //create a user document and add to firebase
        createUserDocument(userCredential);

        //pop loading circle
        if(context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch(e){
        Navigator.pop(context);

        // show error message
        displayMessageToUser(e.code, context);

      }
    }

  }

  Future<void> createUserDocument(UserCredential? userCredential) async{
    if(userCredential != null && userCredential.user != null){
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email' : userCredential.user!.email,
        'username' : userNameController.text
      });

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

              //username textfield
              MyTextfield(hintText: "Username", obscureText: false, controller: userNameController),

              const SizedBox(height: 15,),

              //email textfield
              MyTextfield(hintText: "Email", obscureText: false, controller: emailController),

              const SizedBox(height: 15,),

              // password Textfield
              MyTextfield(hintText: "Password", obscureText: true, controller: passwordController),

              const SizedBox(height: 15,),

              //confirm password textfield
              MyTextfield(hintText: "Confirm Password", obscureText: true, controller: confirmPwdController),

              const SizedBox(height: 15,),

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

              //register button
              MyButton(text: "Register",onTap: () {
                registerUser();
              },
              ),

              const SizedBox(height: 16,),

              // dont have a account register here
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Do you have a account?",
                    style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
                  ),

                  const SizedBox(width: 10,),

                  GestureDetector(onTap: widget.onTap,
                      child: Text("Login Here", style: TextStyle(fontWeight: FontWeight.bold,),
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

