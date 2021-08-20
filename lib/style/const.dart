

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:social_app/network/cash_Helper.dart';
import 'package:social_app/style/icon_broken.dart';

import 'colors.dart';




void showTost({required String masg,required ToastState state}){
  Fluttertoast.showToast(
      msg: masg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      backgroundColor: choseToastColor(state),
      textColor: Colors.white,
      fontSize: 16.0
  );
}

String UID='';

enum ToastState{SUCESS,ERROR,WARNING}

Color choseToastColor(ToastState state){
  late Color color;
  switch(state){
    case ToastState.SUCESS:
      color= Colors.greenAccent;
      break;

    case ToastState.ERROR:
      color= Colors.red;
      break;

    case ToastState.WARNING:
      color= Colors.yellowAccent;
      break;

  }
  return color;
}

void signOut(context,Widget){
  CashHelper.removeData(key: 'uid').then((value) {
    if(value){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (r)=>Widget), (route) => false);

    }
  });
}

void printFullText(String txet){
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(txet).forEach((element) =>print(element.group(0)));
}

String token='';
Widget mydivider(){
  return Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  );
}


Widget bulidListItem(model,context,{bool isoldPrice=true}){
  return Padding(
    padding: const EdgeInsets.all(20.0),
    child: Container(
      height: 120,
      child: Row
        (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
              alignment: AlignmentDirectional.bottomStart,
              children:[
                Image(
                  image: NetworkImage(model.image),
                  width: 120,
                  height: 120.0,
                  fit: BoxFit.cover,
                ),
               if(model.discount!=0 && isoldPrice )
                 Container(
                  color: Colors.red,
                  child: Text('DISCOUNT',style: TextStyle(fontSize: 8,color: Colors.white),),
                ) ,

              ]
          ),
          SizedBox(width: 20,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(model.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14,height: 1.3),),
                  Spacer(),
                  Row(
                    children: [
                      Text('${model.price.toString()} \$',

                        style: TextStyle(fontSize: 12,color: defultColor),),
                      SizedBox(width: 10.0,),
                     if(model.discount!= 0 && isoldPrice )
                      Text('${model.oldPrice.toString()}\$', style: TextStyle(fontSize: 10,color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      )
                      ) ,
                      Spacer(),
                      IconButton(
                          onPressed: (){
                          //  ShopCubit.get(context).changeFavourit(model.id);
                          },
                          icon: CircleAvatar(
                            //  backgroundColor:(ShopCubit.get(context).favorites![model.id] )! ? defultColor :Colors.grey ,
                              radius :15.0,
                              child: Icon(Icons.favorite_border,color: Colors.white,)
                          )
                      )



                    ],
                  ),
                ],
              ),
            ),
          )

        ],
      ),
    ),
  );
}


Widget defultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? action})=>AppBar(
  leading: IconButton(
    onPressed: (){Navigator.pop(context);},
    icon: Icon(IconBroken.Arrow___Left_2),
  ),
  title: Text(title!),
  actions: action,
);