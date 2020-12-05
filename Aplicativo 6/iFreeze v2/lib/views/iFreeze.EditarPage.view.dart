import 'package:flutter/material.dart';
import 'package:iFreeze/controllers/iFreeze.Geladeira.controller.dart';
import 'package:iFreeze/models/iFreeze.Geladeira.model.dart';
import 'package:provider/provider.dart';

class EditarPage extends StatefulWidget {
  Geladeira geladeira;
  EditarPage({this.geladeira});

  @override
  _EditarPageState createState() => _EditarPageState(geladeira: geladeira);
}

class _EditarPageState extends State<EditarPage> {
  Geladeira geladeira;
  _EditarPageState({this.geladeira});

  final _formKey = GlobalKey<FormState>();
  var _nomeController = TextEditingController();
  bool _statusGeladeira = false;
  @override
  Widget build(BuildContext context) {
    _nomeController.text = geladeira.nome;
    final GeladeiraController controller_geladeira =
        Provider.of<GeladeiraController>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Container(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * .01),
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
                child: Text('Editar',
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: MediaQuery.of(context).size.width * .06)),
              ),
            ),
            _fieldGeral('Nome', _nomeController),
            Center(
              child: Container(
                margin: EdgeInsets.only(top:MediaQuery.of(context).size.height * .02),
                child: Text(
                  'Status',
                  style: TextStyle(fontSize: MediaQuery.of(context).size.width * .05, color: Colors.grey.shade600),
                ),
              ),
            ),
            RadioListTile(
              title: Text('Ligada', style: TextStyle(fontSize: MediaQuery.of(context).size.width * .04, color: Colors.grey.shade600)),
              value: true,
              groupValue: _statusGeladeira,
              onChanged: (value) {
                setState(() {
                  _statusGeladeira = value;
                });
              },
            ),
            RadioListTile(
                title: Text('Desligada',style: TextStyle(fontSize: MediaQuery.of(context).size.width * .04, color: Colors.grey.shade600)),
                value: false,
                groupValue: _statusGeladeira,
                onChanged: (value) {
                  setState(() {
                    _statusGeladeira = value;
                  });
                }),
            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * .02),
              child: FlatButton(
                  color: Colors.lightBlue.shade400,
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * .30),
                  child:
                      Text('ENVIAR', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                      if (_nomeController.text != '') {
                        geladeira.nome = _nomeController.text;
                        geladeira.status = _statusGeladeira;
                        controller_geladeira.update(geladeira);
                            Navigator.of(context).pop();
                      }
                  }),
            ),
          ],
        ),
      ),
    );
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
