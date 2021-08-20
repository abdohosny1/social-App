
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cupit/social_cubit.dart';
import 'package:social_app/cubit/social_cupit/social_state.dart';
import 'package:social_app/screen/login_screen.dart';
import 'package:social_app/screen/newPost_Screen.dart';
import 'package:social_app/style/colors.dart';
import 'package:social_app/style/const.dart';
import 'package:social_app/style/icon_broken.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){
          if(state is SocialAddNewPostState){
            Navigator.of(context).push(MaterialPageRoute(builder: (c)=>NewPostScreen()));
          }
        },
        builder: (context,state){
          var cubit= SocialCubit.get(context);
        //  var model=SocialCubit.get(context).model;
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.title[cubit.current_index]),
              actions: [
                IconButton(onPressed: (){}, icon: Icon(IconBroken.Notification)),
                IconButton(onPressed: (){}, icon: Icon(IconBroken.Search)),
              ],
            ),
             body:cubit.items[cubit.current_index],
            //ConditionalBuilder(
            //   condition: cubit.model !=null,
            //   builder: (context){
            //
            //
            //     return
            //     //   Column(
            //     //   children: [
            //     //    // if( !model!.isEmailVerfied)
            //     //    //  if( ! FirebaseAuth.instance.currentUser!.emailVerified)
            //     //    //  Container(
            //     //    //    color: Colors.amber.withOpacity(.6),
            //     //    //    height: 50,
            //     //    //    child: Padding(
            //     //    //      padding: const EdgeInsets.symmetric(horizontal: 20),
            //     //    //      child: Row(
            //     //    //        children: [
            //     //    //          Icon(Icons.info_outline),
            //     //    //          SizedBox(width: 15,),
            //     //    //          Expanded(child: Text('please verify your email')),
            //     //    //          SizedBox(width: 20,),
            //     //    //          TextButton(
            //     //    //            // shape: RoundedRectangleBorder(
            //     //    //            //   borderRadius: BorderRadius.all(Radius.circular(1)),
            //     //    //            // ),
            //     //    //            // color: Colors.white,
            //     //    //            // splashColor: Colors.black26,
            //     //    //            // textColor: Colors.black,
            //     //    //            child: Text('Send Email',style: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold),),
            //     //    //            onPressed: (){
            //     //    //              FirebaseAuth.instance.currentUser!
            //     //    //                  .sendEmailVerification().then((value) {
            //     //    //                    ScaffoldMessenger.of(context).
            //     //    //                    showSnackBar(SnackBar(content: Text('Check your Email')));
            //     //    //              }).catchError((e){
            //     //    //
            //     //    //              });
            //     //    //            },
            //     //    //          )
            //     //    //        ],
            //     //    //      ),
            //     //    //    ),
            //     //    //  ),
            //     //
            //     //
            //     //   ],
            //     // );
            //
            //   },
            //   fallback: (context)=>Center(child: CircularProgressIndicator()),
            //
            // ),
            bottomNavigationBar:  BottomNavigationBar(
              currentIndex: cubit.current_index,
              onTap: (item){
                cubit.changebottom(item);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chat'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Post'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'User'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Setting,),label: 'Setting'),
              ],
            ),

          );
        },);
  }
}
