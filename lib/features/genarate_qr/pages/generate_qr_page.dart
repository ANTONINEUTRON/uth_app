import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uth_app/features/history/pages/view_qr_page.dart';
import 'package:uth_app/service/firestore_service.dart';
import 'package:uth_app/service/storage_service.dart';
import 'package:uth_app/shared/models/drug.dart';
import 'package:barcode_image/barcode_image.dart';
import 'package:image/image.dart' as Imaage;
import 'dart:io';


import '../../../shared/widgets/error_text_widget.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({Key? key}) : super(key: key);

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  String? drugName;
  DateTime? expiryDate = DateTime.now();
  DateTime? manufacturingDate = DateTime.now();
  String? batchNumber;
  String? dosage;
  String? storingCondition;
  String _errorMsg = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, left:8, right:8,
        bottom: getBottomPaddingForKeyboardToShow(
            MediaQuery.of(context).viewInsets.bottom)),
      child: ListView(
        children: [
          Text(
              "Generate QR Code",
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: 10,),
          ErrorTextWidget(errorMsg: _errorMsg),
          const SizedBox(height: 10,),
          TextField(
            onChanged: (value)=>setState(() {
              drugName = value;
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Drug Name"
            ),
          ),
          const SizedBox(height: 5,),
          TextField(
            onChanged: (value)=>setState(() {
              batchNumber = value;
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Batch Number"
            ),
          ),
          const SizedBox(height: 5,),
          TextField(
            onChanged: (value)=>setState(() {
              dosage = value;
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Dosage"
            ),
          ),
          const SizedBox(height: 5,),
          TextField(
            onChanged: (value)=>setState(() {
              storingCondition = value;
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Storing Conditions"
            ),
          ),
          const SizedBox(height: 10,),
          Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    color: Colors.white70,
                    onPressed: (){
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2010),
                          lastDate: DateTime(2100)
                      ).then((value){
                        setState((){
                          manufacturingDate = value ?? DateTime.now();
                        });
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                            manufacturingDate == null
                                ? "Manufacture Date"
                                : DateFormat('MMM dd y').format(manufacturingDate  ?? DateTime.now())
                        ),
                        manufacturingDate == null
                            ? Icon(Icons.calendar_today)
                            : Icon(Icons.edit)
                      ],
                    ),
                  ),
                  MaterialButton(
                    color: Colors.white70,
                    onPressed: (){
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2010),
                          lastDate: DateTime(2100)
                      ).then((value){
                        setState((){
                          expiryDate = value ?? DateTime.now();
                        });
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                            expiryDate == null
                                ? "Expiry Date"
                                : DateFormat('MMM dd y').format(expiryDate!)
                        ),
                        expiryDate == null
                            ? Icon(Icons.calendar_today)
                            : Icon(Icons.edit)
                      ],
                    ),
                  ),
                ],
              ),
          ),
          ElevatedButton(
              onPressed: (){
                //generate and save qr code
                //validate input
                if(inputsAreValid()) {
                  FirestoreService()
                      .saveDrug(
                        Drug(
                          drugName: drugName,
                          expiryDate: expiryDate ?? DateTime.now(),
                          manufacturingDate: manufacturingDate  ?? DateTime.now(),
                          batchNumber: batchNumber,
                          dosage: dosage,
                          storingCondition: storingCondition
                        )
                      ).then(
                          (docId){
                            //Generate QR code from ID
                            final image = Imaage.Image(300,120);
                            Imaage.fill(image, Imaage.getColor(255, 255, 255));
                            drawBarcode(image, Barcode.qrCode(), docId, font: Imaage.arial_24);
                            // Save the image
                            getApplicationDocumentsDirectory()
                                .then((appDocDir){
                                    File qrCodeFile = File('${appDocDir.path}/barcode.png');
                                    print("FILE PATH IS "+qrCodeFile.path);
                                    qrCodeFile.writeAsBytesSync(Imaage.encodePng(image));
                                    print("FIle is filed");
                                    StorageService()
                                        .saveFile(qrCodeFile, docId)
                                        .then((hasFileUpload) {
                                      if(hasFileUpload){
                                        //take user to next page
                                        alert(context, "Everything worked");
                                        Navigator.push(context, ViewQrPage.route);
                                      }else{
                                        alert(context, "An Error occured while generating the QR Code");
                                      }
                                    });
                                });

                          },onError: (e){
                              alert(context, "An Error Occured\n${e.message}");
                          }
                      );
                  //create object
                  //save object to firebase
                }
              },
              child: Text("Generate QR Code")
          )
        ],
      ),
    );
  }

  void alert(BuildContext context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }

  bool inputsAreValid() {
    if(drugName?.isEmpty ?? true){
      return showError("Drug Name can not be left blank");
    }else if(batchNumber?.isEmpty ?? true){
      return showError("Batch Number cannot be Empty");
    }else if(dosage?.isEmpty ?? true) {
      return showError("Batch Number cannot be Empty");
    }else if(storingCondition?.isEmpty ?? true){
      storingCondition = "";
    }
    return true;
  }

  bool showError(String msg) {
    setState(() {
      _errorMsg = msg;
    });
    return false;
  }

  double getBottomPaddingForKeyboardToShow(double bottomPadding)
    => bottomPadding > 50 ? bottomPadding - 50 : bottomPadding;
}
