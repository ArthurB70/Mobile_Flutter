import 'package:iFreeze/models/iFreeze.Comida.model.dart';
import 'package:iFreeze/repositories/iFreeze.ComidaDao.dart';
import 'package:iFreeze/repositories/iFreeze.Comida.database.dart';

class ComidaRepository {
  static ComidaRepository _instance;
  ComidaRepository._();

  AppDatabase database;
  ComidaDao comidaDao;

  static Future<ComidaRepository> getInstance() async {
    if (_instance != null) return _instance;
    _instance = ComidaRepository._();
    await _instance.init();
    return _instance;
  }

  Future<void> init() async {
    database = await $FloorAppDatabase.databaseBuilder('comida.db').build();
    comidaDao = database.comidaDao;
  }

  Future<List<Comida>> getAll() async {
    try {
      return await comidaDao.getAll();
    } catch (e) {
      return List<Comida>();
    }
  }

  Future<List<Comida>> getBycodigoGeladeira(int codigoGeladeira) async {
    try {
      return await comidaDao.getComidaBycodigoGeladeira(codigoGeladeira);
    } catch (e) {
      print('Erro: ' + e.toString());
    }
  }

  Future<bool> create(Comida p) async {
    try {
      await comidaDao.insertComida(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update(Comida p) async {
    try {
      await comidaDao.updateComida(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(int id) async {
    try {
      Comida p = await comidaDao.getComidaByqrCode(id);
      await comidaDao.deleteComida(p);
      return true;
    } catch (e) {
      return false;
    }
  }
}
