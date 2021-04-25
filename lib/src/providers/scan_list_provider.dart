import 'package:flutter/material.dart';
import 'package:qr_scanner/src/models/scan_model.dart';
import 'package:qr_scanner/src/providers/db_provider.dart';

class ScanLIstProvider extends ChangeNotifier {

  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan(String valor) async {

    final nuevoScan = new ScanModel(valor: valor);
    final id = await DBProvider.db.nuevoScan(nuevoScan);

    //asigna el id de la bd al modelo
    nuevoScan.id=id;

    if (this.tipoSeleccionado == nuevoScan.tipo) {
      this.scans.add(nuevoScan);
      notifyListeners();
    }
    return nuevoScan;
  }

  void cargarScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans]; //rellena la lista con los valores
    notifyListeners();
  }

  void cargarScansPorTipo(String tipo) async {
    final scans = await DBProvider.db.getScanByTipo(tipo);
    this.scans = [...scans]; //rellena la lista con los valores
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  void borrarTodos() async {
    await DBProvider.db.deleteAllScans();
    this.scans = [];
    notifyListeners();
  }

  void borrarScanPorId(int id) async {
    await DBProvider.db.deleteScan(id);
  }
}