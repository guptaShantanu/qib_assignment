import 'package:qib_assignment/Screens/Login/login_bloc.dart';
import 'package:qib_assignment/Screens/Login/login_state.dart';

abstract class LoginEvent{
  Future<LoginState> apply({LoginState currentState, LoginBloc bloc});
}

class LoginStartEvent extends LoginEvent{
  @override
  Future<LoginState> apply({LoginState currentState, LoginBloc bloc}) async{
   await Future.delayed(Duration(seconds: 3));
  if(bloc.loginModel.varifyPhone()){
    return LoginSuccessState();
  }else{
    return LoginErrorState(errorMessage:'Phone should be 10 char long ');
  }
  }

}

class LoginInitEvent extends LoginEvent{
  @override
  Future<LoginState> apply({LoginState currentState, LoginBloc bloc})async {
    // TODO: implement apply
    // Future.delayed(Duration(milliseconds: 100))
   return LoginInitState();
  }

}