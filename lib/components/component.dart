


import 'package:e_commerce_app/responses/categories_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget myTextFormField({
  required TextEditingController controller,
  required FormFieldValidator<String> validator,
  bool passwordVisible = false,
  TextInputType textInputType = TextInputType.text,
  required String label,
  required IconData prefixIcon,
  Widget? suffixIcon,
  GestureTapCallback? onTap,
  TextInputAction? textInputAction,
  ValueChanged<String>? onFieldSubmitted,
}) {
  return TextFormField(
    onFieldSubmitted: onFieldSubmitted,
    textInputAction: textInputAction,
    onTap: onTap,
    validator: validator,
    obscureText: passwordVisible,
    controller: controller,
    keyboardType: textInputType,
    decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: label,
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon),
  );
}


Widget cateoriesListView(int length/* TasksCubit cubit*/,List<Categories> categories){

  return ListView.builder(
    itemCount: categories.length,
    itemBuilder: (context, index) => Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Image.network(categories[index].image!),
        ],
      ),
    ),
  );
}