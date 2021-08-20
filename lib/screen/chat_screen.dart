import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cupit/social_cubit.dart';
import 'package:social_app/cubit/social_cupit/social_state.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/screen/chat_details.dart';
import 'package:social_app/screen/home_screen.dart';
import 'package:social_app/style/const.dart';

class ChatScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return   BlocConsumer<SocialCubit,SocialStates>(
      listener  : (context,state){},
       builder: (context,state){
        var cubit=SocialCubit.get(context);
        return ConditionalBuilder(
            condition: SocialCubit.get(context).users!.length >0,
            builder: (context)=>ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context,index)=>bulidChatItem(context,SocialCubit.get(context).users![index]),
              itemCount: SocialCubit.get(context).users!.length,
              separatorBuilder: ( context, index) =>mydivider(),
            ),
           fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
       });
  }
  Widget bulidChatItem(context,UserModel model)=> InkWell(
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder:(t)=>ChatDetailsScreen(model)));
    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('${model.images}'),
          ),
          SizedBox(width: 15,),
          Text('${model.name}',style: Theme.of(context).textTheme.caption!.copyWith(height: 1.3),),

        ],
      ),
    ),
  );
}
