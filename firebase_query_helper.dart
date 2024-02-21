// import 'package:get_it/get_it.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// void setupLocator() {
//   final getIt = GetIt.instance;

//   getIt.registerSingleton<FirebaseFirestore>(FirebaseFirestore.instance);
//   getIt.registerSingleton<FirebaseHelper>(FirebaseHelper(getIt<FirebaseFirestore>()));
// }

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseHelper {
  final FirebaseFirestore _firestore;

  FirebaseHelper(this._firestore);

  // Get a single document from Firestore
  Future<DocumentSnapshot?> getDocument(
      String collectionPath, String documentId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection(collectionPath).doc(documentId).get();
      return snapshot;
    } catch (e) {
      print("Error getting document: $e");
      return null;
    }
  }

  // Get all documents in a collection from Firestore
  Future<List<DocumentSnapshot>> getAllDocuments(String collectionPath) async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collectionPath).get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error getting documents: $e");
      return [];
    }
  }

  // Get documents with pagination from Firestore
  Future<List<DocumentSnapshot>> getDocumentsWithPagination(
      String collectionPath, int limit, DocumentSnapshot? lastDocument) async {
    try {
      Query query = _firestore
          .collection(collectionPath)
          .orderBy("createdAt")
          .limit(limit);
      if (lastDocument != null) {
        query = query.startAfterDocument(lastDocument);
      }
      QuerySnapshot querySnapshot = await query.get();
      return querySnapshot.docs;
    } catch (e) {
      print("Error getting documents with pagination: $e");
      return [];
    }
  }

  // Add a new document to Firestore
  Future<void> addDocument(
      String collectionPath, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).add(data);
    } catch (e) {
      print("Error adding document: $e");
    }
  }

  // Update an existing document in Firestore
  Future<void> updateDocument(String collectionPath, String documentId,
      Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).update(data);
    } catch (e) {
      print("Error updating document: $e");
    }
  }

  // Delete a document from Firestore
  Future<void> deleteDocument(String collectionPath, String documentId) async {
    try {
      await _firestore.collection(collectionPath).doc(documentId).delete();
    } catch (e) {
      print("Error deleting document: $e");
    }
  }
}
