import 'package:flutter/material.dart';

class GenerateQRPage extends StatefulWidget {
  const GenerateQRPage({Key? key}) : super(key: key);

  @override
  State<GenerateQRPage> createState() => _GenerateQRPageState();
}

class _GenerateQRPageState extends State<GenerateQRPage> {
  String? drugName;
  String? expiryDate;
  String? manufacturingDate;
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
          TextField(
            onChanged: (value)=>setState(() {
              expiryDate = value;
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Expiry Date"
            ),
          ),
          const SizedBox(height: 5,),
          TextField(
            onChanged: (value)=>setState(() {
              manufacturingDate = value;
            }),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Manufacture Date"
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
