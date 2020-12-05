import 'package:floor/floor.dart';
import 'package:iFreeze/models/iFreeze.Geladeira.model.dart';

@dao
abstract class GeladeiraDao{

@Query('SELECT * FROM Geladeira order by nome')
Future<List<Geladeira>> getAll();

@Query("SELECT * from Geladeira where codigoGeladeira = :codigoGeladeira")
Future<Geladeira> getGeladeiraBycodigoGeladeira(int codigoGeladeira);

@insert
Future<int> insertGeladeira(Geladeira p);

@update
Future<int> updateGeladeira(Geladeira p);

@delete  
Future<int> deleteGeladeira(Geladeira p);

}