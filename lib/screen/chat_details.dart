import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cupit/social_cubit.dart';
import 'package:social_app/cubit/social_cupit/social_state.dart';
import 'package:social_app/model/massage_model.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/style/colors.dart';
import 'package:social_app/style/icon_broken.dart';

class ChatDetailsScreen extends StatelessWidget {
  UserModel userModel;
  ChatDetailsScreen(this.userModel);

  var massagecon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        SocialCubit.get(context).getMassage(reciverid: userModel.uid);
        return BlocConsumer<SocialCubit, SocialStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                appBar: AppBar(
                  titleSpacing: 0.0,
                  title: Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(userModel.images),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('${userModel.name}')
                    ],
                  ),
                ),
                body: ConditionalBuilder(
                  condition: true,
                  builder: (context) => Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                var massage =
                                    SocialCubit.get(context).massages[index];
                                if (SocialCubit.get(context).model!.uid ==
                                    massage.reciverid)
                                  return buildMyMassage(massage);

                                return buildMassage(massage);
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 15,
                                  ),
                              itemCount:
                                  SocialCubit.get(context).massages.length),
                        ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: .5,
                              ),
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Row(
                            children: [
                              Expanded(
                                  child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  controller: massagecon,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'type your massage here....',
                                  ),
                                ),
                              )),
                              Container(
                                height: 50,
                                color: defultColor,
                                child: MaterialButton(
                                  onPressed: () {
                                    SocialCubit.get(context).sendMassage(
                                        reciverid: userModel.uid,
                                        datatime: DateTime.now().toString(),
                                        text: massagecon.text);
                                  },
                                  minWidth: 1.0,
                                  child: Icon(
                                    IconBroken.Send,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  fallback: (context) =>
                      Center(child: CircularProgressIndicator()),
                ),
              );
            });
      },
    );
  }

  Widget buildMassage(MassageModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadiusDirectional.only(
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  topStart: Radius.circular(10),
                )),
            child: Text(model.text)),
      );
  Widget buildMyMassage(MassageModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
              color: defultColor.withOpacity(.5),
              borderRadius: BorderRadiusDirectional.only(
                bottomStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                topStart: Radius.circular(10),
              )),
          child: Text(model.text),
        ),
      );
}
