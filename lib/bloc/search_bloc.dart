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

class SearchStates{

}
class InitSearchState extends SearchStates{


}
class SearchProductsState extends SearchStates{

}

class OnSearchingStateChanged extends SearchStates{

}
class SearchCubit extends Cubit<SearchStates>{
  bool isSearching=false;
  SearchCubit(SearchStates initialState) : super(initialState);
  static SearchCubit get(context) => BlocProvider.of(context);
  String token='';
  List<SearchProducts> searchProducts=[];

  bool searchMatch=false;

  initSearch()async{

    SharedPreferences preferences= await SharedPreferences.getInstance();
    token=preferences.getString('token')?? '';


  }
  onSearchingStateChanged(bool value){
    isSearching = value;
    emit(OnSearchingStateChanged());
  }
  void searchProduct(String searchKey){
    onSearchingStateChanged(true);
    MyDio.postData(endPoint: 'products/search',data: {
      'text':searchKey,
    }).then((value) {
      SearchResponse response=SearchResponse.fromJson(value.data);
      onSearchingStateChanged(false);
      if(response.status!){
        if(response.data!.data!.length==0){
          searchMatch=false;
        }
        else{
          searchMatch=true;
        }
        print(response.data!.data!.length);
        searchProducts=response.data!.data!;
        emit(SearchProductsState());
      }
      else{

        print(response.message);
      }
    });

  }

}