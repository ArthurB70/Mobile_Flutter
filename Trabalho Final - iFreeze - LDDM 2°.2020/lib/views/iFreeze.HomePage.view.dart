// DEPENDÊNCIAS
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:iFreeze/repositories/iFreeze.MQTT.repository.dart';
import 'package:provider/provider.dart';
// MODELOS
import 'package:iFreeze/models/iFreeze.Comida.model.dart';
import 'package:iFreeze/models/iFreeze.Geladeira.model.dart';
// CONTROLLERS
import 'package:iFreeze/controllers/iFreeze.Comida.controller.dart';
import 'package:iFreeze/controllers/iFreeze.Geladeira.controller.dart';
import 'package:iFreeze/controllers/iFreeze.MQTT.controller.dart';
// VIEWS
import 'package:iFreeze/views/iFreeze.ListPage.view.dart';
import 'package:iFreeze/views/iFreeze.CadastroPage.view.dart';
import 'package:iFreeze/views/iFreeze.EditarPage.view.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _nomeController = TextEditingController();
  var _topicoController = TextEditingController();
  bool _statusGeladeira = true;
  int i = 0;
  String _qrCodeData = "";
  bool retornoRemover = false;
  final _formKey = GlobalKey<FormState>();
  Geladeira _geladeira =
      new Geladeira(nome: 'Adicione uma geladeira', status: false);
  List<Geladeira> lista_geladeira = List<Geladeira>();
  MQTTController currentAppState;
  MQTTRepository manager;

  @override
  Widget build(BuildContext context) {
    final GeladeiraController controller_geladeira =
        Provider.of<GeladeiraController>(context, listen: true);
    final ComidaController controller_comida =
        Provider.of<ComidaController>(context, listen: true);
    final MQTTController controller_mqtt =
        Provider.of<MQTTController>(context, listen: true);
    lista_geladeira = controller_geladeira.lista_geladeira;
    currentAppState = controller_mqtt;
    if (lista_geladeira.isEmpty) {
      return _cadastroInicial();
    } else {
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
          body: Scrollbar(
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .50,
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
                              if (currentAppState.getAppConnectionState ==
                                  MQTTAppConnectionState.connected && lista_geladeira.length>1) {
                                currentAppState.disconnect();
                                print('desconectou!');                            
                              }

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
                      height: MediaQuery.of(context).size.height * .30,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                        : '#${lista_geladeira[i].codigoGeladeira}',
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    radius:
                                        MediaQuery.of(context).size.width * .08,
                                    backgroundColor: Colors.lightBlue.shade400,
                                    child: Text(
                                      lista_geladeira.isEmpty
                                          ? 'null'
                                          : currentAppState.getAppConnectionState == MQTTAppConnectionState.disconnected ?'':'${currentAppState.getReceivedText} °C',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              .035),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  IconButton(
                                      iconSize:
                                          MediaQuery.of(context).size.width *
                                              .09,
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
                                          MediaQuery.of(context).size.width *
                                              .07,
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.black,
                                      ),
                                      onPressed: () {
                                        if (!lista_geladeira.isEmpty)
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditarPage(
                                                        geladeira:
                                                            lista_geladeira[i],
                                                      )));
                                      }),
                                  IconButton(
                                      iconSize:
                                          MediaQuery.of(context).size.width *
                                              .07,
                                      icon: Icon(Icons.delete,
                                          color: Colors.black),
                                      onPressed: () {
                                        if (lista_geladeira.length >= 1)
                                          _popUpRemoverGeladeira(
                                              context,
                                              controller_geladeira,
                                              lista_geladeira[i]
                                                  .codigoGeladeira,
                                              controller_comida);
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
                              if (!lista_geladeira.isEmpty) {
                                if (currentAppState.getAppConnectionState ==
                                    MQTTAppConnectionState.connected && lista_geladeira.length>1) {
                                  currentAppState.disconnect();
                                }
                                if (i < lista_geladeira.length - 1) {
                                  i += 1;
                                }
                                if (!lista_geladeira.isEmpty) {
                                  _geladeira = lista_geladeira[i];
                                }
                              }
                            });
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              child: Icon(Icons.cloud_download),
              onPressed: () {
                setState(() {
                  if (!lista_geladeira.isEmpty) if (lista_geladeira[i].topico !=
                      null && lista_geladeira[i].topico !=
                      '' && currentAppState.getAppConnectionState != MQTTAppConnectionState.connected) {
                    try {
                      _configureAndConnect();
                    } catch (e) {}
                  }
                });
              }),
          bottomNavigationBar: BottomAppBar(
            color: Colors.grey.shade200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                      left: 30, top: 7.5, right: 30, bottom: 7.5),
                  child: CircleAvatar(
                      backgroundColor: Colors.lightBlue.shade400,
                      child: IconButton(
                          color: Colors.white,
                          icon: Icon(Icons.qr_code_scanner),
                          onPressed: () {
                            if (!lista_geladeira.isEmpty)
                              _qrCodeScanner(controller_comida,
                                  lista_geladeira[i].codigoGeladeira);
                          })),
                ),
                Container(
                  padding: EdgeInsets.only(
                      left: 30, top: 7.5, right: 30, bottom: 7.5),
                  child: CircleAvatar(
                    backgroundColor: Colors.lightBlue.shade400,
                    child: IconButton(
                        color: Colors.white,
                        icon: Icon(Icons.list),
                        onPressed: () {
                          if (!lista_geladeira.isEmpty)
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PageList(
                                          codigoGeladeira: lista_geladeira[i]
                                              .codigoGeladeira,
                                        )));
                        }),
                  ),
                ),
              ],
            ),
          ));
    }
  }

  _qrCodeScanner(
      ComidaController controller_comida, int codigoGeladeira) async {
    await FlutterBarcodeScanner.scanBarcode(
            "#FF29B6F6", "Voltar", true, ScanMode.QR)
        .then((value) => setState(() => _qrCodeData = value));
    try {
      Comida teste = Comida.fromJson(json.decode(_qrCodeData));
      teste.codigoGeladeira = codigoGeladeira;
      controller_comida.create(teste, teste.codigoGeladeira);
      print('Item adicionado com sucesso!');
    } catch (e) {
      print('Não foi possível adicionar o item!');
    }
  }

  _popUpRemoverGeladeira(context, GeladeiraController controller_geladeira,
      int codigoGeladeira, ComidaController controller_comida) async {
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
                    limpa_lista_comida(codigoGeladeira, controller_comida);
                    controller_geladeira.delete(codigoGeladeira);

                    i -= 1;
                  } else {
                    limpa_lista_comida(codigoGeladeira, controller_comida);
                    controller_geladeira.delete(codigoGeladeira);
                  }
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  _cadastroInicial() {
    final GeladeiraController controller_geladeira =
        Provider.of<GeladeiraController>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .01),
          child: Image.asset(
            'images/ifreeze2.png',
          ),
          width: MediaQuery.of(context).size.width * .5,
        ),
        backgroundColor: Colors.lightBlue.shade400,
      ),
      body: Scrollbar(
        child: ListView(
          padding: EdgeInsets.all(MediaQuery.of(context).size.width * .1),
          children: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Container(
                child: Text('Cadastro',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: MediaQuery.of(context).size.width * .06)),
              ),
            ),
            _fieldGeral('Nome', _nomeController),
            Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .02),
                child: Text(
                  'Status',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .05,
                      color: Colors.grey.shade600),
                ),
              ),
            ),
            RadioListTile(
              title: Text('Ligada',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * .04,
                      color: Colors.grey.shade600)),
              value: true,
              groupValue: _statusGeladeira,
              onChanged: (value) {
                setState(() {
                  _statusGeladeira = value;
                });
              },
            ),
            RadioListTile(
                title: Text('Desligada',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * .04,
                        color: Colors.grey.shade600)),
                value: false,
                groupValue: _statusGeladeira,
                onChanged: (value) {
                  setState(() {
                    _statusGeladeira = value;
                  });
                }),
            _fieldGeral('Tópico- mqtt (opcional)', _topicoController),
            Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * .02),
              child: RaisedButton(
                  color: Colors.lightBlue.shade400,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * .30),
                  child: Text('ENVIAR', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    if (_nomeController.text != '') {
                      setState(() {
                        controller_geladeira.create(Geladeira(
                            nome: _nomeController.text,
                            status: _statusGeladeira,
                            topico: _topicoController.text));
                        _nomeController.text = "";
                      });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void limpa_lista_comida(
      int codigoGeladeira, ComidaController controller_comida) {
    List<Comida> lista_aux = List<Comida>();
    List<Comida> lista_comida = List<Comida>();
    lista_comida = controller_comida.lista_comida;
    for (int i = 0; i < lista_comida.length; i++) {
      if (lista_comida[i].codigoGeladeira == codigoGeladeira) {
        lista_aux.add(lista_comida[i]);
      }
    }
    if (!lista_aux.isEmpty) {
      for (int i = 0; i < lista_aux.length; i++) {
        controller_comida.delete(lista_aux[i].id, codigoGeladeira);
      }
    }
  }
  void _configureAndConnect() {
    manager = MQTTRepository(
        host: 'mqtt.dioty.co',
        topic: lista_geladeira.isEmpty ? 'null' : lista_geladeira[i].topico,
        identifier: 'android',
        state: currentAppState);
    manager.initializeMQTTClient();
    manager.connect();
  }
  _fieldGeral(String nomeCampo, TextEditingController controller) {
    return TextFormField(
      obscureText: false,
      controller: controller,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: nomeCampo,
        labelStyle: TextStyle(
            fontSize: MediaQuery.of(context).size.width * .05,
            color: Colors.grey.shade600),
      ),
    );
  }
}
