import 'package:flutter/material.dart';
import 'package:uth_app/scan_page.dart';

import 'history_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: const [
            ScanPage(),
            HistoryPage()
          ]
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _counter,
        onTap: (index)=>_counter = index,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.document_scanner_outlined),
              label: "Scan"
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
