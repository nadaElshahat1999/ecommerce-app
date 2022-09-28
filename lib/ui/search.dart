import 'package:e_commerce_app/bloc/sala_bloc.dart';
import 'package:e_commerce_app/bloc/search_bloc.dart';
import 'package:e_commerce_app/components/component.dart';
import 'package:e_commerce_app/responses/searchResponse.dart';
import 'package:e_commerce_app/ui/Search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../my_dio.dart';

class SearchScreen extends StatelessWidget {

  var formkey=GlobalKey<FormState>();
  TextEditingController searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    SearchCubit cubit=SearchCubit.get(context);
    return BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state){
        },
        builder: (context,state){
          return Scaffold(
            body: SafeArea(child: Form(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: myTextFormField(controller: searchController, validator: (value){
                        if(value!.isEmpty){
                          return 'Enter Search Key';
                        }
                      }, label: 'Search', prefixIcon: Icons.search,onFieldSubmitted: (value){
                        cubit.searchProduct(value.toString());
                      }),
                    ),
                    Visibility(
                      visible: cubit.isSearching,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: cubit.searchMatch,
                      child: ListView.separated(
                // physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cubit.searchProducts.length,
                itemBuilder: (context, index) => Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  color: Colors.white,
                  child: Row(
                      children: [
                        Image.network(cubit.searchProducts[index].image!,height: 80,
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
                                Text(cubit.searchProducts[index].name!.toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(cubit.searchProducts[index].price!.toString(),
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
                ),
                        separatorBuilder: (BuildContext context, int index) { return Divider(); },
              ),
                    ),
                  ],
                ),
              ),
            )),
          );

        }
    );

  }
}
//products/search
