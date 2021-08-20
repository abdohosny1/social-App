import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/cubit/register_cubit/registerStates.dart';
import 'package:social_app/model/user_model.dart';

class RegisterCubit extends Cubit<RegisterState>{

  RegisterCubit() :super(RegisterInitliaState());

  static RegisterCubit get(contxet)=>BlocProvider.of(contxet);
String uid='';

  void userLogin({required String email,required String password,required String name,required String phone,var image,context}){
    emit(RegisterLoadingState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      uid=value.user!.uid;

      userCreate(
          uid: value.user!.uid,
          email: email,
          phone: phone,
          name: name,

      );
    //  emit(RegisterScussState());
    }).catchError((e){
      emit(RegisterErrorState(e.toString()));
    }) ;

  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uid, })
  {
    UserModel model=UserModel
      (name: name,
        phone: phone,
        email: email,
        uid: uid,
        bio: 'write you bio ...',
        isEmailVerfied: false,
        cover: 'https://image.freepik.com/free-photo/diverse-people-showing-speech-bubble-symbols_53876-71514.jpg',
        images: 'https://image.freepik.com/free-photo/close-up-young-handsome-man-isolated_273609-35788.jpg');

    FirebaseFirestore.instance.collection('users').doc(uid).set(model.tomap())
        .then((value) {
          emit(CrearUserScussState(uid));

    }).catchError((e){
      emit(CrearUserErrorState(e.toString()));

    });
  }





IconData sufx=Icons.visibility_outlined;
  bool isPasswordShow=true;
  void cahangePasswordVisibilty(){
    isPasswordShow=!isPasswordShow;
    sufx=isPasswordShow? Icons.visibility_outlined :Icons.visibility_off_outlined;
    emit(RegisterPasswordState());
  }
}