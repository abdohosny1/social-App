
abstract class RegisterState{}
class RegisterInitliaState extends RegisterState{}

class RegisterLoadingState extends RegisterState{}
class RegisterScussState extends RegisterState{}
class RegisterErrorState extends RegisterState{
  late String error;
  RegisterErrorState(this.error);

}


class CrearUserLoadingState extends RegisterState{}
class CrearUserScussState extends RegisterState{
  String uid;
  CrearUserScussState(this.uid);
}
class CrearUserErrorState extends RegisterState{
  late String error;
  CrearUserErrorState(this.error);

}

class RegisterPasswordState extends RegisterState{}
