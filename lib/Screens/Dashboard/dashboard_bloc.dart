import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qib_assignment/Screens/Dashboard/dashboard_event.dart';
import 'package:qib_assignment/Screens/Dashboard/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent,DashboardState>{

  DashboardBloc(DashboardState initialState) : super(initialState);

  DashboardState get initialState => new DashboardLoadingState();

  @override
  Stream<DashboardState> mapEventToState(DashboardEvent event)async* {
    try{
      yield DashboardLoadingState();
      yield await event.apply(currentState: null,bloc: this);
    }catch(e){
      yield DashboardErrorState(errorMessage: e.toString());
    }
  }
}