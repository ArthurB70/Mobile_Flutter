import 'package:flutter/foundation.dart';
import 'package:iFreeze/models/iFreeze.Geladeira.model.dart';
import 'package:iFreeze/repositories/iFreeze.Geladeira.repository.dart';

class GeladeiraController extends ChangeNotifier {
  GeladeiraRepository repository;
  List<Geladeira> lista_geladeira = new List<Geladeira>();

  GeladeiraController() {
    _init();
  }

  Future<void> _init() async {
    repository = await GeladeiraRepository.getInstance();
    await getAll();
    notifyListeners();
  }

  Future<void> getAll() async {
    try {
      if (repository != null) {
        lista_geladeira = await repository.getAll();
        notifyListeners();
      }
    } catch (e) {
      print('Erro: ' + e.toString());
    }
  }

  Future<void> create(Geladeira p) async {
    try {
      await repository.create(p);
      await getAll();
      notifyListeners();
    } catch (e) {
      print('Erro: ' + e.toString());
    }
  }

  Future<void> update(Geladeira p) async {
    try {
      await repository.update(p);
      await getAll();
      notifyListeners();
    } catch (e) {
      print('Erro: ' + e.toString());
    }
  }

  Future<void> delete(int codigoGeladeira) async {
    try {
      await repository.delete(codigoGeladeira);
      await getAll();
      notifyListeners();
    } catch (e) {
      print('Erro: ' + e.toString());
    }
  }
}
