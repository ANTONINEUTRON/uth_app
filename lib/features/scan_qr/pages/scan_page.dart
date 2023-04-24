import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:uth_app/features/history/pages/view_qr_page.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              onQRViewCreated: _onQRViewCreated,
              key: qrKey,
            ),
          ),
          Center(
            child: IconButton(
              icon: const Icon(Icons.qr_code_scanner, size: 35,),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Center(child: Text("Scanned Successfully..."))
                  )
                );
                if(result != null){
                  Navigator.push(context, ViewQrPage.route(result!.code ?? ""));
                }
              },
              color: Colors.blue.shade900,
            )
            // child: (result != null)
            //     ? Text(
            //     'Barcode Type: ${result!.format}   Data: ${result!.code}')
            //     : Text('Scan a code'),
          )
        ],
      ),
    );
  }

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
