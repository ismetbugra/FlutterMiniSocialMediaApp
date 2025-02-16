import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_crud_project/services/firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //firestore
  final FirestoreService firestoreService = FirestoreService();

  // text controller
  final TextEditingController textController= TextEditingController();

  void openNoteBox({String? docID}){
    showDialog(context: context, builder: (context) => AlertDialog(
      content: TextField(
        controller: textController,
      ),
      actions: [
        // button to save
        ElevatedButton(onPressed: () {

          if(docID==null){
            // add note to firestore
            firestoreService.addNote(textController.text);


          }else{
            // update note
            firestoreService.updateNote(docID, textController.text);
          }

          // clear the textcontroller
          textController.clear();

          // close the box
          Navigator.pop(context);

        }, child: Text("Add"))
      ],


    ),);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Note App"),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        openNoteBox();

      },
      child: Icon(Icons.add),
      ),

      body: StreamBuilder<QuerySnapshot>(stream: firestoreService.getNotesStream(),
          builder: (context, snapshot) {

            // if we have data, get all docs
            if(snapshot.hasData){
              List noteList=snapshot.data!.docs;

              // display as a list
              return ListView.builder(itemCount: noteList.length,itemBuilder: (context, index) {

                //get each individual doc
                DocumentSnapshot document = noteList[index];
                String docID=document.id;

                //get note from each doc
                Map<String,dynamic> data = document.data() as Map<String,dynamic>;
                String noteText= data["note"];

                // display as a card etc.
                return ListTile(title: Text(noteText),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      //update button
                      IconButton(onPressed: () => openNoteBox(docID: docID),
                          icon: Icon(Icons.settings)
                      ),

                      //delete button
                      IconButton(onPressed: () => firestoreService.deleteNote(docID),
                          icon: Icon(Icons.delete)
                      ),
                    ],
                  )
                );

              },
              );
            }else{
              return Text("No notes...");
            }
          },),
    );
  }
}
