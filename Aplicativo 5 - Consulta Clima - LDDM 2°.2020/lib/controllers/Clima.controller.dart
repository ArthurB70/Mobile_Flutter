import '../repositories/Clima.repository.dart';
import '../models/Clima.model.dart';

class ClimaController {
  ClimaRepository repositorio = new ClimaRepository(); 
  Clima retorno = Clima();
  
  Future<Clima> getClima(String cidade, String estado) async {
    try {
      Clima data = await repositorio.getClima(cidade, estado);
      return data;

    }catch(e){
      print("Erro2: "+ e.toString());
    }
  }  
}