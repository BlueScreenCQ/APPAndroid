import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/src/providers/ui_provider.dart';

class CustomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Obtener el selected menu opt
    final iuProvider = Provider.of<UIProvider>(context);

    final currentIndex =  iuProvider.selectedMenuOpt;

    return BottomNavigationBar(
      onTap: (int i ) => iuProvider.selectedMenuOpt = i, //pasa la info al provider
      elevation: 0,
        currentIndex: currentIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon (Icons.map),
              label: 'Mapa'
          ),
          BottomNavigationBarItem(
              icon: Icon (Icons.compass_calibration),
              label: 'Direcciones'
          ),
        ]
    );
  }
}
