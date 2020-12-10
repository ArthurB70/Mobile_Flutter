import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'views/iFreeze.HomePage.view.dart';

import 'controllers/iFreeze.Geladeira.controller.dart';
import 'controllers/iFreeze.Comida.controller.dart';
import 'package:iFreeze/controllers/iFreeze.Comida.controller.dart';
import 'package:iFreeze/controllers/iFreeze.MQTT.controller.dart';
void main() {
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new ComidaController(),
        ),
        ChangeNotifierProvider(
          create: (_) => new GeladeiraController(),
        ),
        ChangeNotifierProvider(
          create: (_) => new MQTTController(),
        ),
      ],
      child: MaterialApp(
      
      title: 'iFreeze',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  ));
}


