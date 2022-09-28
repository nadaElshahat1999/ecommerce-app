import 'package:e_commerce_app/bloc/sala_bloc.dart';
import 'package:e_commerce_app/responses/categories_response.dart';
import 'package:e_commerce_app/components/component.dart';
import 'package:e_commerce_app/my_dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SalaCubit cubit=SalaCubit.get(context);
    return BlocConsumer<SalaCubit,SalaStates>(
        listener: (context,state){



        },
        builder: (context,state){

          return cubit.categories.isEmpty? Center(
              child: CircularProgressIndicator.adaptive()):ListView.separated(
            itemCount: cubit.categories.length,
            itemBuilder: (context, index) => Container(
              //margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                // borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.network(cubit.categories[index].image!,height: 70,),
                      SizedBox(width: 10,),
                      Text(cubit.categories[index].name!,style:
                      TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                    ],
                  ),
                  Icon(Icons.navigate_next_outlined,size: 30,),
                ],
              ),
            ), separatorBuilder: (BuildContext context, int index) { return Divider(); },
          );

        }
    );

  }



}
