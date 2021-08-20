import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/register_cubit/registerCubit.dart';
import 'package:social_app/cubit/register_cubit/registerStates.dart';
import 'package:social_app/network/cash_Helper.dart';
import 'package:social_app/screen/home_screen.dart';
import 'package:social_app/style/colors.dart';


class RegisterScreen extends StatelessWidget {
  var emailConteler = TextEditingController();
  var passConteler = TextEditingController();
  var phoneConteler = TextEditingController();
  var nameConteler = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if(state is CrearUserScussState){

            CashHelper.saveData(
                key: 'uid',
                value: state.uid).then((value) {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder:(r)=>HomeScreen()), (route) => false);
            });

          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);

          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'REGISTER now to communicate with friends',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        TextFormField(
                          controller: nameConteler,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Name';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              hintText: 'Name',
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: emailConteler,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              hintText: 'Email Address',
                              labelText: 'Email Addres',
                              prefixIcon: Icon(Icons.email_outlined),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          obscureText: cubit.isPasswordShow,
                          // onChanged: (c){
                          //   if(formKey.currentState!.validate()){
                          //     LoginCubit.get(context).userLogin(email: emailConteler.text, password: passConteler.text);
                          //
                          //   }
                          //
                          // },
                          controller: passConteler,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'password is too short';
                            }
                            return null;
                          },

                          keyboardType: TextInputType.visiblePassword,

                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(cubit.sufx),
                                onPressed: () {
                                  cubit.cahangePasswordVisibilty();
                                },
                              ),
                              hintText: 'Password ',
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock_clock_outlined),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: phoneConteler,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please Enter Your Phone';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              hintText: 'Phone',
                              labelText: 'Phone',
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(20)))),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        ConditionalBuilder(
                          condition:state is !RegisterLoadingState ,
                          builder: (context) => Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: RaisedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  RegisterCubit.get(context).userLogin(
                                      email: emailConteler.text,
                                      password: passConteler.text,
                                      name: nameConteler.text,
                                      phone: phoneConteler.text
                                  );
                                }
                              },
                              child: Text('REGISTER'),
                              color: defultColor,
                              splashColor: Colors.grey,
                              textColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
