import 'package:dio/dio.dart';

class MyDio{
  static Dio? dio;
  static init(){
    dio= Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
        headers:{
        'lang':'en',
          'Content-Type':'application/json',
    }
    ));
  }

  static Future<Response> postData({
  required String endPoint,
    Map<String,dynamic>? data,
    Map<String,dynamic>? queryParameters,
    String? token
}) async {
dio?.options.headers={
  'lang':'en',
  'Content-Type':'application/json',
  'Authorization':token
};
return await dio!.post(endPoint,data: data,queryParameters: queryParameters);
}

static Future<Response> getData({
  required String endPoint,
    Map<String,dynamic>? data,
    Map<String,dynamic>? queryParameters,
    String? token
}) async {
dio?.options.headers={
  'lang':'en',
  'Content-Type':'application/json',
  'Authorization':token
};
return await dio!.get(endPoint,queryParameters: queryParameters);
}

  static Future<Response> putData({
    required String endPoint,
    Map<String,dynamic>? data,
    Map<String,dynamic>? queryParameters,
    String? token
  }) async {
    dio?.options.headers={
      'lang':'en',
      'Content-Type':'application/json',
      'Authorization':token
    };
    return await dio!.put(endPoint,data: data,queryParameters: queryParameters);
  }

}