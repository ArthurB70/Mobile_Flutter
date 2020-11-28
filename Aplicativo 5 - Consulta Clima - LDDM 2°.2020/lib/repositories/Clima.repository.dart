import 'dart:convert';

import '../models/Clima.model.dart';
import 'package:http/http.dart' as http;

class ClimaRepository{

  var url = 'https://api.hgbrasil.com/weather?fields=only_results,temp,city_name,description,humidity,wind_speedy&key=126223d1&city_name=';
  
  Future<Clima> getClima(String cidade, String estado) async{
    final response = await http.get(url + cidade + ", " + estado);
    if(response.statusCode == 200){
        Clima data = Clima.fromJson(json.decode(response.body));
        return data;       
    }
    else{
      throw Exception("Erro de conexão com o servidor!");
    }

  }
}