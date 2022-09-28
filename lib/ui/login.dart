import 'package:dio/dio.dart';
import 'package:e_commerce_app/bloc/login_bloc.dart';
import 'package:e_commerce_app/bloc/sala_bloc.dart';
import 'package:e_commerce_app/bloc/settings_bloc.dart';
import 'package:e_commerce_app/components/component.dart';
import 'package:e_commerce_app/responses/login_response.dart';
import 'package:e_commerce_app/my_dio.dart';
import 'package:e_commerce_app/ui/main_screen.dart';
import 'package:e_commerce_app/ui/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LoginScreen extends StatelessWidget {
  var loginFormkey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    LoginCubit cubit=LoginCubit.get(context);
    return BlocConsumer<LoginCubit,LoginStates>(
        listener: (context,state){
          if(state is LoginSuccessState){
            BlocProvider.of<SettingsCubit>(context).initSettings();
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MainScreen()));
          }
          else if(state is LoginFailState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Email or Password !',
              style: TextStyle(color: Colors.red ,fontWeight: FontWeight.w500),),
              duration: Duration(seconds: 3),),
            );
          }
        },
        builder: (context,state){
          return Scaffold(
            body: SafeArea(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Form(
                  key:loginFormkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('LOGIN',style: TextStyle(
                          fontSize: 30,fontWeight: FontWeight.bold
                      ),),
                      SizedBox(height: 15,),
                      Text('Login now to browse our hot offers',style: TextStyle(
                        fontSize: 17,color: Colors.grey[500],fontWeight: FontWeight.bold,
                      ),),
                      SizedBox(height: 25,),
                      myTextFormField(controller: cubit.loginEmailController, validator: (value){
                        if(value!.isEmpty){
                          return 'Email is required';
                        }
                        else if(!value.contains('@')&&!value.contains('.com')){
                          return 'Enter valid email';
                        }
                        return null;
                      }, label: 'Email Address', prefixIcon: Icons.email_outlined),

                      SizedBox(height: 15,),

                      myTextFormField(controller: cubit.loginPasswordController, validator: (value){
                        if(value!.isEmpty){
                          return 'Password is required';
                        }
                        return null;
                      }, label: 'Password', prefixIcon: Icons.lock_outline
                          ,suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                      SizedBox(height: 25,),
                      MaterialButton(onPressed: (){
                        if (loginFormkey.currentState!.validate()) {
                          cubit.login(cubit.loginEmailController.text, cubit.loginPasswordController.text);
                        }
                      },
                        child: Text('LOGIN',style: TextStyle(color: Colors.white),),
                        color: Colors.blue,height: 50,minWidth: double.infinity,),
                      SizedBox(height: 25,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an accont ??",style: TextStyle(
                            fontSize: 14,
                          ),),
                          SizedBox(width: 5,),
                          TextButton(onPressed: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegisterScreen()));
                          }, child:
                          Text('REGISTER',style: TextStyle(
                            fontSize: 15,fontWeight: FontWeight.bold,
                          ),),)
                        ],
                      ),
                      Visibility(
                        visible: cubit.isLogining,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: CircularProgressIndicator.adaptive(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );


  }

}
