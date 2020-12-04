import 'package:floor/floor.dart';

import 'iFreeze.Geladeira.model.dart';

@Entity()
class Comida {
  @ForeignKey(entity: Geladeira)
  int codigoGeladeira;
  @PrimaryKey(autoGenerate: false)
  String qrCode;
  String nome;
  int quantidade;
  String validade;

  Comida(
      {this.codigoGeladeira,
      this.qrCode,
      this.nome,
      this.quantidade,
      this.validade});

  Comida.fromJson(Map<String, dynamic> json) {
    codigoGeladeira = json['codigoGeladeira'];
    qrCode = json['qrCode'];
    nome = json['nome'];
    quantidade = json['quantidade'];
    validade = json['validade'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigoGeladeira'] = this.codigoGeladeira;
    data['qrCode'] = this.qrCode;
    data['nome'] = this.nome;
    data['quantidade'] = this.quantidade;
    data['validade'] = this.validade;
    return data;
  }
}
