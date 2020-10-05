import 'package:flutter/material.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Racha Conta',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
        
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // DECLARAÇÃO DE VARIÁVEIS 
  final _totalConta = TextEditingController();
  final _totalPessoas = TextEditingController();
  final _totalGorjeta = TextEditingController();
  final _consumoPessoal =  TextEditingController();
  
  var _infoText = "Informe os dados!";
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Racha Conta"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh),
              onPressed: _resetFields)
        ],
      ),
      body: _body(),
    );
  }

  // PROCEDIMENTO PARA LIMPAR OS CAMPOS
  void _resetFields(){
    _totalConta.text = "";
    _totalPessoas.text = "";
    _totalGorjeta.text = "";
    _consumoPessoal.text = "1";
    setState(() {
      _infoText = "Informe os dados!";
      _formKey = GlobalKey<FormState>();
    });
  }

  _body() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _editText("Valor da conta", _totalConta),
              _editText("Gorjeta (%)", _totalGorjeta),
              _editText("Numero de pessoas", _totalPessoas),
              _editText("Bebeu por quantos", _consumoPessoal),
              _buttonCalcular(),
              _textInfo(),
              Image.asset('imagens/HomerSimpsons.png'),
            ],
          ),
        ));
  }

  // Widget text
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

  // PROCEDIMENTO PARA VALIDAR OS CAMPOS
  String _validate(String text, String field) {
    if (text.isEmpty) {
      return "Digite $field";
    }
    return null;
  }

  // Widget button
  _buttonCalcular() {
    return Container(
      margin: EdgeInsets.only(top: 10.0, bottom: 20),
      height: 45,
      child: RaisedButton(
        color: Colors.amber,
        child:
        Text(
          "Calcular",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
          ),
        ),
        onPressed: () {
          if(_formKey.currentState.validate()){
            _calculaValores();
          }
        },
      ),
    );
  }

  // PROCEDIMENTO PARA OS CÁLCULOS
  void _calculaValores(){
    setState(() {
      double valorConta = double.parse(_totalConta.text); // VALOR DA CONTA INFORMADO PELO USUÁRIO
      double valorPessoas = double.parse(_totalPessoas.text); // NUMERO DE PESSOAS ENVOLVIDAS
      double valorGorjeta = valorConta *double.parse(_totalGorjeta.text)/100; // VALOR DA GORJETA
      double finalConta = valorConta + valorGorjeta; // VALOR FINAL DA CONTA: CONTA + GORJETA
      double rachaConta = finalConta/valorPessoas;  // DIVISÃO DA CONTA PELO NUMERO DE PESSOAS ENVOLVIDAS
      double consPessoal = double.parse(_consumoPessoal.text); // PERSONALIZAÇÃO DA DIVISÃO DA CONTA TOMANDO COMO PARÂMETRO UM CONSUMO PESSOAL
      
      if(valorGorjeta <= 0){ // SE A % DA GORJETA FOR < 0 
        finalConta = double.parse(_totalConta.text); // VALOR FINAL DA CONTA = O VALOR INFORMADO PELU USUÁRIO
        valorGorjeta = 0; 
      }
      if(consPessoal > 1){ // SE O CONSUMO PESSOAL INFORMADO PELO USUÁRIO FOR > 1
        double porcentagem = consPessoal / valorPessoas; 
        rachaConta = finalConta * porcentagem;
        _infoText = ("Total da Conta: $finalConta R\$\ \nValor da Gorjeta: $valorGorjeta R\$ \nSua parte deu $rachaConta R\$\ ");
      }
      else{ // SE O CONSUMO PESSOAL FOR IGUAL A 1
        _infoText = ("Total da Conta: $finalConta R\$\ \nValor da Gorjeta: $valorGorjeta R\$ \nDeu $rachaConta R\$\ para cada bêbado!");
      }
    });
  }

  // // Widget text
  _textInfo() {
    return Text(
      _infoText,
      textAlign: TextAlign.center,
      style: TextStyle(color: Colors.orange, fontSize: 25.0),
    );
  }
}