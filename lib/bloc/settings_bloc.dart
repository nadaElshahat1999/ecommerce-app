import 'package:e_commerce_app/responses/addToFavResponse.dart';
import 'package:e_commerce_app/responses/categories_response.dart';
import 'package:e_commerce_app/responses/favoritesResponse.dart';
import 'package:e_commerce_app/responses/home_response.dart';
import 'package:e_commerce_app/responses/login_response.dart';
import 'package:e_commerce_app/responses/logoutResponse.dart';
import 'package:e_commerce_app/responses/profileResponse.dart';
import 'package:e_commerce_app/responses/register_response.dart';
import 'package:e_commerce_app/responses/searchResponse.dart';
import 'package:e_commerce_app/responses/updateProfileResponse.dart';
import 'package:e_commerce_app/ui/categories.dart';
import 'package:e_commerce_app/ui/favorites.dart';
import 'package:e_commerce_app/ui/home.dart';
import 'package:e_commerce_app/ui/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../my_dio.dart';

class SettingsStates{}
class InitSettingsState extends SettingsStates{}
class GetProfileState extends SettingsStates{}
class UpdateProfileSuccessState extends SettingsStates{}
class UpdateProfileFailState extends SettingsStates{}
class LogoutSuccessState extends SettingsStates{}
class LogoutFailState extends SettingsStates{}

class SettingsCubit extends Cubit<SettingsStates>{
  SettingsCubit( ) : super(InitSettingsState());
  static SettingsCubit get(context) => BlocProvider.of(context);
  String token='';

  String updateSuccessMsg='';
  String updateFailMsg='';
  String logoutFailMsg='';
  late SharedPreferences preferences;
  TextEditingController settingsNameController = TextEditingController();

  TextEditingController settingsEmailController = TextEditingController();

  TextEditingController settingsPhoneController = TextEditingController();
  initSettings()async{
     preferences= await SharedPreferences.getInstance();
    token=preferences.getString('token')?? '';
    settingsNameController.text='';
    settingsEmailController.text='';
    settingsPhoneController.text='';

  }
  initSettingsdata(){
    getProfile();
  }


  void getProfile() {
    MyDio.getData(endPoint: 'profile', token: token).then((value) {
      ProfileResponse response = ProfileResponse.fromJson(value.data);
      if (response.status!) {
        print(response.data!.name!);
        settingsNameController.text=response.data!.name!;
        settingsEmailController.text=response.data!.email!;
        settingsPhoneController.text=response.data!.phone!;
        emit(GetProfileState());
      }
      else {
        print(response.message.toString());
      }
    });
  }
  void updateProfile(String name,String email,String phone){
    MyDio.putData(endPoint: 'update-profile', token: token,data: {
      'name':name,
      'email':email,
      'phone':phone
    }).then((value) {
      UpdateProfileResponse response = UpdateProfileResponse.fromJson(value.data);
      if (response.status!) {
        print(response.message);
        updateSuccessMsg=response.message.toString();
        emit(UpdateProfileSuccessState());

      }
      else {
        updateFailMsg=response.message.toString();
        emit(UpdateProfileFailState());
      }
    });
  }
  void logout(){
    MyDio.postData(endPoint: 'logout',data: {
      "fcm_token": "SomeFcmToken"
    },token: token).then((value) {
      LogoutResponse response=LogoutResponse.fromJson(value.data);
      if(response.status!){
        preferences.setString("token","noUser");
        emit(LogoutSuccessState());
      }
      else{
        print(response.message);
        logoutFailMsg=response.message.toString();
        emit(LogoutFailState());

      }
    });

  }

}