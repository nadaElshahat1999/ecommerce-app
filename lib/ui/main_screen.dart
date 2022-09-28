

import 'package:e_commerce_app/bloc/sala_bloc.dart';
import 'package:e_commerce_app/ui/categories.dart';
import 'package:e_commerce_app/ui/favorites.dart';
import 'package:e_commerce_app/ui/home.dart';
import 'package:e_commerce_app/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Search.dart';



class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SalaCubit cubit=SalaCubit.get(context);
    return BlocConsumer<SalaCubit,SalaStates>(
        listener: (context,state){
        },
        builder: (context,state){

          return Scaffold(
            body: cubit.screens[cubit.currentIndex],
            appBar: AppBar(backgroundColor:Colors.white,foregroundColor:Colors.black,title: Text('Salla',),actions: [
              IconButton(icon:Icon(Icons.search,color: Colors.black,),onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> SearchScreen()));
              },)
              ,

            ],),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.white,

              type: BottomNavigationBarType.fixed,
              currentIndex:cubit.currentIndex,
              onTap: (value) {
                cubit.onBottomNavigationValueChanged(value);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories'),
                BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'Favorites'),
                BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'Settings'),
              ],
            ),
          );

        }
    );

  }
}
