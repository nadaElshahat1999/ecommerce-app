import 'package:e_commerce_app/bloc/register_bloc.dart';
import 'package:e_commerce_app/bloc/sala_bloc.dart';
import 'package:e_commerce_app/components/component.dart';
import 'package:e_commerce_app/responses/register_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_dio.dart';
import 'main_screen.dart';
import 'login.dart';

class RegisterScreen extends StatelessWidget {

  TextEditingController emailController=TextEditingController();

  TextEditingController passwordController=TextEditingController();

  TextEditingController nameController=TextEditingController();

  TextEditingController phoneController=TextEditingController();
  var formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    RegisterCubit cubit=RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){
          if(state is RegisterSuccessState){
            Navigator.of(context).pop(MaterialPageRoute(builder: (context)=> LoginScreen()));          }
          else if(state is RegisterFailState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cubit.registerFailMsg,
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
                child: SingleChildScrollView(
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        InkWell(
                            onTap: (){
                              Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));

                            },
                            child: Icon(Icons.arrow_back,)),

                        SizedBox(height: 100,),
                        Text('REGISTER',style: TextStyle(
                            fontSize: 30,fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 15,),
                        Text('Register now to browse our hot offers',style: TextStyle(
                          fontSize: 17,color: Colors.grey[400],fontWeight: FontWeight.bold,
                        ),),
                        SizedBox(height: 25,),
                        myTextFormField(controller: nameController, validator: (value){
                          if(value!.isEmpty){
                            return 'Email is required';
                          }
                          return null;
                        }, label: 'Name', prefixIcon: Icons.person),
                        SizedBox(height: 15,),
                        myTextFormField(controller: emailController, validator: (value){
                          if(value!.isEmpty){
                            return 'Email is required';
                          }
                          else if(!value.contains('@')&&!value.contains('.com')){
                            return 'Enter valid email';
                          }
                          return null;
                        }, label: 'Email Address', prefixIcon: Icons.email_outlined),

                        SizedBox(height: 15,),

                        myTextFormField(controller: passwordController, validator: (value){
                          if(value!.isEmpty){
                            return 'Password is required';
                          }
                          return null;
                        }, label: 'Password', prefixIcon: Icons.lock_outline
                            ,suffixIcon: Icon(Icons.remove_red_eye_outlined)),
                        SizedBox(height: 15,),

                        myTextFormField(controller: phoneController, validator: (value){
                          if(value!.isEmpty){
                            return 'Password is required';
                          }
                          else if(value.length>11||value.length<11){
                            return 'Enter valid phone number';
                          }
                          return null;
                        }, label: 'Phone', prefixIcon: Icons.phone
                          ,),
                        SizedBox(height: 25,),
                        MaterialButton(onPressed: (){
                          if (formkey.currentState!.validate()) {
                            cubit.register(nameController.text,emailController.text,passwordController.text,phoneController.text);
                          }


                        },shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: BorderSide(color: Theme.of(context).primaryColor),
                        ),
                          child: Text('REGISTER',style: TextStyle(color: Colors.white),),
                          color: Colors.blue,height: 50,minWidth: double.infinity,),


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );

  }


}
