import 'package:floor/floor.dart';

@entity
class Aluno {
  String nome;
  int idade;
  @PrimaryKey (autoGenerate: true)
  int matricula;
  int periodo;
  String senha;
  double media;
  
  Aluno(
      {this.nome,
      this.idade,
      this.matricula,
      this.periodo,
      this.senha,
      this.media,
});

  Aluno.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    idade = json['idade'];
    matricula = json['matricula'];
    periodo = json['periodo'];
    senha = json['senha'];
    media = json['media'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nome'] = this.nome;
    data['idade'] = this.idade;
    data['matricula'] = this.matricula;
    data['periodo'] = this.periodo;
    data['senha'] = this.senha;
    data['media'] = this.media;

    return data;
  }
}