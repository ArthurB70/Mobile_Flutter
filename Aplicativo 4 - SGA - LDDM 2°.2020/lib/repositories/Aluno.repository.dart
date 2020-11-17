import 'package:app4SGA/models/Aluno.model.dart';

import 'Aluno.dao.dart';
import 'Aluno.database.dart';


class AlunoRepository{
  static AlunoRepository _instance;
  AlunoRepository._();

  AppDatabase database;
  AlunoDao alunoDao;

  static Future<AlunoRepository> getInstance() async{
    if(_instance != null) return _instance;
    _instance = AlunoRepository._();
    await _instance.init();
    return _instance;
  }

  Future <void> init() async{
    database = await $FloorAppDatabase.databaseBuilder('aluno.db').build();
    alunoDao = database.alunoDao;
  }

  Future<List<Aluno>> getAll() async{
    try{
      return await alunoDao.getAll();
    }
    catch(e){
      return List<Aluno>();
    }
  }
    Future<Aluno> getById(int matricula) async{
    try{
      return await alunoDao.getAlunoById(matricula);
    }
    catch(e){
      print('Erro: '+ e.toString());
    }
    
  }
  Future <bool> create(Aluno p) async {
    try{
      await alunoDao.insertAluno(p);
      return true;
    }
    catch(e){
      return false;
    }
  }
  Future<bool> update(Aluno p) async {
    try{
      await alunoDao.updateAluno(p);
      return true;
    }
    catch(e){
      return false;
    }

  }
  Future<bool> delete(int id) async{
    try{
      Aluno p = await alunoDao.getAlunoById(id);
      await alunoDao.deleteAluno(p);
      return true;
    }
    catch(e){
      return false;
    }
  }


}