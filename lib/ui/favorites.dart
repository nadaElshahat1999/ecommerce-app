import 'package:e_commerce_app/bloc/favorites_bloc.dart';
import 'package:e_commerce_app/bloc/sala_bloc.dart';
import 'package:e_commerce_app/responses/favoritesResponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../my_dio.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late FavoritesCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
     cubit=FavoritesCubit.get(context);
    cubit.initFav();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesCubit,FavoritesStates>(
        listener: (context,state){
        },
        builder: (context,state){

          return cubit.favorites.isEmpty? Center(
              child: CircularProgressIndicator.adaptive()):
          ListView.separated(
            itemCount: cubit.favorites.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              color: Colors.white,
              child: Row(
                children: [
                  Image.network(cubit.favorites[index].product!.image!,height: 80,
                    width: 80,
                    fit: BoxFit.fill,),
                  SizedBox(width: 20,),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(cubit.favorites[index].product!.name!.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(cubit.favorites[index].product!.price!.toString(),
                                style: TextStyle(
                                    color: Colors.blue
                                ),),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(radius: 15,backgroundColor: Colors.blue,),
                                  Icon(Icons.favorite_border,color:Colors.white,size: 16,)
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
              ,
            ), separatorBuilder: (BuildContext context, int index) { return Divider(); },
          );

        }
    );

  }
}
