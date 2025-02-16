import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_project/components/my_back_button.dart';
import 'package:firebase_crud_project/helper/helper_functions.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            // any errors
            if(snapshot.hasError){
              displayMessageToUser("Something went wrong", context);
            }

            // loading circle
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }

            // get all users
            final users= snapshot.data!.docs;

            return Column(
              children: [

                //  custom back button
                const Padding(
                  padding: EdgeInsets.only(top: 50,left: 25),
                  child: Row(
                    children: [
                      MyBackButton(),
                      SizedBox(width: 16,),
                      Text("Users of W A L L",style: TextStyle(fontSize: 16),)
                    ],
                  ),
                ),

                Expanded(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                    //get individual user
                    final user=users[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Theme.of(context).colorScheme.primary),
                        child: ListTile(
                          title: Text(user['username']),
                          subtitle: Text(user['email']),
                        ),
                      ),
                    );

                  },
                  ),
                ),
              ],
            );

          },
      ),
    );
  }
}
