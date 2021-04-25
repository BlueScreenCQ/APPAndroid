import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/src/pages/mapas_page.dart';
import 'package:qr_scanner/src/providers/scan_list_provider.dart';
import 'package:qr_scanner/src/providers/ui_provider.dart';
import 'package:qr_scanner/src/widgets/custom_navigatorrbar.dart';
import 'package:qr_scanner/src/widgets/scan_buttom.dart';

import 'direcciones.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
          icon: Icon(Icons.delete_forever),
          onPressed: (){
            //Usar el ScanListProvider
            final scanListProvider = Provider.of<ScanLIstProvider>(context, listen: false);

            scanListProvider.borrarTodos();
          })
        ],
      ),
      body: _HomePageBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    //Obtener el selected menu opt
    final iuProvider = Provider.of<UIProvider>(context);

    //Muestra una pantalla u otra dependiendo de la opción seleccionada
    final currentIdex = iuProvider.selectedMenuOpt;

    //Usar el ScanListProvider
    final scanListProvider = Provider.of<ScanLIstProvider>(context, listen: false);

    switch(currentIdex){
      case 0:
        scanListProvider.cargarScansPorTipo('geo');
        return MapasPage();
        break;

      case 1:
        scanListProvider.cargarScansPorTipo('http');
        return DireccionesPage();
        break;

      default:
        return MapasPage();
    }
  }
}

