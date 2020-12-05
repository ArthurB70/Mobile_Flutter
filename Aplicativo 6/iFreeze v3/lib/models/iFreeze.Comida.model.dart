import 'package:floor/floor.dart';

import 'iFreeze.Geladeira.model.dart';

@Entity()
class Comida {
  @ForeignKey(entity: Geladeira)
  int codigoGeladeira;
  @PrimaryKey(autoGenerate: true)
  int id;
  String nome;
  int quantidade;
  String validade;

  Comida(
      {this.codigoGeladeira,
      this.id,
      this.nome,
      this.quantidade,
      this.validade});

  Comida.fromJson(Map<String, dynamic> json) {
    codigoGeladeira = json['codigoGeladeira'];
    id = json['id'];
    nome = json['nome'];
    quantidade = json['quantidade'];
    validade = json['validade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigoGeladeira'] = this.codigoGeladeira;
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['quantidade'] = this.quantidade;
    data['validade'] = this.validade;
    return data;
  }
}
