import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:uth_app/features/history/pages/view_qr_page.dart';
import 'package:uth_app/service/firestore_service.dart';
import 'package:uth_app/service/storage_service.dart';
import 'package:uth_app/shared/models/drug.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          Text(
              "Generated Drug Details",
            style: Theme.of(context).textTheme.headline5,
          ),
          SizedBox(height: 15,),
          ListOfQr()
        ],
      ),
    );
  }
}

class ListOfQr extends StatelessWidget {
  const ListOfQr({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: FirestoreService().getAllDrugsId(),
        builder: (context, AsyncSnapshot<List<String>> snapshot) {
           if(!snapshot.hasData){
             return CircularProgressIndicator();
           }else if(snapshot.hasError){
             return Text("Shot!! An Error Occurred!!");
           }

           var drugsId = snapshot.data;

           return GridView.builder(
              itemCount: drugsId?.length ?? 0,
               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                 crossAxisCount: 2,
               ),
               itemBuilder: (context, index){
                 var id = drugsId![index];
                 return GestureDetector(
                    onTap: ()=>Navigator.push(context, ViewQrPage.route(id)),
                    behavior: HitTestBehavior.translucent,
                    child: QrUI(drugId: id),
                 );
               }
           );
        },
      ),
    );
  }
}

class QrUI extends StatelessWidget {
  const QrUI({Key? key, required this.drugId}) : super(key: key);
  final String drugId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: StorageService().getFile(drugId),
          builder: (context, AsyncSnapshot<Uint8List> snapshot) {
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }else if(snapshot.hasError){
              return Text("Shot!! An Error Occurred!!");
            }

            return Image.memory(snapshot.data!);
          },
        ),
        FutureBuilder(
          future: FirestoreService().getDrugDetails(drugId),
          builder: (context, AsyncSnapshot<Drug> snapshot) {
            if(!snapshot.hasData){
              return CircularProgressIndicator();
            }else if(snapshot.hasError){
              return Text("Shot!! An Error Occurred!!");
            }

            return Text(snapshot.data!.drugName!);
          },

        )
      ],
    );
  }
}

