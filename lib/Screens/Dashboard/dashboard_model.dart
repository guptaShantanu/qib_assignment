class DashboardModel{
  List<WeatherModel> cityTemps = [];
  List<WeatherModel> tableCityTemps = [];
}

class WeatherModel{
  String cityName;
  double temperature;
  String description;
  WeatherModel({this.cityName,this.temperature,this.description});
}