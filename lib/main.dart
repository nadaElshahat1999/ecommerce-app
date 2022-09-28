import 'package:e_commerce_app/bloc/login_bloc.dart';
import 'package:e_commerce_app/bloc/search_bloc.dart';
import 'package:e_commerce_app/my_dio.dart';
import 'package:e_commerce_app/ui/login.dart';
import 'package:e_commerce_app/ui/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc/favorites_bloc.dart';
import 'bloc/sala_bloc.dart';
import 'bloc/settings_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MyDio.init();
  preferences= await SharedPreferences.getInstance();
   token = await preferences.getString("token") ?? "noUser";

  runApp(MyApp());
}
late String token  ;
late SharedPreferences preferences;
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>
        SalaCubit(InitSalaState())
          ,
        ),
        BlocProvider(
          create: (context) =>
          LoginCubit(InitLoginState())..initLogin(),
        ),
        BlocProvider(
          create: (context) =>
          FavoritesCubit(InitFavoritesState())..initFav(),
        ),
        BlocProvider(
          create: (context) =>
          SearchCubit(InitSearchState())..initSearch(),
        ),
        BlocProvider(
          create: (context) =>
          SettingsCubit()..initSettings(),
        ),
      ],
      child: 
           BlocConsumer<SettingsCubit, SettingsStates>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {

    return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                elevation: 0,
              ),
            ),
            home: (token == "noUser" ) ? LoginScreen() : MainScreen(),
          );
  },
),
       
    );
  }
}

