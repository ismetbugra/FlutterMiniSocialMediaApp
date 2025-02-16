import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';





/*

This database store posts that users published from the app
It stores in a collection called 'Posts' in Firebase firestore

Each post contains --> a message / email of user / timestamp
 */



class PostsFirestore{
  //current logged user
  User? currentUser= FirebaseAuth.instance.currentUser;

  // get collection of posts form firestore
  final CollectionReference posts = FirebaseFirestore.instance.collection("Posts");

  //post a message
  Future<void> addPost(String message){
    return posts.add({
      'UserEmail' : currentUser!.email,
      'PostMessage' : message,
      'TimeStamp' : Timestamp.now()
    });

  }

  //read fromd database
  Stream<QuerySnapshot> getPostStream(){
    final postsStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy('TimeStamp',descending: true)
        .snapshots();

    return postsStream;
  }





}