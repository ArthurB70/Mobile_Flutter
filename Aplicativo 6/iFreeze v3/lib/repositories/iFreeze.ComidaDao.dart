import 'package:floor/floor.dart';
import 'package:iFreeze/models/iFreeze.Comida.model.dart';

@dao
abstract class ComidaDao{

@Query('SELECT * FROM Comida order by nome')
Future<List<Comida>> getAll();

@Query("SELECT * from Comida where codigoGeladeira = :codigoGeladeira")
Future<List<Comida>> getComidaBycodigoGeladeira(int codigoGeladeira);

@Query("SELECT * from Comida where id = :id")
Future<Comida> getComidaByqrCode(int id);

@insert
Future<int> insertComida(Comida p);

@update
Future<int> updateComida(Comida p);

@delete
Future<int> deleteComida(Comida p);

}