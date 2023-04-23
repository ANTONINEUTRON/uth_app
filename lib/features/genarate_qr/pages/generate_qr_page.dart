import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({Key? key}) : super(key: key);

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  String? drugName;
  DateTime expiryDate = DateTime.now();
  DateTime manufacturingDate = DateTime.now();
  String? batchNumber;
  String? dosage;
  String? storingCondition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left:8, right:8),
      child: ListView(
        children: [
          Text(
              "Generate QR Code",
            style: Theme.of(context).textTheme.headline5,
          ),
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
          // TextField(
          //   onChanged: (value)=>setState(() {
          //     expiryDate = value;
          //   }),
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(),
          //     labelText: "Expiry Date"
          //   ),
          // ),
          // const SizedBox(height: 5,),
          // TextField(
          //   onChanged: (value)=>setState(() {
          //     manufacturingDate = value;
          //   }),
          //   decoration: InputDecoration(
          //     border: OutlineInputBorder(),
          //     labelText: "Manufacture Date"
          //   ),
          // ),
          // const SizedBox(height: 5,),
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
                          firstDate: DateTime.now(),
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
                            manufacturingDate.isBefore(DateTime.now())
                                ? "Manufacture Date"
                                : DateFormat('E, MMM dd y').format(manufacturingDate)
                        ),
                        manufacturingDate.isBefore(DateTime.now())
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
                          firstDate: DateTime.now(),
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
                            expiryDate.isBefore(DateTime.now())
                                ? "Expiry Date"
                                : DateFormat('E, MMM dd y').format(expiryDate)
                        ),
                        expiryDate.isBefore(DateTime.now())
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
              },
              child: Text("Generate QR Code")
          )
        ],
      ),
    );
  }
}
