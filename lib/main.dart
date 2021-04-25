import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/src/pages/home_page.dart';
import 'package:qr_scanner/src/pages/map_page.dart';
import 'package:qr_scanner/src/providers/scan_list_provider.dart';
import 'package:qr_scanner/src/providers/ui_provider.dart';

void main() => runApp(QRscanner());

class QRscanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => new UIProvider()),
        ChangeNotifierProvider(create: (_) => new ScanLIstProvider())
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Scanner',
        initialRoute: 'home',
        routes: {
          'home' : (_) => HomePage(),
          'mapa'  : (_) => MapPage()
        },
        theme: ThemeData(
          primaryColor: Colors.redAccent,
          floatingActionButtonTheme:FloatingActionButtonThemeData(
            backgroundColor: Colors.redAccent
          )
        ),
      ),
    );
  }
}
