import 'package:Lista/models/Item.models.dart';
import 'package:Lista/repository/item.repository.dart';

class ItemController{

  List<Item> list = new List<Item>();
  ItemRepository repository = new ItemRepository();

  Future<void> getAll() async {
    try {
      final allList = await repository.readData();
      list.clear();
      list.addAll(allList);
      sort();
    }catch(e){
      print("Erro: "+ e.toString());
    }
  }

  Future<void> create(Item item) async {
    try {
      list.add(item);
      await update();
    }catch(e){
      print("Erro: "+ e.toString());
    }
  }

  Future<void> delete(int id) async {
    try {
      list.removeAt(id);
      await update();
    }catch(e){
      print("Erro: "+ e.toString());
    }
  }

  void update() async{
    await repository.saveData(list);
    await getAll();
  }

  Future<void>  updateList(List<Item> lista) async{
    await repository.saveData(lista);
    await getAll();
  }

  void sort(){
    list.sort((a, b){
      if(a.concluido&& !b.concluido) return 1;
      else if(!a.concluido && b.concluido) return -1;
      else return 0;
    });
  }
}