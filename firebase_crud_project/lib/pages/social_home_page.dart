import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crud_project/components/my_drawer.dart';
import 'package:firebase_crud_project/components/my_post_button.dart';
import 'package:firebase_crud_project/components/my_textfield.dart';
import 'package:firebase_crud_project/database/posts_firestrore.dart';
import 'package:flutter/material.dart';

class SocialHomePage extends StatelessWidget {
  SocialHomePage({super.key});

  // text controller
  final TextEditingController newPostController = TextEditingController();

  //firestore access
  final PostsFirestore database= PostsFirestore();

  //post func
  void postMessage(){
    // post a message if there is something in the textfield
    if(newPostController.text.isNotEmpty){
      String message = newPostController.text;
      database.addPost(message);

      //clear textfield
      newPostController.clear();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("W A L L"),
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [

          // textfield space to users type
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextfield(
                      hintText: "Say something...",
                      obscureText: false,
                      controller: newPostController),
                ),

                // post button
                MyPostButton(onTap: postMessage,),
              ],
            ),
          ),
          

          // Posts
          StreamBuilder(stream: database.getPostStream(),
            builder: (context, snapshot) {
            // show laoding circle
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              // get all posts
              final posts= snapshot.data!.docs;

              // no data controls
              if(snapshot.data==null || posts.isEmpty){
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text("No Data!"),
                  ),
                );

              }

              //return as a list
              return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      // get each posts
                      final post= posts[index];

                      //get data from each post
                      String message= post['PostMessage'];
                      String userEmail = post['UserEmail'];
                      Timestamp timeStamp= post['TimeStamp'];

                      //return as a list tile
                      return Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Theme.of(context).colorScheme.primary),
                          child: ListTile(
                            title: Text(message),
                            subtitle: Text(userEmail,
                              style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                            ),
                          
                          ),
                        ),
                      );


              },
                  )
              );

          },
          )
        ],
      ),
    );
  }
}
