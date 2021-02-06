import 'package:qib_assignment/Screens/Dashboard/dashboard_bloc.dart';
import 'package:qib_assignment/Screens/Dashboard/dashboard_provider.dart';
import 'package:qib_assignment/Screens/Dashboard/dashboard_state.dart';

abstract class DashboardEvent{
  Future<DashboardState> apply({DashboardState currentState, DashboardBloc bloc});
}

class DashboardLoadEvent extends DashboardEvent{
  @override
  Future<DashboardState> apply({DashboardState currentState, DashboardBloc bloc})async {
    return await  DashboardProvider().loadWeatherData(['Qatar','Delhi','Shimla']);
  }
  
}

class DashboardMultiLoadEvent extends DashboardEvent{
  @override
  Future<DashboardState> apply({DashboardState currentState, DashboardBloc bloc})async {
    return await  DashboardProvider().loadMultiWeatherData(['Qatar','Delhi','Shimla','New York','Dubai','London','Australia','Mumbai']);
  }

}