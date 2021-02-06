import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{
  LoginState getStateCopy();
}

class LoginInitState extends LoginState{
  @override
  LoginState getStateCopy() {
    return LoginInitState();
  }

  @override
  // TODO: implement props
  List<Object> get props => [null];
}

class LoginLoadingState extends LoginState{
  final String loadingMessage;

  LoginLoadingState({this.loadingMessage=""});
  @override
  LoginState getStateCopy() {
    // TODO: implement getStateCopy
    throw LoginLoadingState();
  }

  @override
  // TODO: implement props
  List<Object> get props => [loadingMessage];

}

class LoginSuccessState extends LoginState{
  @override
  LoginState getStateCopy() {
    // TODO: implement getStateCopy
    return LoginSuccessState();
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}


class LoginErrorState extends LoginState{
  final String errorMessage;
  LoginErrorState({this.errorMessage});

  @override
  LoginState getStateCopy() {
    return LoginErrorState();
  }

  @override
  // TODO: implement props
  List<Object> get props => [this.errorMessage];

}