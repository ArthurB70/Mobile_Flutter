import 'package:flutter/material.dart';

class Item {
  String nome;
  int quantidade;
  bool concluido;

  Item({this.nome, this.quantidade, this.concluido});

  Item.fromJson(Map<String, dynamic> json) {
    nome = json['name'];
    quantidade = json['amount'];
    concluido = json['done'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.nome;
    data['amount'] = this.quantidade;
    data['done'] = this.concluido;
    return data;
  }
}