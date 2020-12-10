import 'package:flutter/material.dart';
import 'package:iFreeze/controllers/iFreeze.Comida.controller.dart';
import 'package:iFreeze/models/iFreeze.Comida.model.dart';
import 'package:provider/provider.dart';

class PageList extends StatefulWidget {
  int codigoGeladeira;
  PageList({this.codigoGeladeira});
  @override
  _PageListState createState() =>
      _PageListState(codigoGeladeira: codigoGeladeira);
}

class _PageListState extends State<PageList> {
  int codigoGeladeira;
  _PageListState({this.codigoGeladeira});
  @override
  Widget build(BuildContext context) {
    final ComidaController controller_comida =
        Provider.of<ComidaController>(context, listen: true);
    final List<Comida> lista_comida = controller_comida.lista_comida;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .015),
            child: Image.asset(
              'images/ifreeze2.png',
            ),
            width: MediaQuery.of(context).size.width * .5,
          ),
          backgroundColor: Colors.lightBlue.shade400,
        ),
        body: Scrollbar(
            child: ListView(
          children: [
            for (int i = 0; i < lista_comida.length; i++)
              if (lista_comida[i].codigoGeladeira == codigoGeladeira)
                Card(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Nome:'),
                              Text('${lista_comida[i].nome}'),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Validade:'),
                              Text('${lista_comida[i].validade}'),
                            ],
                          ),
                          IconButton(icon: Icon(Icons.keyboard_arrow_left), onPressed: (){
                            lista_comida[i].quantidade -= 1;
                                if (lista_comida[i].quantidade <= 0) {
                                  controller_comida.delete(
                                      lista_comida[i].id,
                                      lista_comida[i].codigoGeladeira);
                                } else {
                                  controller_comida.update(lista_comida[i],
                                      lista_comida[i].codigoGeladeira);
                                }
                          }),
                          CircleAvatar(backgroundColor: Colors.lightBlue.shade400,radius:MediaQuery.of(context).size.width * .04 ,child: Text('${lista_comida[i].quantidade}', style: TextStyle(color: Colors.white),)),
                          IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: (){
                            lista_comida[i].quantidade += 1;
                            controller_comida.update(lista_comida[i],
                                      lista_comida[i].codigoGeladeira);

                          }),
                        ]),
                  ),
                )
          ],
        )),
      );
  }
}
