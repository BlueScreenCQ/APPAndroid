import 'package:flutter/material.dart';

class UIProvider extends ChangeNotifier {
  int _selectedMenuOpt =0;

  int get selectedMenuOpt{
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int i){
    this._selectedMenuOpt=i;
    notifyListeners();  //Notifica a las clases que esa propiedad ha cambiado
  }

}