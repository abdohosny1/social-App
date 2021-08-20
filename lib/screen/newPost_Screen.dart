import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cupit/social_cubit.dart';
import 'package:social_app/cubit/social_cupit/social_state.dart';
import 'package:social_app/style/colors.dart';
import 'package:social_app/style/const.dart';
import 'package:social_app/style/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
var textContoler=TextEditingController();
var now= DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
       builder : (context,state){
          var cubit=SocialCubit.get(context);
          var postImage=SocialCubit.get(context).postImage;

          return Scaffold(
          appBar: AppBar(
            title: Text('Creatr Post'),
            actions: [TextButton(
              onPressed: (){
                if(cubit.postImage==null){
                  cubit.createPost(dateTime: now.toString(), text: textContoler.text);
                }else{
                  cubit.uploadImagePost(dateTime: now.toString(), text: textContoler.text);
                }
              },
              child: Text('Post'),
            )
            ],
            leading: IconButton(onPressed: (){Navigator.pop(context);},icon: Icon(IconBroken.Arrow___Left_2),),

          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostImageLoadibngState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostImageLoadibngState)
                  SizedBox(height: 5,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${SocialCubit.get(context).model!.images}'),
                    ),
                    SizedBox(width: 15,),
                    Expanded(
            child: Text('${SocialCubit.get(context).model!.name}',style: TextStyle(height: 1.3),),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Expanded(
                  child: TextFormField(
                    controller: textContoler,
                    decoration: InputDecoration(
                        hintText: 'What is on your mind',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                if(cubit.postImage !=null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                           Radius.circular(4),
                          ),
                          image: DecorationImage(
                              image:FileImage(postImage!) as ImageProvider,
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        cubit.removePostImage();
                      //  cubit.getCoverImage();
                      },
                      icon: CircleAvatar(
                          radius: 20,
                          child: Icon(Icons.close,size: 18,color: Colors.green,)),
                    )
                  ],

                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(onPressed: (){
                        cubit.getPostImage();
                      },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(width: 5,),
                              Text('add photo')
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: (){},
                          child: Text('# tags')),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
       });
  }
}
