import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hypermarket_user/core/constants/color.dart';
import 'package:hypermarket_user/presentation/product_details_screen/view/product_details_screen.dart';
import 'package:hypermarket_user/presentation/scanner_screen/controller/scanned_product_details_controller.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  String code = '';
  QRViewController? controller;
  bool isLoading = false;

  void _onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      if (!isLoading) {
        setState(() {
          isLoading = true;
          result = scanData;
          code = result?.code ?? "";
          print("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%$code");
        });
        await _navigateToDetailsScreen(result: code);
      }
    });
  }

//
  _navigateToDetailsScreen({required String result}) async {
    await Provider.of<scanedDetailsScreenController>(context, listen: false)
        .getProductDetailsScreenList(id: result);
    if (isLoading) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsScreen(
            id: result,
          ),
        ),
      );
      isLoading = false; // Move isLoading assignment here
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    "https://i.pinimg.com/736x/8c/98/99/8c98994518b575bfd8c949e91d20548b.jpg"),
                fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1, sigmaY: 2),
          child: Container(
            // color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.5),
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Scan your Code",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: ColorConstant.mainBlack),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Container(
                          height: 300,
                          width: MediaQuery.sizeOf(context).width * .90,
                          child: QRView(
                            key: qrKey,
                            onQRViewCreated: _onQRViewCreated,
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ));
  }
}
