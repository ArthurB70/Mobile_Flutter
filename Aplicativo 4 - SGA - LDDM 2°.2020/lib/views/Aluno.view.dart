import 'package:app4SGA/controllers/Aluno.controller.dart';
import 'package:app4SGA/models/Aluno.model.dart';
import 'package:app4SGA/repositories/Aluno.dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  var _matriculaController = TextEditingController();
  var _senhaController = TextEditingController();
  bool _login = true;
  bool login = true;
  AlunoController _controller = null;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.getAll();
      _login = login;
    });
  } 
  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<AlunoController>(context);
    return Scaffold(
      appBar: AppBar(title: Text('SGA - Sistema de Gestão Acadêmica'), centerTitle: true, backgroundColor: Colors.lightBlue.shade700,),
      body: Padding( padding: EdgeInsets.all(16),
        child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            _fieldGeral('Matrícula', _matriculaController),
            _fieldSenha('Senha', _senhaController),
            Container(margin: EdgeInsets.only(top: 20),child:RaisedButton(color:Colors.lightBlue.shade700 ,padding: EdgeInsets.symmetric(horizontal: 111) ,child: Text(' LOGIN  ', style: TextStyle(color: Colors.white)),
            onPressed: () async{
              try{
                Aluno aluno = await _controller.getAlunoById(int.parse(_matriculaController.text));
                if(aluno.matricula != -1){
                  if(aluno.senha == _senhaController.text){
                    setState(() {
                      login = true;
                    });
                    _senhaController.text = "";
                    _matriculaController.text = "";
                    print("nome: "+ aluno.nome);
                    print(login);
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>PrintAluno(aluno) ));
                  }
                  else{
                    setState(() {
                      login = false;
                    });
                           
                    print('primeiro else');
                    print(login);

                  }
                }             
              }
              catch(e){
                setState(() {
                  login = false;
                });
                print('segundo else');
                print(login);
              }
            }),),
            Container(child:RaisedButton(color: Colors.lightGreen.shade600,padding: EdgeInsets.symmetric(horizontal: 100), child: Text('CADASTRO', style: TextStyle(color: Colors.white),),
            onPressed: (){
              setState(() {
                  login = true;
                });
              _senhaController.text = "";
              _matriculaController.text = "";
              Navigator.push(context, MaterialPageRoute(builder: (context) =>Cadastro() ));
            }),),
            Observer(builder: (_) {if(login==false){return Text('Informações inválidas!',style: TextStyle(color: Colors.red),);}else{ return Container();}}),
          ],
        ),
      ),
    ) 
    );
  }
  _fieldSenha(String nomeCampo, TextEditingController controller){
    return TextFormField(
      obscureText: true,
      controller: controller,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: nomeCampo,
        labelStyle: TextStyle(fontSize:17.0, color: Colors.grey.shade600),
      ),
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
class Cadastro extends StatefulWidget {
  @override
  _CadastroState createState() => _CadastroState();
}

class _CadastroState extends State<Cadastro> {
  var _matriculaController = TextEditingController();
  var _senhaController = TextEditingController();
  var _idadeController = TextEditingController();
  var _periodoController = TextEditingController();
  var _nomeController = TextEditingController();
  var _mediaController = TextEditingController();
  AlunoController _controller = null;

  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<AlunoController>(context);
    return Scaffold(
      appBar: AppBar(title: Text('SGA - Cadastro'), centerTitle: true, backgroundColor: Colors.lightGreen.shade600,),
      body: Scrollbar(child:Padding(padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              _fieldGeral('Nome', _nomeController),
              _fieldGeral('Matrícula', _matriculaController),   
              _fieldGeral('Idade', _idadeController),
              _fieldGeral('Período', _periodoController),
              _fieldGeral('Média de notas', _mediaController),
              _fieldSenha('Senha', _senhaController),
              Container(margin: EdgeInsets.only(top: 20),child:RaisedButton(color:Colors.lightGreen.shade600 ,padding: EdgeInsets.symmetric(horizontal: 111) ,child: Text('ENVIAR', style: TextStyle(color: Colors.white)),
              onPressed: (){

            
                try{
                  _controller.create(Aluno(idade: int.parse(_idadeController.text),
                matricula: int.parse(_matriculaController.text),
                periodo: int.parse(_periodoController.text),
                nome: _nomeController.text,
                media: double.parse(_mediaController.text),
                senha: _senhaController.text));
                }
                catch(e){
                  print("Erro: "+ e.toString());
                }
                _nomeController.text = "";
                _matriculaController.text = "";
                _idadeController.text = "";
                _periodoController.text = "";
                _mediaController.text = "";
                _senhaController.text = "";
                Navigator.of(context).pop();
              }),),
            ],
          ),
        ),
      ), 
    );
  }
  _fieldSenha(String nomeCampo, TextEditingController controller){
    return TextFormField(
      obscureText: true,
      controller: controller,
      keyboardType: TextInputType.text,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: nomeCampo,
        labelStyle: TextStyle(fontSize:17.0, color: Colors.grey.shade600),
      ),
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

class PrintAluno extends StatefulWidget {
  final Aluno aluno;
  PrintAluno(this.aluno);
  @override
_PrintAlunoState createState() => _PrintAlunoState(aluno);
}

class _PrintAlunoState extends State<PrintAluno> {
  final Aluno aluno;
  _PrintAlunoState(this.aluno);
  AlunoController _controller = null;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _controller.getAll();
    });
  }   
  @override
  Widget build(BuildContext context) {
    _controller = Provider.of<AlunoController>(context);
    return Scaffold(
      appBar: AppBar(title: Text('SGA - Aluno'), centerTitle: true, backgroundColor: Colors.lightBlue.shade700),
      body: Column(children: [
        Container(padding: EdgeInsets.symmetric(vertical:10),child: Text('Informações Pessoais', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
        Container(padding:EdgeInsets.symmetric(horizontal: 10) , child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[Text(' Nome: ', style: TextStyle(fontWeight: FontWeight.bold),), Text(aluno.nome),Text(' Idade: ', style: TextStyle(fontWeight: FontWeight.bold),), Text(aluno.idade.toString())]),),
        Container(padding: EdgeInsets.symmetric(vertical:10),child: Text('Informações do Curso', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),),
        Container(padding:EdgeInsets.symmetric(horizontal: 10) , child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children:[Text(' Matrícula: ', style: TextStyle(fontWeight: FontWeight.bold),), Text(aluno.matricula.toString()),Text(' Período: ', style: TextStyle(fontWeight: FontWeight.bold),), Text(aluno.periodo.toString())]),),
        Container(padding:EdgeInsets.all(10) , child: Row( children:[Text(' Média:   ', style: TextStyle(fontWeight: FontWeight.bold),), Text(aluno.media.toString())]),),
        Container(margin: EdgeInsets.all(20),child: RaisedButton(child: Text('REMOVER CADASTRO'),color: Colors.red.shade500,
        onPressed: (){
          _controller.delete(aluno.matricula);
          Navigator.of(context).pop();
        }),)
      ],),
    
    );
  }
}