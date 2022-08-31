 import 'package:dio/dio.dart';

class DioHelper
 {
   static Dio ?dio;
   static init()
   {
     //https://newsapi.org/v2/top-headlines?country=us&category=business&
     // apiKey=ca93d9f48480498c989bdf3bd24ee895
     dio=Dio(
       BaseOptions(
         baseUrl: 'https://newsapi.org/',
         receiveDataWhenStatusError: true,


       ),
     );
   }
   static Future<Response?> getData(
 {
     required  String url,
     Map<String, dynamic>? query,
   String lang='en',
   String? token ,

 })async
   {
     return await dio?.get(
       url,
       queryParameters:query  );

   }
   static Future<Response>postData({
     required  String url,
        Map<String, dynamic>? query,
     required  Map<String, dynamic>? data,
     String lang='en',
     String? token ,


   })async

 {
   dio?.options .headers={
     'Content-Type':'application/json',

     'lang':lang,
     'Authorization':token ,

   };
   return dio!.post(
     url,
     queryParameters: query ,
     data: data,

   );

 }
   static Future<Response>putData({
     required  String url,
     Map<String, dynamic>? query,
     required  Map<String, dynamic>? data,
     String lang='en',
     String? token ,


   })async

   {
     dio?.options .headers={
       'Content-Type':'application/json',

       'lang':lang,
       'Authorization':token ,

     };
     return dio!.put(
       url,
       queryParameters: query ,
       data: data,

     );

   }
 }