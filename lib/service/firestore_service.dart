
//This class serve as an interface with interacting with firestore
import 'package:uth_app/shared/models/drug.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  var db = FirebaseFirestore.instance;

  Future<String> saveDrug(Drug drug) async{
    var docSnapshot = await db.collection("drugs").add(drug.toJson());
    return docSnapshot.id;
  }

  Future<Drug> getDrugDetails(String id) async{
    var docRef = await db.collection("drugs")
        .doc(id)
        .get();
    return Drug.fromJson(docRef.data()!);
  }

  Future<List<String>> getAllDrugsId() async{
    var querySnapshot = await db.collection("drugs").get();

    return querySnapshot.docs.map((docSnapshot){
      return docSnapshot.id;
    }).toList();
  }
}