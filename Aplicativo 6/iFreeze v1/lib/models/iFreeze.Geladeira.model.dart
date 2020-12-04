import 'package:floor/floor.dart';

@entity
class Geladeira {
  @PrimaryKey(autoGenerate: true)
  int codigoGeladeira;
  String nome;
  bool status;

  Geladeira({this.codigoGeladeira, this.nome, this.status});

  Geladeira.fromJson(Map<String, dynamic> json) {
    codigoGeladeira = json['codigoGeladeira'];
    nome = json['nome'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['codigoGeladeira'] = this.codigoGeladeira;
    data['nome'] = this.nome;
    data['status'] = this.status;
    return data;
  }
}
