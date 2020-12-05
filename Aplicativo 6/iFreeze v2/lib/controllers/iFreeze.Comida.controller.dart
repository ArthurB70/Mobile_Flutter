import 'package:flutter/foundation.dart';
import 'package:iFreeze/models/iFreeze.Comida.model.dart';
import 'package:iFreeze/repositories/iFreeze.Comida.repository.dart';

class ComidaController extends ChangeNotifier {
  ComidaRepository repository;
  List<Comida> lista_comida = new List<Comida>();

  ComidaController() {
    _init();
  }
  Future<void> _init() async {
    repository = await ComidaRepository.getInstance();
    getAll();
  }

  Future<void> getAll() async {
    try {
      if (repository != null) {
        lista_comida = await repository.getAll();
        notifyListeners();
      }
    } catch (e) {
      print('Erro: ' + e.toString());
    }
  }

  Future<void> create(Comida p, int codigoGeladeira) async {
    try {
      await repository.create(p);
      await getAll();
      notifyListeners();
    } catch (e) {
      print('Erro: ' + e.toString());
    }
  }

  Future<void> update(Comida p, int codigoGeladeira) async {
    try {
      await repository.update(p);
      await getAll();
      notifyListeners();
    } catch (e) {
      print('Erro: ' + e.toString());
    }
  }

  Future<void> delete(int qrCode, int codigoGeladeira) async {
    try {
      await repository.delete(qrCode);
      await getAll();
      notifyListeners();
    } catch (e) {
      print('Erro: ' + e.toString());
    }
  }
}
