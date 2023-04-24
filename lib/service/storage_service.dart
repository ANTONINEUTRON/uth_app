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

  Future<Uint8List> getFile(String id) async{
    final ref = storageRef.child("qr/$id");

    try {
      const oneMegabyte = 1024 * 1024;
      final Uint8List? data = await ref.getData(oneMegabyte);

      if(data != null) return data;
    }catch (e){
      // Handle any errors.
      if (kDebugMode) {
        print(e);
      }
    }
    return Uint8List.fromList([]);
    // return File("");
  }
}