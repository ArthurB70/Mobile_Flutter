import 'package:floor/floor.dart';

@entity
class Geladeira {
  @PrimaryKey(autoGenerate: true)
  int codigoGeladeira;
  String nome;
  bool status;
  String topico;

  Geladeira({this.codigoGeladeira, this.nome, this.status, this.topico});

  Geladeira.fromJson(Map<String, dynamic> json) {
    codigoGeladeira = json['codigoGeladeira'];
    nome = json['nome'];
    status = json['status'];
    topico = json['topico'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigoGeladeira'] = this.codigoGeladeira;
    data['nome'] = this.nome;
    data['status'] = this.status;
    data['topico'] = topico;
    return data;
  }
}
