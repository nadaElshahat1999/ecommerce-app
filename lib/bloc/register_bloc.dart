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

class RegisterStates{

}
class InitRegisterState extends RegisterStates{


}
class RegisterSuccessState extends RegisterStates{
}
class RegisterFailState extends RegisterStates {
}
class RegisterCubit extends Cubit<RegisterStates>{


  RegisterCubit(RegisterStates initialState) : super(initialState);
  static RegisterCubit get(context) => BlocProvider.of(context);
  String registerFailMsg='';



  void register(String name,String email,String password,String phone){
    MyDio.postData(endPoint: 'register',data: {
      'name':name,
      'email':email,
      'password':password,
      'phone':phone
    }).then((value) {
      RegisterResponse response=RegisterResponse.fromJson(value.data);
      if(response.status!){
        //print('ok');
        //print(response.data!.token!);
        //Navigator.of(context).pop(MaterialPageRoute(builder: (context)=> LoginScreen()));
        emit(RegisterSuccessState());
      }
      else{
        print(response.message);
        registerFailMsg=response.message.toString();
        /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(response.message.toString(),
          style: TextStyle(color: Colors.red ,fontWeight: FontWeight.w500),),
          duration: Duration(seconds: 3),),
        );*/
        emit(RegisterFailState());
      }
    });

  }


}