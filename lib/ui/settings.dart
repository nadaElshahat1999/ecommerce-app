import 'package:e_commerce_app/bloc/sala_bloc.dart';
import 'package:e_commerce_app/bloc/settings_bloc.dart';
import 'package:e_commerce_app/components/component.dart';
import 'package:e_commerce_app/responses/logoutResponse.dart';
import 'package:e_commerce_app/responses/profileResponse.dart';
import 'package:e_commerce_app/responses/updateProfileResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../my_dio.dart';
import 'login.dart';

class SettingsScreen extends StatefulWidget {

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  var settingsFormkey = GlobalKey<FormState>();
  late SettingsCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
     cubit=SettingsCubit.get(context);
     cubit.initSettingsdata();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit,SettingsStates>(
        listener: (context,state){
          if(state is UpdateProfileSuccessState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cubit.updateSuccessMsg,
              style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500),),
              duration: Duration(seconds: 3),),
            );
          }
          else if(state is UpdateProfileFailState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cubit.updateFailMsg,
              style: TextStyle(color: Colors.red ,fontWeight: FontWeight.w500),),
              duration: Duration(seconds: 3),),
            );
          }
          if(state is LogoutSuccessState){
            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen()));
          }
          else if(state is LogoutFailState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cubit.logoutFailMsg,
              style: TextStyle(color: Colors.red ,fontWeight: FontWeight.w500),),
              duration: Duration(seconds: 3),),
            );
          }

        },
        builder: (context,state){

          return Scaffold(
            body: SafeArea(
              child:cubit.settingsNameController.text==''? Center(
                  child: CircularProgressIndicator.adaptive()): Container(

                margin: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Form(
                    key: settingsFormkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        SizedBox(height: 30,),

                        myTextFormField(
                            controller: cubit.settingsNameController, validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        }, label: 'Name', prefixIcon: Icons.person),
                        SizedBox(height: 15,),
                        myTextFormField(
                            controller: cubit.settingsEmailController, validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email is required';
                          }
                          else if (!value.contains('@') && !value.contains('.com')) {
                            return 'Enter valid email';
                          }
                          return null;
                        }, label: 'Email Address', prefixIcon: Icons.email_outlined),

                        SizedBox(height: 15,),
                        myTextFormField(
                          controller: cubit.settingsPhoneController, validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password is required';
                          }
                          else if (value.length > 11 || value.length < 11) {
                            return 'Enter valid phone number';
                          }
                          return null;
                        }, label: 'Phone', prefixIcon: Icons.phone
                          ,),
                        SizedBox(height: 25,),
                        MaterialButton(onPressed: () {
                          if (settingsFormkey.currentState!.validate()) {
                            cubit.updateProfile(cubit.settingsNameController.text,
                                cubit.settingsEmailController.text,
                                cubit.settingsPhoneController.text);
                          }
                        },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Theme
                                .of(context)
                                .primaryColor),
                          ),
                          child: Text(
                            'UPDATE', style: TextStyle(color: Colors.white),),
                          color: Colors.blue,
                          height: 50,
                          minWidth: double.infinity,),
                        SizedBox(height: 15,),
                        MaterialButton(onPressed: () {
                          if (settingsFormkey.currentState!.validate()) {
                            cubit.logout();

                          }
                        },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            side: BorderSide(color: Theme
                                .of(context)
                                .primaryColor),
                          ),
                          child: Text(
                            'LOGOUT', style: TextStyle(color: Colors.white),),
                          color: Colors.blue,
                          height: 50,
                          minWidth: double.infinity,),


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
