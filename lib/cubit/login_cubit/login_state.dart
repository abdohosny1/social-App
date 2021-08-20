abstract class LoginState{}

class LoginInitiliteState extends LoginState{}

class LoginLoadingState extends LoginState{}
class LoginScussesState extends LoginState{
  final String uid;

  LoginScussesState(this.uid);

}
class LoginErrorState extends LoginState{
  final String error;

  LoginErrorState(this.error);

}

class LoginVisibilityState extends LoginState{}
