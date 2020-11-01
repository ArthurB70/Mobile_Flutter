import 'package:flutter/material.dart';

class Item {
  String descricao;
  int dia;
  int mes;
  double valor;

  Item({this.descricao, this.dia, this.mes, this.valor});

  Item.fromJson(Map<String, dynamic> json) {
    descricao = json['descricao'];
    dia = json['dia'];
    mes = json['mes'];
    valor = json['valor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['descricao'] = this.descricao;
    data['dia'] = this.dia;
    data['mes'] = this.mes;
    data['valor'] = this.valor;
    return data;
  }
}