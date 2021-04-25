import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/src/providers/scan_list_provider.dart';
import 'package:qr_scanner/src/utils/utils.dart';


class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
    elevation: 0,
      child: Icon(Icons.filter_center_focus),
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#3D8BEF', 'Cancelar', false, ScanMode.QR);

        if(barcodeScanRes!='-1'){
          //print(barcodeScanRes);
          //Busca en el arbol de widgets nuestra instancia del provider
          final scanListProvider = Provider.of<ScanLIstProvider>(context, listen:false); //false: no queremos que se redibuje ahora mismo

          final scan = await scanListProvider.nuevoScan(barcodeScanRes);
          
          launchURL(context, scan);
          }
        }
      );
  }
}
