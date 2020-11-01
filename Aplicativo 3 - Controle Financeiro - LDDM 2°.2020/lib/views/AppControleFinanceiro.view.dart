import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:AppControleFinanceiro/controllers/AppControleFinanceiro.controller.dart';
import 'package:AppControleFinanceiro/models/AppControleFinanceiro.models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../controllers/AppControleFinanceiro.controller.dart';

var _themeData = ThemeData.light();

class HomePage extends StatefulWidget {
  @override 
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    String _theme = 'Light';
    @override
    void initState() {
    super.initState();
      _loadTheme();
     }
    _loadTheme() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _theme = (prefs.getString('theme') ?? 'Light');
        _themeData = _theme == 'Dark' ? ThemeData.dark() : ThemeData.light();
      });
    }
    // Carregando o tema salvo pelo usuário
    _setTheme(theme) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        _theme = theme;
        _themeData = theme == 'Dark' ? ThemeData.dark() : ThemeData.light();
        prefs.setString('theme', theme);
      });
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _themeData,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: AppBar(
        title: Text('Controle Financeiro', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
        actions: [
          _popupMenuButton(),
        ],
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color: Colors.deepOrange.shade400,padding: EdgeInsets.all(0.0),child: Text('Janeiro', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => printMes(1, 'Janeiro')));}),
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color: Colors.deepOrange.shade400,padding: EdgeInsets.all(0.0),child: Text('Fevereiro', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => printMes(2, 'Fevereiro')));}),
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color: Colors.deepOrange.shade400,padding: EdgeInsets.all(0.0),child: Text('Março', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => printMes(3, 'Março')));}),
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color: Colors.deepOrange.shade400,padding: EdgeInsets.all(0.0),child: Text('Abril', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => printMes(4, 'Abril')));}),
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color: Colors.deepOrange.shade400,padding: EdgeInsets.all(0.0),child: Text('Maio', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => printMes(5, 'Maio')));}),
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color: Colors.deepOrange.shade400,padding: EdgeInsets.all(0.0),child: Text('Junho', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => printMes(6, 'Junho')));}),
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color: Colors.deepOrange.shade400,padding: EdgeInsets.all(0.0),child: Text('Julho', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => printMes(7, 'Julho')));}),
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color: Colors.deepOrange.shade400,padding: EdgeInsets.all(0.0),child: Text('Agosto', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => printMes(8, 'Agosto')));}),
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color: Colors.deepOrange.shade400,padding: EdgeInsets.all(0.0),child: Text('Setembro', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => printMes(9, 'Setembro')));}),
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color: Colors.deepOrange.shade400,padding: EdgeInsets.all(0.0),child: Text('Outubro', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => printMes(10, 'Outubro')));}),   
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color: Colors.deepOrange.shade400,padding: EdgeInsets.all(0.0),child: Text('Novembro', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => printMes(11, 'Novembro')));}),
            RaisedButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),),color: Colors.deepOrange.shade400,padding: EdgeInsets.all(0.0),child: Text('Dezembro', style: TextStyle(color: Colors.white, fontSize: 20),), onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => printMes(12, 'Dezembro')));}),
          ],
        ),     
      ) ,
      )
    );
  }
_popupMenuButton(){
  return PopupMenuButton(
    onSelected: (value) => _setTheme(value) ,
    itemBuilder: (context) {
    var list = List<PopupMenuEntry<Object>>();
    list.add(
      PopupMenuItem(
        child: Text("Escolha um tema")
      ),
    );
    list.add(
      PopupMenuDivider(
        height: 10,
      ),
    );
    list.add(
      CheckedPopupMenuItem(
        child: Text("Light"),
        value: 'Light',
        checked: _theme == 'Light',
      ),
    );
    list.add(
      CheckedPopupMenuItem(
        child: Text("Dark"),
        value: 'Dark',
        checked: _theme == 'Dark',
      ),
    );
    return list;
    },
  );
}
}

class printMes extends StatefulWidget {
  int numeroMes;
  String nomeMes;
  printMes(this.numeroMes, this.nomeMes);
  @override
  _printMesState createState() => _printMesState(numeroMes, nomeMes);
}
class _printMesState extends State<printMes> {
  String nomeMes;
  double soma;
  final _formKey = GlobalKey<FormState>();
  var _diaController = TextEditingController();
  var _descricaoController = TextEditingController();
  var _valorController = TextEditingController();
  var _controller = ItemController();
  var _listGastos = List<Item>();
  int numeroMes;
      String _theme = 'Light';
    var _themeData = ThemeData.light();

  _printMesState(this.numeroMes, this.nomeMes);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.getAll().then((data) {
        setState(() {
          _listGastos = _controller.list;
        });
      });
    });
  } 
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${nomeMes}'),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
      ),
      body: Scrollbar(
        child: ListView(
          children: [
            for(int i=0; i<_listGastos.length;i++)
              numeroMes == _listGastos[i].mes ?          
                Card(child: 
                  Row(mainAxisAlignment:  MainAxisAlignment.spaceBetween,children: 
                    [Text('\t\t\t${_listGastos[i].dia}/${_listGastos[i].mes}'),
                    Text('${_listGastos[i].descricao}'),Text('R\$\ ${_listGastos[i].valor}'),
                    IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: (){setState(() {
                          _controller.delete(i);
                          _listGastos = _controller.list;
                        }
                      );
                    }
                    ),],),)
                :
                Container(),
                Card(child: Text(retornaSoma(numeroMes).toString() == '0.0' ? '\t\t\tNão há lançamentos de gastos nesse mês':'\t\t\tValor total de gastos: R\$\ '+retornaSoma(numeroMes).toString()),)
                
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.green.shade700,
        onPressed: () => _displayDialog(context, numeroMes),
      ),
    );
  }

  double retornaSoma(int numeroMes){
    double soma = 0;
    for(int i=0; i<_listGastos.length;i++){
      if(_listGastos[i].mes == numeroMes){
        soma += _listGastos[i].valor;
      }
    }
    return soma;
  }
  _displayDialog(context, int numeroMes) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Form(
              key: _formKey,
              child: Column(children:<Widget> [
                  _editText('Dia', _diaController),
                  _editText('Descrição', _descricaoController),
                  _editText('Valor', _valorController),
    
              ]
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
                    _controller.create(Item(descricao: _descricaoController.text,dia: int.parse(_diaController.text), mes: numeroMes, valor: double.parse(_valorController.text))).then((data) {
                      setState(() {
                        _listGastos = _controller.list;
                        _diaController.text = "";
                        _descricaoController.text = "";
                        _valorController.text = "";
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
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }
  _editText(String field, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      validator: (s) => _validate(s, field),
      keyboardType: TextInputType.number,
      style: TextStyle(
        fontSize: 15,
        color: Colors.orange,
      ),
      decoration: InputDecoration(
        labelText: field,
        labelStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey,
        ),
      ),
    );
  }
}
