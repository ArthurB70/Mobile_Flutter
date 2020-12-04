import 'package:flutter/material.dart';
import 'package:iFreeze/controllers/iFreeze.Geladeira.controller.dart';
import 'package:iFreeze/models/iFreeze.Comida.model.dart';
import 'package:iFreeze/models/iFreeze.Geladeira.model.dart';
import 'package:provider/provider.dart';
import 'package:iFreeze/controllers/iFreeze.Comida.controller.dart';
import 'iFreeze.ListPage.view.dart';
import 'package:iFreeze/views/iFreeze.CadastroPage.view.dart';
import 'package:iFreeze/views/iFreeze.EditarPage.view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int i = 0;
  bool retornoRemover = false;
  final _formKey = GlobalKey<FormState>();
  Geladeira _geladeira = new Geladeira(nome: 'Default', status: false);
  List<Geladeira> lista_geladeira = List<Geladeira>();
  double temperatura = 10.5;
  @override
  Widget build(BuildContext context) {
    final GeladeiraController controller_geladeira =
        Provider.of<GeladeiraController>(context, listen: true);
    lista_geladeira = controller_geladeira.lista_geladeira;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * .015),
            child: Image.asset(
              'images/ifreeze2.png',
            ),
            width: MediaQuery.of(context).size.width * .5,
          ),
          backgroundColor: Colors.lightBlue.shade400,
        ),
        body: Align(
          alignment: Alignment.center,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: IconButton(
                      iconSize: MediaQuery.of(context).size.width * .15,
                      icon: Icon(
                        Icons.keyboard_arrow_left,
                        color: (i > 0 ? Colors.black87 : Colors.grey),
                      ),
                      onPressed: () {
                        setState(() {
                          if (i > 0) {
                            i -= 1;
                          }
                          if (!lista_geladeira.isEmpty) {
                            _geladeira = lista_geladeira[i];
                          }
                        });
                      }),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: lista_geladeira.isEmpty
                          ? Colors.grey
                          : lista_geladeira[i].status
                              ? Colors.greenAccent.shade700
                              : Colors.redAccent.shade700),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * .03,
                            left: MediaQuery.of(context).size.width * .03,
                            right: MediaQuery.of(context).size.width * .03,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                lista_geladeira.isEmpty
                                    ? 'Adicione uma geladeira'
                                    : '${lista_geladeira[i].nome}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            .04),
                              ),
                              Text(
                                lista_geladeira.isEmpty
                                    ? 'null'
                                    : '${lista_geladeira[i].codigoGeladeira}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            .04),
                              )
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * .03,
                            left: MediaQuery.of(context).size.width * .03,
                            right: MediaQuery.of(context).size.width * .03,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'Temperatura:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            .04),
                              ),
                              CircleAvatar(
                                radius: MediaQuery.of(context).size.width *
                                            .08,
                                backgroundColor: Colors.lightBlue.shade400,
                                child: Text(
                                  lista_geladeira.isEmpty
                                      ? 'null'
                                      : '$temperatura °C',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              .04),
                                ),
                              )
                            ],
                          )),
                      Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * .03,
                            left: MediaQuery.of(context).size.width * .03,
                            right: MediaQuery.of(context).size.width * .03,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              IconButton(
                                  iconSize:
                                      MediaQuery.of(context).size.width * .09,
                                  icon: Icon(
                                    Icons.add,
                                    color: Colors.black,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CadastroPage()));
                                  }),
                              IconButton(
                                  iconSize:
                                      MediaQuery.of(context).size.width * .07,
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.deepOrange,
                                  ),
                                  onPressed: () {
                                    if (!lista_geladeira.isEmpty)
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => EditarPage(
                                                    geladeira:
                                                        lista_geladeira[i],
                                                  )));
                                  }),
                              IconButton(
                                  iconSize:
                                      MediaQuery.of(context).size.width * .07,
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    if (!lista_geladeira.isEmpty)
                                      _popUpRemoverGeladeira(
                                          context,
                                          controller_geladeira,
                                          lista_geladeira[i].codigoGeladeira);
                                  })
                            ],
                          )),
                    ],
                  ),
                ),
                Container(
                  child: IconButton(
                      iconSize: MediaQuery.of(context).size.width * .15,
                      icon: Icon(
                        Icons.keyboard_arrow_right,
                        color: (i <= lista_geladeira.length - 2
                            ? Colors.black87
                            : Colors.grey),
                      ),
                      onPressed: () {
                        setState(() {
                          if (i < lista_geladeira.length - 1) {
                            i += 1;
                          }
                          if (!lista_geladeira.isEmpty) {
                            _geladeira = lista_geladeira[i];
                          }
                        });
                      }),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.grey.shade200,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(left: 30, top: 7.5, right: 30, bottom: 7.5),
                child: CircleAvatar(
                  backgroundColor: Colors.lightBlue.shade400,
                  child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.qr_code_scanner),
                      onPressed: () {}),
                ),
              ),
              Container(
                padding:
                    EdgeInsets.only(left: 30, top: 7.5, right: 30, bottom: 7.5),
                child: CircleAvatar(
                  backgroundColor: Colors.lightBlue.shade400,
                  child: IconButton(
                      color: Colors.white,
                      icon: Icon(Icons.list),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageList(
                                      codigoGeladeira:
                                          _geladeira.codigoGeladeira,
                                    )));
                      }),
                ),
              ),
            ],
          ),
        ));
  }

  _popUpRemoverGeladeira(context, GeladeiraController controller_geladeira,
      int codigoGeladeira) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: MediaQuery.of(context).size.width * .04,
              height: MediaQuery.of(context).size.height * .1,
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Deseja mesmo remover essa geladeira?',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .04,
                      color: Colors.grey.shade600),
                ),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCELAR'),
                onPressed: () {
                  retornoRemover = false;
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('REMOVER'),
                onPressed: () {
                  if (i == lista_geladeira.length - 1 &&
                      lista_geladeira.length > 1) {
                    controller_geladeira.delete(codigoGeladeira);
                    i -= 1;
                  } else {
                    controller_geladeira.delete(codigoGeladeira);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
