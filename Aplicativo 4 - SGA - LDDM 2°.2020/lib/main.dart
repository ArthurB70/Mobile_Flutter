import 'package:app4SGA/views/Aluno.view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controllers/Aluno.controller.dart';


void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
 return MultiProvider(
  providers:[
    Provider<AlunoController>.value(value: AlunoController(),),
    ],
  child: MaterialApp(
  title: 'Lista',
  debugShowCheckedModeBanner: false,
  home: LoginPage(),
  )
 );
 }
}