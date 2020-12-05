import 'package:iFreeze/models/iFreeze.Geladeira.model.dart';
import 'package:iFreeze/repositories/iFreeze.GeladeiraDao.dart';
import 'package:iFreeze/repositories/iFreeze.Geladeira.database.dart';

class GeladeiraRepository {
  static GeladeiraRepository _instance;
  GeladeiraRepository._();

  AppDatabase database;
  GeladeiraDao geladeiraDao;

  static Future<GeladeiraRepository> getInstance() async {
    if (_instance != null) return _instance;
    _instance = GeladeiraRepository._();
    await _instance.init();
    return _instance;
  }

  Future<void> init() async {
    database = await $FloorAppDatabase.databaseBuilder('geladeira.db').build();
    geladeiraDao = database.geladeiraDao;
  }

  Future<List<Geladeira>> getAll() async {
    try {
      return await geladeiraDao.getAll();
    } catch (e) {
      return List<Geladeira>();
    }
  }

  Future<Geladeira> getBycodigoGeladeira(int codigoGeladeira) async {
    try {
      return await geladeiraDao.getGeladeiraBycodigoGeladeira(codigoGeladeira);
    } catch (e) {
      print('Erro: ' + e.toString());
    }
  }

  Future<bool> create(Geladeira p) async {
    try {
      await geladeiraDao.insertGeladeira(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> update(Geladeira p) async {
    try {
      await geladeiraDao.updateGeladeira(p);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> delete(int codigoGeladeira) async {
    try {
      Geladeira p =
          await geladeiraDao.getGeladeiraBycodigoGeladeira(codigoGeladeira);
      await geladeiraDao.deleteGeladeira(p);
      return true;
    } catch (e) {
      return false;
    }
  }
}
