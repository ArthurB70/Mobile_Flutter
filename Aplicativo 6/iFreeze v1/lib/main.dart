import 'package:flutter/material.dart';
import 'package:iFreeze/controllers/iFreeze.Comida.controller.dart';
import 'controllers/iFreeze.Geladeira.controller.dart';
import 'models/iFreeze.Comida.model.dart';
import 'views/iFreeze.HomePage.view.dart';
import 'views/iFreeze.ListPage.view.dart';
import 'package:provider/provider.dart';
import 'controllers/iFreeze.Comida.controller.dart';
import 'controllers/iFreeze.Geladeira.controller.dart';
void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new ComidaController(),
        ),
        ChangeNotifierProvider(
          create: (_) => new GeladeiraController(),
        ),
      ],
      child: MaterialApp(
      title: 'iFreeze',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  ));
}


