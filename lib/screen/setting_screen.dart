import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cupit/social_cubit.dart';
import 'package:social_app/cubit/social_cupit/social_state.dart';
import 'package:social_app/screen/profile/edit_profile.dart';
import 'package:social_app/style/colors.dart';
import 'package:social_app/style/icon_broken.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          var model =SocialCubit.get(context);
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 200,
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0)
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${model.model!.cover}'),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                      ),
                      CircleAvatar(
                        radius: 65,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage('${model.model!.images}'),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Text('${model.model!.name}',style: Theme.of(context).textTheme.bodyText1,),
                Text('${model.model!.bio}',style: Theme.of(context).textTheme.caption,),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('100',style: Theme.of(context).textTheme.subtitle2,),
                              Text('Posts',style: Theme.of(context).textTheme.caption,),

                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('234',style: Theme.of(context).textTheme.subtitle2,),
                              Text('photos',style: Theme.of(context).textTheme.caption,),

                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('10K',style: Theme.of(context).textTheme.subtitle2,),
                              Text('Followers',style: Theme.of(context).textTheme.caption,),

                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text('23',style: Theme.of(context).textTheme.subtitle2,),
                              Text('Following',style: Theme.of(context).textTheme.caption,),

                            ],
                          ),
                          onTap: (){},
                        ),
                      ),
                    ],),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {  },
                        child: Text('Add Photos'),
                      ),
                    ),
                    SizedBox(width: 10,),
                    OutlinedButton(
                        onPressed: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: (y)=>EditProfile()));
                        },
                        child: Icon(IconBroken.Edit,size: 16,)
                    )
                  ],
                ),
                Row(
                  children: [
                    OutlineButton(onPressed: (){
                      FirebaseMessaging.instance.subscribeToTopic('announcements');
                    },
                    child: Text('Subscribe',style: TextStyle(color: defultColor),),),
                    SizedBox(width: 20,),
                    OutlineButton(onPressed: (){
                      FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                    },
                    child: Text('UnSubscribe',style: TextStyle(color: defultColor),),),
                  ],
                )
              ],
            ),
          );
        },

    );
  }
}
