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

class FavoritesStates{

}
class InitFavoritesState extends FavoritesStates{


}
class GetFavoritesState extends FavoritesStates{

}
class FavoritesCubit extends Cubit<FavoritesStates>{
  FavoritesCubit(FavoritesStates initialState) : super(initialState);
  static FavoritesCubit get(context) => BlocProvider.of(context);

  String token='';

  List<Data2> favorites=[];

  initFav()async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    token=preferences.getString('token')?? '';
    getFavorites();

  }

  getFavorites(){
    MyDio.getData(endPoint: 'favorites',token: token).then((value) {
      FavoritesResponse response =FavoritesResponse.fromJson(value.data);
      if(response.status!){
        print(response.data!.data!.length);
        favorites=response.data!.data!;
        emit(GetFavoritesState());
      }
      else{
        print(response.message+'/////////////////////////////////////////');

      }
    });
  }



}