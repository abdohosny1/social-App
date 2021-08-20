import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/login_cubit/login_state.dart';
import 'package:flutter/material.dart';

class LoginCubit extends Cubit<LoginState>{
  LoginCubit () :super(LoginInitiliteState());
  static LoginCubit get (contxet)=>BlocProvider.of(contxet);


  void getUser({required String email,required String password}){
    emit(LoginLoadingState());
    
  try{
    FirebaseAuth.instance.signInWithEmailAndPassword
      (email: email,
        password: password).then((value) {
      emit(LoginScussesState(value.user!.uid));

    }).catchError((e){
      emit(LoginErrorState(e.toString()));

    });

  }on FirebaseAuthException catch(e){

    }
  }
  
late  IconData supifx=Icons.visibility_outlined;
bool isSow=true;

void changeIcon(){
  isSow=!isSow;
  supifx=isSow ?Icons.visibility_outlined:Icons.visibility_off_outlined;
  emit(LoginVisibilityState());
  
}
}