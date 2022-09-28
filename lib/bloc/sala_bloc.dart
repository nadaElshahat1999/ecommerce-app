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

class SalaStates{

}
class InitSalaState extends SalaStates{


}
class GetCategoriesState extends SalaStates{

}
/*class GetFavoritesState extends SalaStates{

}*/
//class GetProfileState extends SalaStates{}
//class UpdateProfileSuccessState extends SalaStates{}
//class UpdateProfileFailState extends SalaStates{}
//class LogoutSuccessState extends SalaStates{}
//class LogoutFailState extends SalaStates{}
class GetBannersAndProductsState extends SalaStates{}
class AddToFavoriteSuccessState extends SalaStates{}
class AddToFavoriteFailState extends SalaStates{}
/*class LoginSuccessState extends SalaStates{
}
class LoginFailState extends SalaStates{

}
class RegisterSuccessState extends SalaStates{
}
class RegisterFailState extends SalaStates{

}*/
/*
class SearchProductsState extends SalaStates{

}*/

class OnBottomNavigationValueChanged extends SalaStates{

}
//class OnSearchingStateChanged extends SalaStates{}
class OnloginingStateChanged extends SalaStates{

}
class SalaCubit extends Cubit<SalaStates>{
  //bool isSearching=false;
  SalaCubit(SalaStates initialState) : super(initialState);
  static SalaCubit get(context) => BlocProvider.of(context);

  List<Banners> banners = [];
  List<Categories> categories = [];
  List<Products> products = [];
  String token='';
  String successMsgAddToFav='';
  //String registerFailMsg='';
  //String updateSuccessMsg='';
  //String updateFailMsg='';
  //String logoutFailMsg='';
  //List<SearchProducts> searchProducts=[];
  //List<Data2> favorites=[];
  List<Widget> screens=[Home(),CategoriesScreen(),FavoritesScreen(),SettingsScreen()];
  int currentIndex=0;
  //bool searchMatch=false;
 // TextEditingController loginEmailController=TextEditingController();
  //TextEditingController loginPasswordController=TextEditingController();
  TextEditingController settingsNameController = TextEditingController();

  TextEditingController settingsEmailController = TextEditingController();

  TextEditingController settingsPhoneController = TextEditingController();
   initHome()async{
    // loginEmailController.text ='nadaelshahat@gmail.com';
     //loginPasswordController.text='123456';
     SharedPreferences preferences= await SharedPreferences.getInstance();
     token=preferences.getString('token')?? '';
     settingsNameController.text='';
     settingsEmailController.text='';
     settingsPhoneController.text='';
     //getProfile();
    getCategories();
    getPannersAndProducts();
    //getFavorites();

  }
  /*onSearchingStateChanged(bool value){
    isSearching = value;
    emit(OnSearchingStateChanged());
  }*/

  onBottomNavigationValueChanged(int value){
     currentIndex=value;
     emit(OnBottomNavigationValueChanged());
  }
  getCategories() {

    MyDio.getData(endPoint: 'categories',token: token).then((value) {
      CategoriesResponse response = CategoriesResponse.fromJson(value.data);
      if (response.status!) {
        print(response.data!.data!.length);
        categories = response.data!.data!;
       emit(GetCategoriesState());
      } else {
        print(response.message);
      }
    });
  }

  getPannersAndProducts() {

    MyDio.getData(endPoint: 'home',token: token).then((value) {
      HomeResponse response = HomeResponse.fromJson(value.data);
      if (response.status!) {
        print(response.data!.banners!.length);
        banners = response.data!.banners!;
        products =response.data!.products!;
        emit(GetBannersAndProductsState());
      } else {
        print(response.message);
      }
    });
  }

