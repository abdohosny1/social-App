import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cupit/social_cubit.dart';
import 'package:social_app/cubit/social_cupit/social_state.dart';
import 'package:social_app/model/post_model.dart';
import 'package:social_app/style/colors.dart';
import 'package:social_app/style/const.dart';
import 'package:social_app/style/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
var commentControler=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          var cubit=SocialCubit.get(context);
          return ConditionalBuilder(
              condition: cubit.posts!.length>0 &&cubit.model!=null,
              builder: (context) =>SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 10,
                      margin: EdgeInsets.all(8),
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Image(
                            image: NetworkImage('https://image.freepik.com/free-photo/horizontal-shot-smiling-curly-haired-woman-indicates-free-space-demonstrates-place-your-advertisement-attracts-attention-sale-wears-green-turtleneck-isolated-vibrant-pink-wall_273609-42770.jpg'),
                            fit: BoxFit.cover,
                            height: 200,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('communicate with friend',style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.white),),
                          )
                        ],
                      ),
                    ),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index)=>bulidPostItem(cubit.posts![index],context,index),
                      itemCount:cubit.posts!.length,
                      separatorBuilder: (context,index) =>SizedBox(height: 10,),
                    ),
                    SizedBox(height: 10,),

                  ],

                ),
              ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
          );
        });
  }

  Widget bulidPostItem(PostModel model,context,index) =>  Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    margin: EdgeInsets.symmetric(horizontal: 8),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //create head of the post
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${model.images}'),
              ),
              SizedBox(width: 15,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('${model.name}',style: TextStyle(height: 1.3),),
                        SizedBox(width: 5,),
                        Icon(Icons.check_circle,color: defultColor,size: 16,),
                        //  Spacer(),

                      ],
                    ),
                    Text('${model.dateTime}',style: Theme.of(context).textTheme.caption!.copyWith(height: 1.3),),


                  ],
                ),
              ),
              SizedBox(width: 15,),
              IconButton(
                icon:Icon(Icons.more_horiz_outlined,size: 16),
                onPressed: (){},)
            ],
          ),
          //create devider
          Padding(
            padding: const EdgeInsets.only(top: 5,bottom: 10),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],

            ),
          ),
          // crate text on the post
          Text('${model.text}',
            style: Theme.of(context).textTheme.subtitle1!.copyWith(height: 1.4,fontSize: 14),),
          // create #

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container
              (
              width: double.infinity,
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: Container(
                      height: 20,
                      child: MaterialButton(onPressed: (){},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text('#Software',style: TextStyle(color: defultColor),),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10),
                    child: Container(
                      height: 20,
                      child: MaterialButton(onPressed: (){},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: Text('#flutter',style: TextStyle(color: defultColor),),),
                    ),
                  ),

                ],
              ),
            ),
          ),
          if(model.PostImage !='')
          //create photon on the post
             Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Container(
              width: double.infinity,
              height: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                      image: NetworkImage('${model.PostImage}'),
                      fit: BoxFit.cover
                  )
              ),
            ),
          ),
          //like and comment
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,),
                        child: Row(

                          children: [
                            Icon(IconBroken.Heart,color:defultColor,size: 16,),
                            SizedBox(width: 5,),
                            Text('${SocialCubit.get(context).likes[index]}',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                      onTap: (){}
                  ),
                ),
                Expanded(
                  child: InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,

                          children: [
                            Icon(Icons.comment,color:defultColor,size: 16,),
                            SizedBox(width: 5,),
                            Text('${SocialCubit.get(context).comments[index]} comment',style: Theme.of(context).textTheme.caption,),
                          ],
                        ),
                      ),
                      onTap: (){}
                  ),
                ),
              ],
            ),
          ),
          SizedBox(),
          //crete devider
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[300],

            ),
          ),
          //create comment
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: NetworkImage('${SocialCubit.get(context).model!.images}'),
                      ),
                      SizedBox(width: 15,),
                      Expanded(
                        child: TextFormField(
                          controller: commentControler,
                              decoration: InputDecoration(
                                hintText: 'write a comment',
                                border: InputBorder.none,
                              ),
                            ),
                      ),
                      SizedBox(width: 5,),
                      IconButton(onPressed: (){
                        SocialCubit.get(context).commentPost(SocialCubit.get(context).postid[index], commentControler.text);
                        commentControler.text='write comment';
                      }, icon: Icon(Icons.send,color: defultColor,size: 20,))
                     // Text('write a comment ...', style: Theme.of(context).textTheme.caption!.copyWith(),),
                    ],
                  ),
                  onTap: (){
                    // showBottomSheet(
                    //     context: context,
                    //     builder: (context){
                    //       return Container(
                    //      //   width: double.infinity,
                    //        // height: 300,
                    //         child: Column(
                    //           children: [
                    //             Expanded(
                    //               child: Row(
                    //                 children: [
                    //                   TextFormField(
                    //                     decoration: InputDecoration(
                    //                         hintText: 'Write comment'
                    //                     ),
                    //                   ),
                    //                   IconButton(onPressed: (){},
                    //                       icon:Icon (Icons.arrow_back_ios_outlined)
                    //                   )
                    //                 ],
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       );
                    //     }
                    // );

                  },
                ),
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10,),
                  child: Row(

                    children: [
                      Icon(IconBroken.Heart,color:defultColor,size: 16,),
                      SizedBox(width: 5,),
                      Text('Like',style: Theme.of(context).textTheme.caption,),
                    ],
                  ),
                ),
                onTap: (){
                  SocialCubit.get(context).likePost(SocialCubit.get(context).postid[index]);
                },
              ),


            ],
          ),


        ],
      ),
    ),
  );
}
