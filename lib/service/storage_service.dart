import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class StorageService{
  final storageRef = FirebaseStorage.instance.ref();

  Future<bool> saveFile(File file, String id) async{
    final ref = storageRef.child("qr/$id");

    try{
      await ref.putFile(file);
    }catch(e){
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    return true;
  }
}