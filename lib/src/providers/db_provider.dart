import 'package:qr_scanner/src/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
export 'package:path_provider/path_provider.dart';


class DBProvider {

  static Database _database;

  //Constructor privado. Patrón Singleton
  static final DBProvider db = DBProvider._();
  DBProvider._();

  Future<Database> get database async {
    if ( _database != null) return _database;

     _database =  await initDB();

     return _database;
  }

  Future<Database> initDB() async {

    //Path donde alamacenamos la bd
    Directory ducumentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(ducumentsDirectory.path, 'ScansDB.db');

    print(path);

    //Crea la base de datos
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {

        // El triple ''' es de Dart, significa String multilinea
        await db.execute('''
        CREATE TABLE Scans(
        id INTEGER PRIMARY KEY,
        tipo TEXT,
        valor TEXT
        )
        ''');
      }
    );
  }

  Future<int> nuevoScanRaw(ScanModel scan) async {

    final id = scan.id;
    final tipo = scan.tipo;
    final valor = scan.valor;

    //verifica la DB
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans (id, tipo, valor)
        VALUES( '$id', '$tipo', '$valor')
    ''');

    return res;
  }

  Future<int> nuevoScan(ScanModel nuevoScan) async {

    final db = await database;
    final res =await db.insert('Scans', nuevoScan.toJson());

    return res;
  }

  Future<ScanModel> getScanById(int id) async {

    final db = await database;
    final res =await db.query('Scans', where: 'id = ?',whereArgs: [id]);

    return res.isNotEmpty
        ? ScanModel.fromJson(res.first)
        : null;
  }

  Future<List<ScanModel>> getAllScans() async {

    final db = await database;
    final res =await db.query('Scans');

    return res.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ScanModel>> getScanByTipo(String tipo) async {

    final db = await database;
    final res =await db.query('Scans', where: 'tipo = ?',whereArgs: [tipo]);

    return res.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<int> updateScan(ScanModel scan) async{

    final db = await database;
    final res = await db.update('Scans', scan.toJson(), where: 'id= ?', whereArgs: [scan.id]);
    return res;
  }

  Future<int> deleteScan(int id) async{

    final db = await database;
    final res = await db.delete('Scans', where: 'id= ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScans() async{

    final db = await database;
    final res = await db.rawDelete('''
    DELETE FROM Scans
    ''');
    return res;
  }
}