import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scanner/src/providers/scan_list_provider.dart';
import 'package:qr_scanner/src/utils/utils.dart';

class ScanTiles extends StatelessWidget {

  final String tipo;

  const ScanTiles({ @required this.tipo});


  @override
  Widget build(BuildContext context) {

    //Busca en el arbol de widgets nuestra instancia del provider. Dentro de un build se suele poner el listen en true(por defecto)
    final scanListProvider = Provider.of<ScanLIstProvider>(context); //true: no queremos que se redibuje ahora mismo
    final scans = scanListProvider.scans;

    return ListView.builder(
        itemCount: scans.length,
        itemBuilder: ( _, i ) => Dismissible( //Permite el swipe
          key: UniqueKey(), //Hace falta un key, pero a nosotros no nos importa cual
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (DismissDirection direction) {
            Provider.of<ScanLIstProvider>(context, listen: false).borrarScanPorId(scans[i].id);
          },
          child: ListTile(
            leading: Icon(
              this.tipo=='http'
                ? Icons.home_outlined
                : Icons.map_outlined,
                color: Theme.of(context).primaryColor),
            title: Text(scans[i].valor),
            subtitle: Text(scans[i].id.toString()),
            trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
            onTap: () => launchURL(context, scans[i]),
          ),
        )
    );
  }
}
