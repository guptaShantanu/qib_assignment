import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qib_assignment/Screens/Login/login_event.dart';
import 'package:qib_assignment/Screens/Login/login_model.dart';
import 'package:qib_assignment/Screens/Login/login_state.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{

  LoginModel loginModel = new LoginModel();

  LoginBloc(LoginState initialState) : super(initialState);

  LoginState get initialState => new LoginInitState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event)async* {
    try{
      yield LoginLoadingState(loadingMessage: "Loading");
      yield await event.apply(currentState: null,bloc: this);
    }catch(e){
      yield LoginErrorState(errorMessage: e.toString());
    }
  }

}