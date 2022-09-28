import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_app/bloc/sala_bloc.dart';
import 'package:e_commerce_app/responses/addToFavResponse.dart';
import 'package:e_commerce_app/responses/categories_response.dart';
import 'package:e_commerce_app/responses/home_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../my_dio.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SalaCubit cubit;
  @override
  void initState() {
    // TODO: implement initState
    cubit=SalaCubit.get(context);
    cubit.initHome();
      }
  @override
  Widget build(BuildContext context) {
    SalaCubit cubit=SalaCubit.get(context);
    return BlocConsumer<SalaCubit,SalaStates>(
        listener: (context,state){
          if(state is AddToFavoriteSuccessState){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cubit.successMsgAddToFav,
              style: TextStyle(color: Colors.white ,fontWeight: FontWeight.w500),),
              duration: Duration(seconds: 3),),
            );
          }


        },
        builder: (context,state){

          return ListView(

            children: [
              SizedBox(
                height: 200,
                child: cubit.banners.isEmpty
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : CarouselSlider.builder(
                  itemCount: cubit.banners.length,
                  itemBuilder: (BuildContext context, int itemIndex,
                      int pageViewIndex) =>
                      Container(
                        child: Image.network(
                          cubit.banners[itemIndex].image!,
                          fit: BoxFit.fill,
                        ),
                      ),
                  options: CarouselOptions(
                    autoPlay: true,
                    //enlargeCenterPage: true,
                    viewportFraction: 1,
                    //aspectRatio: 0.2,
                    initialPage: 2,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Categories',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 120,
                child: cubit.categories.isEmpty
                    ? Center(child: CircularProgressIndicator.adaptive())
                    : ListView.builder(
                  itemCount: cubit.categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Container(
                    width: 90,
                    margin: EdgeInsets.all(10),
                    //padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      //borderRadius: BorderRadius.circular(10),
                    ),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.network(
                          cubit.categories[index].image!,
                          height: 90,
                          fit: BoxFit.fill,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          color: Colors.black.withOpacity(0.7),
                          child: Text(
                            cubit.categories[index].name!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              cubit.products.isEmpty
                  ? Center(child: CircularProgressIndicator.adaptive())
                  : Container(
                child:GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: cubit.products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 0.6,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                width:double.infinity,
                                child: Image.network(
                                  cubit.products[index].image!,
                                  height: 180,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Text(cubit.products[index].name!,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(cubit.products[index].price!.toString(),
                                    style: TextStyle(
                                        color: Colors.blue
                                    ),),
                                  SizedBox(width: 10,),
                                  Text((cubit.products[index].oldPrice??'').toString(),
                                    style: TextStyle(
                                      color: Colors.grey,
                                      decoration: TextDecoration.lineThrough,
                                      // textBaseline:
                                    ),

                                  ),
                                ],
                              ),
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(radius: 15,backgroundColor: Colors.grey,),
                                  InkWell(
                                      onTap: (){
                                        cubit.addToFavorites(cubit.products[index].id.toString());
                                      },
                                      child: Icon(Icons.favorite_border,color:Colors.white,size: 16,))
                                ],
                              )
                            ],
                          ),

                        ],
                      ),
                    );
                  },
                ),

              ),
            ],
          );
        }
    );


  }
}
