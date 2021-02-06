

import 'package:equatable/equatable.dart';
import 'package:qib_assignment/Screens/Dashboard/dashboard_model.dart';

abstract class DashboardState extends Equatable{
  DashboardState getStateCopy();
}

class DashboardLoadingState extends DashboardState{
  @override
  DashboardState getStateCopy() {
    // TODO: implement getStateCopy
    return  DashboardLoadingState();
  }

  @override
  // TODO: implement props
  List<Object> get props => [null];
}


class DashboardLoadedState extends DashboardState{
  DashboardModel dashboardModel;
  DashboardLoadedState({this.dashboardModel});
  @override
  DashboardState getStateCopy() {
    // TODO: implement getStateCopy
    return  DashboardLoadedState();
  }

  @override
  // TODO: implement props
  List<Object> get props => [null];
}

class DashboardErrorState extends DashboardState{
  String errorMessage;
  DashboardErrorState({this.errorMessage});
  @override
  DashboardState getStateCopy() {
    return  DashboardErrorState();
  }

  @override
  List<Object> get props => [errorMessage];
}

