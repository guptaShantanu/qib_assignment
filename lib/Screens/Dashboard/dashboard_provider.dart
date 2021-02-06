import 'package:http/http.dart';
import 'package:qib_assignment/Screens/Dashboard/dashboard_model.dart';
import 'package:qib_assignment/Screens/Dashboard/dashboard_state.dart';
import 'package:qib_assignment/Utility/qib.dart';
import 'dart:convert';

class DashboardProvider{
  Future<DashboardState> loadWeatherData(List<String> cityName)async{

    try{
    DashboardModel dashboardModel = new DashboardModel();
   for(int i =0;i<cityName.length;i++){
     var res = await getWeather(cityName[i]);
     dashboardModel.cityTemps.add(res);
   }
    return DashboardLoadedState(dashboardModel: dashboardModel);
    }catch(e){
      print("Error Provider ${e.toString()}");
      return DashboardErrorState(errorMessage: '');
    }
  }

  Future<DashboardState> loadMultiWeatherData(List<String> cityName)async{

    try{
      DashboardModel dashboardModel = new DashboardModel();
      for(int i =0;i<cityName.length;i++){
        var res = await getWeather(cityName[i]);
        dashboardModel.tableCityTemps.add(res);
      }
      return DashboardLoadedState(dashboardModel: dashboardModel);
    }catch(e){
      print("Error Provider ${e.toString()}");
      return DashboardErrorState(errorMessage: '');
    }
  }

  Future<WeatherModel> getWeather(String cityName)async{
    const String baseurl = 'https://api.openweathermap.org/data/2.5/weather?';
    String mainUrlWeather = baseurl+'q='+cityName+'&'+'appid='+QIB.mapKey;
    var response = await get(mainUrlWeather);
    var data =await jsonDecode(response.body);
    print("Api response $data");
    String desc = data['weather'][0]['description'];
    double temp = data['main']['temp'];
    WeatherModel weatherModel = new WeatherModel(cityName: cityName,temperature: temp,description: desc);
    return weatherModel;
  }
}

