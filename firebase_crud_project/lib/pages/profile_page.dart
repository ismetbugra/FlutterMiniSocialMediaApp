import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_project/components/my_back_button.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
   ProfilePage({super.key});

  // get current user
  final User? currentUser= FirebaseAuth.instance.currentUser;

  // future to fetch user details
  Future<DocumentSnapshot<Map<String,dynamic>>> getUserDetails()async{
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: FutureBuilder(future: getUserDetails(), builder: (context, snapshot) {

        //loading
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }
        //error
        else if(snapshot.hasError){
          return  Center(child: Text("Error:${snapshot.error}"),);
        }
        // data received
        else if(snapshot.hasData){
          // extract data
          Map<String,dynamic>? user = snapshot.data!.data();

          return Center(
            child: Column(
              children: [

                //  custom back button
                const Padding(
                  padding: EdgeInsets.only(top: 50,left: 25),
                  child: Row(
                    children: [
                      MyBackButton(),
                    ],
                  ),
                ),

                // profile pic
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
                  color: Theme.of(context).colorScheme.primary),
                  padding: EdgeInsets.all(16),
                  child: Icon(Icons.person,
                    size: 64,),
                ),

                SizedBox(height: 25,),

                Text(user!["email"],
                  style: TextStyle(fontSize: 24,
                    fontWeight: FontWeight.bold),
                ),

                SizedBox(height: 10,),

                Text(user["username"],
                  style: TextStyle(fontSize: 18),),
              ],
            ),
          );

        }else{
          return const Center(
            child: Text("No Data!"),
          );
        }
      },
      ),
    );
  }
}
