import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uth_app/service/firestore_service.dart';
import 'package:uth_app/service/storage_service.dart';
import 'package:uth_app/shared/models/drug.dart';

import '../widgets/drug_desc.dart';

class ViewQrPage extends StatelessWidget {
  static MaterialPageRoute route(String id) => MaterialPageRoute(builder: (context)=>ViewQrPage(id: id,));

  const ViewQrPage({Key? key, required this.id}) : super(key: key);
  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        foregroundColor: Theme.of(context).primaryColorDark,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder(
          future: StorageService().getFile(id),
          builder: (context, snapshot){
            if(!snapshot.hasData){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }else if(snapshot.hasError){
              return const Center(
                child: Text("An Error occurred!"),
              );
            }
            var file = snapshot.data as Uint8List;

            return Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Image.memory(
                      file,
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.8,
                    scale: 0.2,
                  ),
                  Center(
                    child: FutureBuilder(
                        future: FirestoreService().getDrugDetails(id),
                        builder: (context, snapshot){
                          if(!snapshot.hasData){
                            return CircularProgressIndicator();
                          }else if(snapshot.hasError){
                            return Text("An Error Occurred");
                          }
                          var drug = snapshot.data as Drug;
                          return Column(
                            children: [
                              DrugDesc(
                                  title: "Name",
                                  desc: drug.drugName ?? ""
                              ),
                              DrugDesc(
                                  title: "Batch No.",
                                  desc: drug.batchNumber ?? ""
                              ),
                              DrugDesc(
                                  title: "Manufacture Date",
                                  desc: DateFormat('MMM dd y').format(drug.manufacturingDate)
                              ),
                              DrugDesc(
                                  title: "Expiry Date",
                                  desc: DateFormat('MMM dd y').format(drug.manufacturingDate)
                              ),
                              DrugDesc(
                                  title: "Dosage",
                                  desc: drug.dosage ?? ""
                              ),
                              DrugDesc(
                                  title: "Storage Condition",
                                  desc: drug.storingCondition ?? ""
                              )
                            ],
                          );
                        }
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
