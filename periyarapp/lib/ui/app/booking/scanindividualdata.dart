import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

// class ScanIndividualData extends StatelessWidget {
//   const ScanIndividualData({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//

//   }
// }

class ScanIndividualData extends StatefulWidget {
  const ScanIndividualData({Key? key}) : super(key: key);

  @override
  State<ScanIndividualData> createState() => _ScanIndividualDataState();
}

class _ScanIndividualDataState extends State<ScanIndividualData> {
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: new AppBar(
          title: new Text('Scan QR Code'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 40,
                height: 40,
                child: CircleAvatar(
                  radius: 30.0,
                  backgroundImage: AssetImage(
                    "assets/bgptrr.png",
                  ),
                  backgroundColor: Colors.transparent,
                ),
              ),
            ),
          ],
        ),
        body: Center(
          child: SizedBox(
            width: 600,
            height: 1200,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 35,
                overlayColor: HexColor("#1F1F1F"),
                borderLength: 40,
                borderWidth: 10,
              ),
            ),
          ),
        ));
  }

  void _onQRViewCreated(QRViewController p1) {}
}
