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

class LoginStates{

}
class InitLoginState extends LoginStates{


}
class LoginSuccessState extends LoginStates{
}
class LoginFailState extends LoginStates{

}
class LoginCubit extends Cubit<LoginStates>{
  bool isSearching=false;
  bool isLogining=false;

  LoginCubit(LoginStates initialState) : super(initialState);
  static LoginCubit get(context) => BlocProvider.of(context);


  TextEditingController loginEmailController=TextEditingController();
  TextEditingController loginPasswordController=TextEditingController();



 initLogin(){
   loginEmailController.text ='nadaelshahat@gmail.com';
   loginPasswordController.text='123456';
 }
  void login(String email,String password){

    MyDio.postData(endPoint: 'login',data: {
      'email':email,
      'password':password
    }).then((value) {
      LoginResponse response=LoginResponse.fromJson(value.data);
      if(response.status!){

        print(response.data!.token);
        saveToken(response.data!.token!);
        emit(LoginSuccessState());

      }
      else{
        print(response.message);
        emit(LoginFailState());

      }
    });

  }
  saveToken(String token)async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }


}