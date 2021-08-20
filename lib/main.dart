import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cupit/social_cubit.dart';
import 'package:social_app/cubit/social_cupit/social_state.dart';
import 'package:social_app/network/cash_Helper.dart';
import 'package:social_app/screen/home_screen.dart';
import 'package:social_app/screen/login_screen.dart';
import 'package:social_app/style/const.dart';
import 'package:social_app/style/them_style.dart';

import 'cubit/bloc_observe.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());

}
void main()async{
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  await Firebase.initializeApp();
  // var token=await FirebaseMessaging.instance.getToken();
  // print(token);
  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  // });
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print(event.data.toString());
  // });
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await CashHelper.init();
  UID=CashHelper.getDate(key: 'uid');

  Widget widget;
  if(UID !=null){
    widget=HomeScreen();
  }else{
    widget=LoginScreen();
  }

  runApp(MyApp(startWidget: widget,));
}


class MyApp extends StatelessWidget {
Widget startWidget;
MyApp({required this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) =>SocialCubit()..getUserData()..getPosts(),)
      ],
      child: BlocConsumer<SocialCubit,SocialStates>(
        listener: (context,state){},
        builder: (context,state){
          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme:lightThem ,
            darkTheme:darkthem ,
            themeMode:ThemeMode.light,

            home: startWidget,
          );
        },
      ),

    );
  }
}
