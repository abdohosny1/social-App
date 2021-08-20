
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/social_cupit/social_cubit.dart';
import 'package:social_app/cubit/social_cupit/social_state.dart';
import 'package:social_app/style/colors.dart';
import 'package:social_app/style/const.dart';
import 'package:social_app/style/icon_broken.dart';

class EditProfile extends StatelessWidget {
var nameControlrer=TextEditingController();
var bioControlrer=TextEditingController();
var emaillControlrer=TextEditingController();
var phoneControlrer=TextEditingController();


var keyform=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=SocialCubit.get(context);
       var profileImage=SocialCubit.get(context).profileImage;
       var coverImage=SocialCubit.get(context).coverImage;

        nameControlrer.text=cubit.model!.name;
        bioControlrer.text=cubit.model!.bio;
        phoneControlrer.text=cubit.model!.phone;
        emaillControlrer.text=cubit.model!.email;

        return  Scaffold
          (
            appBar: AppBar(
              title: Text('Edit Profile'),
              titleSpacing: 5.0,
              leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(IconBroken.Arrow___Left_2),),
              actions: [
                TextButton(onPressed: (){
                  if(keyform.currentState!.validate()){
                    cubit.updateUserData(name: nameControlrer.text,
                        phone: phoneControlrer.text,
                        bio: bioControlrer.text);

                  }
                },
                    child: Text('Update')),
                SizedBox(width: 15,)
              ],
            ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Form(
                key: keyform,
                child: Column(
                  children: [
                    if(state is SocialUploadProfileImageLoadibngState)
                    LinearProgressIndicator(),
                    if(state is SocialUploadProfileImageLoadibngState)
                      SizedBox(height: 10,),
                    Container(
                      height: 200,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(

                             child: Stack(
                               alignment: AlignmentDirectional.topEnd,
                               children: [
                                  Container(
                                    width: double.infinity,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4.0),
                                            topRight: Radius.circular(4.0)
                                        ),
                                        image: DecorationImage(
                                            image:coverImage ==null? NetworkImage('${cubit.model!.cover}') :FileImage(coverImage) as ImageProvider,
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      cubit.getCoverImage();
                                    },
                                    icon: CircleAvatar(
                                        radius: 20,
                                        child: Icon(IconBroken.Camera,size: 18,color: Colors.green,)),
                                  )
                                ],

                              ),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 65,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 60,
                                   backgroundImage:
                                   //NetworkImage('${cubit.model!.images}')
                                  profileImage == null ? NetworkImage('${cubit.model!.images}') : (FileImage(profileImage)) as ImageProvider,
                                ),
                              ),
                              IconButton(onPressed: (){
                                SocialCubit.get(context).getProfileImage();
                              },
                                  icon: CircleAvatar(
                                    radius: 20,
                                      child: Icon(IconBroken.Camera,size: 18,color: Colors.green,)))
                            ],
                          ),
                        ],
                      ),
                    ),
                    if(cubit.profileImage != null || cubit.coverImage !=null)
                    Row(children: [
                      if(cubit.profileImage !=null)
                      Expanded(
                        child: Column(
                          children: [
                            RaisedButton(onPressed: (){
                              cubit.uploadProfileImage(name: nameControlrer.text,
                                  phone: phoneControlrer.text,
                                  bio: bioControlrer.text,

                              );
                            },
                              child: Text('Upload Profile'),
                              color: defultColor,
                              textColor: Colors.white,
                              splashColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                      ),
                            if(state is SocialUploadProfileImageLoadibngState)
                              SizedBox(height: 5,),
                            if(state is SocialUploadProfileImageLoadibngState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                      SizedBox(width: 10,),
                      if(cubit.coverImage !=null)
                      Expanded(
                        child: Column(
                          children: [
                            RaisedButton(onPressed: (){
                              cubit.uploadCoverImage(name: nameControlrer.text,
                                phone: phoneControlrer.text,
                                bio: bioControlrer.text,

                              );
                            },
                              child: Text('Upload Cover'),
                              color: defultColor,
                              textColor: Colors.white,
                              splashColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                      ),
                            if(state is SocialUploadProfileImageLoadibngState)
                              SizedBox(height: 5,),
                            if(state is SocialUploadProfileImageLoadibngState)
                              LinearProgressIndicator(),
                          ],
                        ),
                      ),
                    ],),
                    SizedBox(height: 20,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      controller: nameControlrer,
                      keyboardType: TextInputType.name,
                      decoration:InputDecoration(
                        labelText: 'Name',
                        prefixIcon: Icon(IconBroken.User),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'bio must not be empty';
                        }
                        return null;
                      },
                      maxLines: 2,
                      controller: bioControlrer,
                      keyboardType: TextInputType.name,
                      decoration:InputDecoration(
                          labelText: 'Bio',
                          prefixIcon: Icon(IconBroken.Info_Circle),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Phone must not be empty';
                        }
                        return null;
                      },
                      controller: phoneControlrer,
                      keyboardType: TextInputType.phone,
                      decoration:InputDecoration(
                          labelText: 'Phone',
                          prefixIcon: Icon(Icons.phone_enabled_outlined),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
