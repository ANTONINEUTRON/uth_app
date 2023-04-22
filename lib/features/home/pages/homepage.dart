import 'package:flutter/material.dart';
import 'package:uth_app/features/genarate_qr/pages/generate_qr_page.dart';

import '../../history/pages/history_page.dart';
import '../../scan_qr/pages/scan_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index = 1;
  var pages = <Widget>[
    ScanPage(),
    GenerateQRPage(),
    HistoryPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:pages[_index] ,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (index)=>setState(() {
          _index = index;
        }),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner_outlined),
              label: "Scan"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.medication_rounded),
              label: "Generate QR"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: "History"
          )
        ],
      ),
    );
  }
}
