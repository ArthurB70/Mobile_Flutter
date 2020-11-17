import 'package:app4SGA/repositories/Aluno.repository.dart';
import 'package:mobx/mobx.dart';
import 'package:app4SGA/models/Aluno.model.dart';

part 'Aluno.controller.g.dart';

class AlunoController = _AlunoController with _$AlunoController;
abstract class _AlunoController with Store{
 AlunoRepository repository;
 _AlunoController(){
  _init();
 }
 Future<void> _init() async {
  repository = await AlunoRepository.getInstance();
  await getAll();
 }

 @observable
 ObservableList<Aluno> list = ObservableList<Aluno>();
 @action
 Future<void> getAll() async {
  try {
    if(repository != null) {
      final allList = await repository.getAll();
      list.clear();
      list.addAll(allList);
  }
  
  }catch(e){
  
  }
 }
 @action
 Future<Aluno> getAlunoById(int id) async {
  try {
    if(repository != null) {
      final Aluno aluno = await repository.getById(id);
      return aluno;
  }
  
  }catch(e){
    final Aluno aluno = new Aluno(idade: -1,
                matricula: -1,
                periodo: -1,
                nome: "",
                media: -1,
                senha: "");
    return aluno;
  }
 }
 @action
 Future<void> create(Aluno p) async {
  try {
    await repository.create(p);
    await getAll();
  
  }catch(e){
  }
 }
 @action
 Future<void> update(Aluno p) async {
 
  try {
    await repository.update(p);
    await getAll();
 
  }catch(e){
  
  }
 }
 @action
 Future<void> delete(int id) async {
 
  try {
    await repository.delete(id);
    await getAll();

  }catch(e){
 
  }
  }
}
