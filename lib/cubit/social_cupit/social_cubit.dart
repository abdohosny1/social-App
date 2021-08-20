import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/social_cupit/social_state.dart';
import 'package:social_app/model/massage_model.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/screen/chat_screen.dart';
import 'package:social_app/screen/feeds_screen.dart';
import 'package:social_app/screen/newPost_Screen.dart';
import 'package:social_app/screen/setting_screen.dart';
import 'package:social_app/screen/users_screen.dart';
import 'package:social_app/style/const.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>{

  SocialCubit():super(SocialInitiliteStates());

  static SocialCubit get(context)=>BlocProvider.of(context);


  int current_index=0;
  List<Widget> items=[
    FeedsScreen(),
    ChatScreen(),
    NewPostScreen(),
    UserScreen(),
    SettingScreen()
  ];
  List<String> title=[
    ' Home',
    'Chat',
    'Post',
    'Users',
    'Setting',
  ];
  void changebottom(int index){
if(index ==1)
  getAllUsers();
    if(index==2){
      emit(SocialAddNewPostState());
    }else{
      current_index=index;
      emit(SocialChangeBootomState());

    }
  }

     UserModel? model;
   void getUserData(){
     emit(SocialGetUserLoadingState());

     FirebaseFirestore.instance.collection('users').doc(UID)
         .get().then((value) {
           print(value.data());
           model=UserModel.fromjson((value.data())!);
       emit(SocialGetUserScussesState());

     })
         .catchError((e){
       emit(SocialGetUserErrorState(e.toString()));
     });
   }



   File ? profileImage;
  var picker=ImagePicker();

  Future <void>getProfileImage()async{
  final pickedfile=await picker.pickImage(source: ImageSource.gallery);
  //  final pickedfile=await picker.getImage(source: ImageSource.gallery);

    if(pickedfile !=null){
      profileImage=File(pickedfile.path);
      emit(SocialProfileImageScussesState());
    }else{
      emit(SocialProfileImageErrorState());
    }

  }


  File ? coverImage;

  Future <void>getCoverImage()async{
    final pickedfile=await picker.pickImage(source: ImageSource.gallery);
    //  final pickedfile=await picker.getImage(source: ImageSource.gallery);

    if(pickedfile !=null){
      coverImage=File(pickedfile.path);
      emit(SocialCoverImageScussesState());
    }else{
      emit(SocialCoverImageErrorState());
    }

  }


  void uploadProfileImage({ required String name,
    required String phone,
    required String bio, profile,}){
    emit(SocialUploadProfileImageLoadibngState());

    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref.getDownloadURL().then((value) {
            print(value);
           updateUserData(name: name, phone: phone, bio: bio,profile: value);
          //  emit(SocialUploadProfileImageScussesState());
          }).catchError((e){  emit(SocialUploadProfileImageErrorState());
          });
    }).catchError((e){
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({required String name,
    required String phone,
    required String bio,}){
    emit(SocialUploadProfileImageLoadibngState());

    firebase_storage.FirebaseStorage.instance.ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
       updateUserData(name: name, phone: phone, bio: bio,cover: value);
       // emit(SocialUploadCoverImageScussesState());
      }).catchError((e){  emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((e){
      emit(SocialUploadProfileImageErrorState());
    });
  }




  void updateUserData(
      {
    required String name,
    required String phone,
    required String bio,
     String? cover,
     String? profile,
  }){
  //  emit(SocialUploadProfileImageLoadibngState());

    UserModel modell=UserModel
      (name: name,
      phone: phone,
      bio: bio,
      cover:cover ?? model!.cover,
      images:profile ?? model!.images,
      uid: model!.uid,
      email: model!.email,
      isEmailVerfied: false,
    );
    FirebaseFirestore.instance.collection('users').doc(model!.uid).update(modell.tomap())
        .then((value) {
      getUserData();

    }).catchError((e){
      print(e.toString());
      SocialUpdateUserErrorState(e.toString());

    });
  }

  File ? postImage;

  Future <void>getPostImage()async{
    final pickedfile=await picker.pickImage(source: ImageSource.gallery);
    //  final pickedfile=await picker.getImage(source: ImageSource.gallery);

    if(pickedfile !=null){
      postImage=File(pickedfile.path);
      emit(SocialPostImageScussesState());
    }else{
      emit(SocialPostImageErrorState());
    }

  }
  void removePostImage(){
    postImage=null;
    emit(SocialRemovePostImageErrorState());
  }



  void uploadImagePost({

    required String dateTime,
    required String text,}){
    emit(SocialCreatePostImageLoadibngState());

    firebase_storage.FirebaseStorage.instance.ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createPost(
          text: text,
          dateTime: dateTime,
          imagePost: value,
        );

      }).catchError((e){
        emit(SocialCreatePostErrorState(e.toString()));
      });
    }).catchError((e){
      emit(SocialCreatePostErrorState(e.toString()));
    });
  }


  void createPost(
      {

        required String dateTime,
        required String text,
         String? imagePost,
      }){
     emit(SocialCreatePostImageLoadibngState());

PostModel postModel= PostModel(
  images: model!.images,
  name: model!.name,
  uid: model!.uid,
  dateTime: dateTime,
  text: text,
  PostImage:imagePost ?? ''

);
    FirebaseFirestore.instance.collection('posts')
        .add(postModel.tomap())
        .then((value) {
          emit(SocialCreatePostImageScussesState());

    }).catchError((e){
      print(e.toString());
      SocialCreatePostErrorState(e.toString());

    });
  }

  List<PostModel>? posts=[];
  List<String>postid=[];
  List<int>likes=[];
  List<int>comments=[];
  void numcomment(){
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference
                .collection('comment')
                .get()
                .then((value) {
              comments.add(value.docs.length);
emit(SocialCommentPOstUserScussesState());
            }).catchError((e){
              emit(SocialCommentPostUserErrorState(e.toString()));

            });
          });
    }).catchError((e){});
  }

  void getPosts(){
    FirebaseFirestore.instance.collection('posts')
        .get()
        .then((value) {

          value.docs.forEach((element) {
            element.reference.collection('like')
            .get()
            .then((value) {
              likes.add(value.docs.length);
              posts!.add(PostModel.fromjson(element.data()));
              postid.add(element.id);
              numcomment();
            })
            .catchError((e){});

          });

      emit(SocialGetPOstUserScussesState());

    })
        .catchError((e){
       emit(SocialGetPostUserErrorState(e.toString()));
    });
  }

  void likePost(String postId){

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('like')
        .doc(model!.uid)
        .set({
      'like':true,

    }).then((value) {
      emit(SocialLikePOstUserScussesState());
    })
        .catchError((e){
          emit(SocialLikePostUserErrorState(e.toString()));

    });
  }

  void commentPost(String postId,String comment){

    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .doc(model!.uid)
        .set({
      'comment':comment,

    }).then((value) {
      emit(SocialCommentPOstUserScussesState());
    })
        .catchError((e){
      emit(SocialCommentPostUserErrorState(e.toString()));

    });
  }

  List<UserModel>? users=[];
  void getAllUsers(){
    if(users!.length==0)
    FirebaseFirestore.instance.collection('users').get().then((value) {

      value.docs.forEach((element) {
        if(element.data()['uid'] != model!.uid)
        users!.add(UserModel.fromjson(element.data()));

      });
      print('user is = ${users}');


      emit(SocialGetAllUserScussesState());

    })
        .catchError((e){
      emit(SocialGetAllUserErrorState(e.toString()));
    });
  }
  void sendMassage({
  required String reciverid,
  required String datatime,
  required String text,
})
  {
    MassageModel massageModel=MassageModel(
      text: text,
      datetime: datatime,
      reciverid: reciverid,
      senderid: model!.uid,
    );
    FirebaseFirestore.instance
    .collection('users')
    .doc(model!.uid)
    .collection('chats')
    .doc(reciverid)
    .collection('massage')
    .add(massageModel.toMap())
    .then((value) {
      emit(SocialSendMassageScussesState());

    }).catchError((e){
      emit(SocialSendMassageErrorState(e.toString()));

    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(reciverid)
        .collection('chats')
        .doc(model!.uid)
        .collection('massage')
        .add(massageModel.toMap())
        .then((value) {
      emit(SocialSendMassageScussesState());

    }).catchError((e){
      emit(SocialSendMassageErrorState(e.toString()));

    });

  }

  List<MassageModel> massages=[];

  void getMassage({required String reciverid}) {
    FirebaseFirestore.instance
    .collection('users')
    .doc(model!.uid)
    .collection('chats')
    .doc(reciverid)
    .collection('massage')
    .orderBy('datetime')
    .snapshots()
        .listen((event) {
          massages=[];
          event.docs.forEach((element) {
            massages.add(MassageModel.fromJson(element.data()));
          });
          emit(SocialGetMassageScussesState());
    });
  }
}