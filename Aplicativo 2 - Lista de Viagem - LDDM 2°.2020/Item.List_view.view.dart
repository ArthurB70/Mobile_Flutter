import 'package:Lista/controllers/item.controller.dart';
import 'package:flutter/material.dart';
import 'package:Lista/models/Item.models.dart';
import 'package:flutter/services.dart';
  

class ItemListView extends StatefulWidget {
  @override
  _ItemListViewState createState() => _ItemListViewState();
}

class _ItemListViewState extends State<ItemListView> {

  final _formKey = GlobalKey<FormState>();
 
  var _itemController = TextEditingController();
  bool _tipoRoupa = true;
  var _list = List<Item>();
  var _controller = ItemController();
  var _roupasF = ['Vestido','Blusa','Short','Saia','Casaco','Calça','Camisa', 'Blusa de frio'];
  var _roupasM = ['Camisa','Bermuda','Short','Calça', 'Roupa social', 'Jaqueta', 'Blusa de frio'];
  var _acessorios = ['Tênis','Sandalha','Óculos de sol','Chapéu','Itens de higiene','Roupa íntima','Meia', 'Filtro solar', 'Pijama', 'Roupão', 'Sapato'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getAll().then((data) {
        setState(() {
          _list = _controller.list;
        });
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    if(_list.isEmpty){
      return _telaListaVazia();
    }
    else{
      return _telaLista();
    }
  }
  _displayDialog(context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: TextFormField(
                controller: _itemController,
                validator: (s) {
                  if (s.isEmpty)
                    return "Digite o item.";
                  else
                    return null;
                },
                keyboardType: TextInputType.text,
                decoration: InputDecoration(labelText: "Item"),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: new Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: new Text('SALVAR'),
                onPressed: () {
                  if (_formKey.currentState.validate()) {

                    _controller.create(Item(nome: _itemController.text, concluido: false, quantidade: 1)).then((data) {
                      setState(() {
                        _list = _controller.list;
                        _itemController.text = "";
                      });
                    });
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          );
        });
  }

  _telaListaVazia(){
    return Scaffold(
      appBar: AppBar(
        title: Text('Trip List'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: 
        Form(
          key: _formKey,
          child:Card(child:Column(children: [
            Text('Tipo de roupa', style: TextStyle(fontSize: 18),),
            RadioListTile(title:Text('Feminina') ,value: true, groupValue: _tipoRoupa, onChanged: (value){
              setState(() {
                _tipoRoupa = value;
              });
            },),
            RadioListTile(title:Text('Masculina'),value: false, groupValue: _tipoRoupa, onChanged: (value){
              setState(() {
                _tipoRoupa = value;
              });
            }),
            _buttonEnviar(),
          ],), margin: EdgeInsets.all(20),)
        ),
         
      
    );    
  }
  _buttonEnviar() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.black,
        child:
        Text(
          "Enviar",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          _preListas();
        },
      ),
    );
  }
  _preListas(){
    if(_tipoRoupa){
      for(int i=0;i<_roupasF.length;i++){
        _controller.create(Item(nome: _roupasF[i], concluido: false, quantidade: 1)).then((data) {
          setState(() {
            _list = _controller.list;
              _itemController.text = "";
          });
       });      
      }
      for(int i=0;i<_acessorios.length;i++){
        _controller.create(Item(nome: _acessorios[i], concluido: false, quantidade: 1)).then((data) {
          setState(() {
            _list = _controller.list;
              _itemController.text = "";
          });
       });      
      }      

    }
    else{
      for(int i=0;i<_roupasM.length;i++){
        _controller.create(Item(nome: _roupasM[i], concluido: false, quantidade: 1)).then((data) {
          setState(() {
            _list = _controller.list;
              _itemController.text = "";
          });
       });      
      }
      for(int i=0;i<_acessorios.length;i++){
        _controller.create(Item(nome: _acessorios[i], concluido: false, quantidade: 1)).then((data) {
          setState(() {
            _list = _controller.list;
              _itemController.text = "";
          });
       });      
      }       

    }
  }
  _telaLista(){
        return Scaffold(
      appBar: AppBar(
          title: Text('Trip List'),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: (){
                while(!_list.isEmpty){
                    _controller.delete(0).then((data) {
                      setState(() {_list = _controller.list;});
                    });                  
                }
            })
          ],
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            for (int i = 0; i < _list.length; i++)
              Card(child: Row(children: [
                  IconButton(icon: Icon(Icons.keyboard_arrow_left), iconSize: 50, color: Colors.black, 
                  onPressed: (){setState(() {
                  _list[i].quantidade -= 1;
                  _controller.updateList(_list);
                  if(_list[i].quantidade == 0){
                    _controller.delete(i).then((data) {
                      setState(() {
                        _list = _controller.list;
                      });
                    });
                  }
                    });},),
                  CircleAvatar( backgroundColor: Colors.black, radius: 12, child: Text('${_list[i].quantidade}', style: TextStyle(fontSize: 15, color: Colors.white)),),
                  IconButton(icon: Icon(Icons.keyboard_arrow_right),iconSize: 50,color: Colors.black, onPressed: (){setState(() {
                   _list[i].quantidade += 1; _controller.updateList(_list);});},),
                  Text(_list[i].nome, style: TextStyle(fontSize: 18),),
                  IconButton(icon: Icon(Icons.done_outline),color: _list[i].concluido? Colors.green: Colors.black,  iconSize: 30, onPressed: (){
                    setState(() {
                      if(_list[i].concluido){
                        _list[i].concluido = false;
                      }
                      else{
                        _list[i].concluido = true;
                      }
                    });
                  },), 
                ],),),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.black,
        onPressed: () => _displayDialog(context),
      ),
    );
  }
}






