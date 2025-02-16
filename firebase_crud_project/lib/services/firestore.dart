import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{

  // get collection of notes
  final CollectionReference notes= FirebaseFirestore.instance.collection("notes");

  // create add a new note
  Future<void> addNote(String note){
    final addNote = <String,dynamic>{
      "note": note,
      "timestamp": Timestamp.now(),
    };
    return notes.add(addNote);
  }

  //read
  Stream<QuerySnapshot> getNotesStream(){

    final noteStream = notes.orderBy("timestamp",descending: true).snapshots();
    return noteStream;
  }

  //UPDATE note
  Future<void> updateNote(String docID, String newNote){
    return notes.doc(docID).update({
      "note": newNote,
      "timestamp": Timestamp.now()
    });
  }

  // DELETE note
  Future<void> deleteNote(String docID){
    return notes.doc(docID).delete();
  }

}