import 'package:flutter/material.dart';
import '../controllers/Clima.controller.dart';
import '../models/Clima.model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ClimaController _controller = ClimaController();
  var _cidadeController = TextEditingController();
  var _estadoController = TextEditingController();
  Clima _requisicao = Clima();
  final _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text('Consulta do clima'), centerTitle: true, backgroundColor: Colors.lightGreen.shade600,),
      body: Container( padding: EdgeInsets.all(30),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _fieldGeral('Cidade. Ex: Belo Horizonte', _cidadeController),
              _fieldGeral('UF. Ex: MG, SP', _estadoController),
            Container(margin: EdgeInsets.only(top: 20),child:RaisedButton(color:Colors.lightGreen.shade600 ,padding: EdgeInsets.symmetric(horizontal: 111) ,child: Text(' Enviar ', style: TextStyle(color: Colors.white, fontSize: 20)),
            onPressed: ()  async{
                try{
                  _requisicao = await _controller.getClima(_cidadeController.text, _estadoController.text);
                  _displayDialog(context, _requisicao);
                  _cidadeController.text = "";
                  _estadoController.text = "";
                }
                catch(e){
                  print("Erro1"+e.toString());
                }
            }),),              
            ]
          ) ,
        ),
      ),
    );
  }
  _displayDialog(context, Clima data){
    return showDialog(context: context,
      builder: (context){
        return AlertDialog(
          content: Container( width: 500, height: 100,
            child: Column( mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: <Widget>[
                Container(child: Row(children: [Text('${data.city_name},', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold),),],) ),
                Container(child: Row(children: [Text('${data.description}'),],) ),
                Container(child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween ,children: [Text('Temperatura: ' ,style: TextStyle(fontWeight: FontWeight.bold),),Text('${data.temp}'), Text('Umidade: ',style: TextStyle(fontWeight: FontWeight.bold)), Text('${data.humidity}')],),),
                Container(child: Row(children: [Text('Velocidade do vento: ',style: TextStyle(fontWeight: FontWeight.bold)), Text('${data.wind_speedy}')],) ,)
              ],
            ),
          ),

      actions: [
        FlatButton(
          child: Text('OK', style: TextStyle(color: Colors.white),),
          color: Colors.lightGreen.shade600,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
    
    );
    
  }
  _fieldGeral(String nomeCampo, TextEditingController controller){
    return TextFormField(
      obscureText: false,
      controller: controller,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: nomeCampo,
        labelStyle: TextStyle(fontSize:17.0, color: Colors.grey.shade600),
      ),
    );
  }
}