  addToFavorites(String productId){
    MyDio.postData(endPoint: 'favorites',data: {
      'product_id':productId,
    },token: token).then((value) {
      AddToFavResponse response=AddToFavResponse.fromJson(value.data);
      if(response.status!){
        successMsgAddToFav=response.message.toString();

        //getFavorites();
        emit(AddToFavoriteSuccessState());

      }
      else{
        print(response.message);
        emit(AddToFavoriteFailState());

      }

    });
  }
  /*getFavorites(){
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
  }*/
  /*void login(String email,String password){
     onLoginingStateChanged(true);
    MyDio.postData(endPoint: 'login',data: {
      'email':email,
      'password':password
    }).then((value) {
      LoginResponse response=LoginResponse.fromJson(value.data);
      if(response.status!){

        print(response.data!.token);
        emit(LoginSuccessState());
        //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> MainScreen()));
        saveToken(response.data!.token!);

      }
      else{
        print(response.message);
        emit(LoginFailState());
       /* ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invalid Email or Password !',
          style: TextStyle(color: Colors.red ,fontWeight: FontWeight.w500),),
          duration: Duration(seconds: 3),),
        );*/
      }
    });
    onLoginingStateChanged(false);
  }*/
  saveToken(String token)async{
    SharedPreferences preferences= await SharedPreferences.getInstance();
    preferences.setString('token', token);
  }
  /*void register(String name,String email,String password,String phone){
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

  }*/
  /*void getProfile() {
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
       emit(LogoutSuccessState());
      }
      else{
        print(response.message);
        logoutFailMsg=response.message.toString();
        emit(LogoutFailState());

      }
    });

  }*/
  /*void searchProduct(String searchKey){
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

  }*/
  /*List<Articles>? searchList=[];
  TextEditingController searchController =TextEditingController();

  List<Articles> businessArticles = [];
  List<Articles> sportsArticles = [];
  List<Articles> technologyArticles = [];
  List<Articles> scienceArticles = [];

  String imageUrl = "https://aqaarplus.com/assets/uploads/default.png";
  List<String> titles=["Business", "Sports", "Technology", "Science"];
  int index=0;

  List<Widget> screens = [
    BusinessNewsScreen(),
    SportsNewsScreen(),
    TechnologyNewsScreen(),
    ScienceNewsScreen(),
  ];
  onBottomNavigationBarChanged(int value){
    index = value;
    emit(OnBottomNavigationChanged());

  }
  onSearchingStateChanged(bool value){
    isSearching = value;
    emit(OnSearchingStateChanged());
  }
  void search(String value) async {
    /*setState(() {
      isSearching = true;
    });*/
    onSearchingStateChanged(true);
    try {
      var  day=DateTime.now().day;
      var  month=DateTime.now().month;
      var  year=DateTime.now().year;
      print(day);
      var response = await Dio().get(
        'https://newsapi.org/v2/everything',
        queryParameters: {
          "q": "$value",
          "from": "$year-$month-$day",
          "sortBy": "publishedAt",
          "apiKey": "2d3a6047e5a34e0885639cb8c690aa08",
        },
      );

      News_response news = News_response.fromJson(response.data);
      searchList = news.articles;
      /* setState(() {
        isSearching = false;
      });*/
      onSearchingStateChanged(false);

    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        print('catched');
        print(e.response!.data['message']);
        return;
      }
      if (e.type == DioErrorType.connectTimeout) {
        print('check your connection');
        return;
      }

      if (e.type == DioErrorType.receiveTimeout) {
        print('unable to connect to the server');
        return;
      }

      if (e.type == DioErrorType.other) {
        print('Something went wrong');
        return;
      }
      print(e);
    } catch (e) {
      print(e);
    }
  }
  getHttpNews() async {
    try{
      var sportsResponse=await Dio().get('https://newsapi.org/v2/top-headlines',
        queryParameters: {
          "country":"eg",
          "category": 'sports',
          "apiKey":"2d3a6047e5a34e0885639cb8c690aa08",
        },);
      News_response sportsNews = News_response.fromJson(sportsResponse.data);
      sportsArticles = sportsNews.articles!;

      var scienceResponse=await Dio().get('https://newsapi.org/v2/top-headlines',
        queryParameters: {
          "country":"eg",
          "category": 'science',
          "apiKey":"2d3a6047e5a34e0885639cb8c690aa08",
        },);
      News_response scienceNews = News_response.fromJson(scienceResponse.data);
      scienceArticles = scienceNews.articles!;

      var businessResponse=await Dio().get('https://newsapi.org/v2/top-headlines',
        queryParameters: {
          "country":"eg",
          "category": 'business',
          "apiKey":"2d3a6047e5a34e0885639cb8c690aa08",
        },);
      News_response businessNews = News_response.fromJson(businessResponse.data);
      businessArticles = businessNews.articles!;
      //setState(() {});


      var technologyResponse=await Dio().get('https://newsapi.org/v2/top-headlines',
        queryParameters: {
          "country":"eg",
          "category": 'technology',
          "apiKey":"2d3a6047e5a34e0885639cb8c690aa08",
        },);
      News_response techNews = News_response.fromJson(technologyResponse.data);
      technologyArticles = techNews.articles!;
      //setState(() {});
      emit(GetNewsState());

    }
    catch(e){
      print(e);
    }
  }
*/
}