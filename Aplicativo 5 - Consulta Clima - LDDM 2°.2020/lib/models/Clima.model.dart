class Clima {
  String city_name;
  int temp;
  String description;
  int humidity;
  String wind_speedy;

  Clima(
      {this.city_name, this.temp, this.description, this.humidity, this.wind_speedy});

  Clima.fromJson(Map<String, dynamic> json) {
    city_name = json['city_name'];
    temp = json['temp'];
    description = json['description'];
    humidity = json['humidity'];
    wind_speedy = json['wind_speedy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['city_name'] = this.city_name;
    data['temp'] = this.temp;
    data['description'] = this.description;
    data['humidity'] = this.humidity;
    data['wind_speedy'] = this.wind_speedy;
    return data;
  }
}