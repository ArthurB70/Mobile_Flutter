import 'package:floor/floor.dart';
import 'package:app4SGA/models/Aluno.model.dart';

@dao
abstract class AlunoDao{
  @Query('SELECT * FROM Aluno order by nome')
  Future<List<Aluno>> getAll();
  
  @Query("SELECT * from Aluno where matricula = :matricula")
  Future<Aluno> getAlunoById(int matricula);
  
  @insert
  Future<int> insertAluno(Aluno p);
  
  @update
  Future<int> updateAluno(Aluno p);
  
  @delete
  Future<int> deleteAluno(Aluno p);
}