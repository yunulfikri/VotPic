import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:ruangbawah/helper/post.dart';
import '../screens/home.dart';
import '../screens/login.dart';
import 'package:dio/dio.dart' as api_dio;

class ApiHelper{
  final String _secureKey = "kjndskj@jks3jk1yguks7823kjs24e2ns|v1"; // jangan ubah, kecuali di ubah di api nya. ini untuk authentikasi api
  final String _serverUrl = "10.1.82.108"; // server API
  final api_dio.Dio dio = Dio(); // get New DIO
  final Map<String, String> headers = {
    'Accept': 'application/json',
    'User-Agent': 'MobileApplication/api',
  }; // basic headers use for API


  // Helper Login
  login (String email, String password, ctx)async{
    await http.post(Uri.http(_serverUrl, '/api/login'), body: {
      'secure': _secureKey,
      'email': email,
      'password': password
    }, headers: headers).then((value) {
      if(value.statusCode == 200){
        var data = jsonDecode(value.body);
        String token = data['token'].toString();
        GetStorage().write('token', token);
        Get.off(()=> HomePage(), transition: Transition.rightToLeft);
      }else{
        var snackBar = const SnackBar(content: Text('Register success, please login'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      }
    });
  }

  // Helper Register
  register (String name, String email, String password, String passwordVerify, ctx)async{
    await http.post(Uri.http(_serverUrl, '/api/register'), body: {
      'secure': _secureKey,
      'name': name,
      'email': email,
      'password': password,
      'password_verify': passwordVerify
    }, headers: headers).then((value) {
      if(value.statusCode == 200){
        var data = jsonDecode(value.body);
        print(data.toString());
        String token = data['token'].toString();
        GetStorage().write('token', token);
        var snackBar = const SnackBar(content: Text('Register success, please login'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
        Get.to(()=> LoginScreen(), transition: Transition.rightToLeft);
      }else{
        var snackBar = const SnackBar(content: Text('The email has already been taken or something wrong. try again'));
        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      }
    });
  }

  // Upload Photo helper
  Future<String> uploadPhoto (String imagePath)async{
    String token = GetStorage().read('token').toString();
    Map<String, String> headersAuth = {
      'Accept': 'application/json',
      'User-Agent': 'MobileApplication/api',
      'Authorization': 'Bearer $token',
    };
    String fileName = imagePath.split('/').last;
    api_dio.FormData formData = api_dio.FormData.fromMap({
      'secure': _secureKey,
      'image': await api_dio.MultipartFile.fromFile(imagePath,filename: fileName),
    });

    api_dio.Response<Map> response = await dio.post(
      "http://"+_serverUrl + "/api/upload_photo",
      data: formData,
      options: Options(
        headers: headersAuth
      )
    );
    Map? responseBody = response.data;
    print(responseBody!['image_url'].toString());
    return responseBody!['image_url']  == null ? 'failed' : responseBody['image_url'].toString();
  }

  publishPost(String captions, String photoUrl, context)async{
    String token = GetStorage().read('token').toString();
    Map<String, String> headersAuth = {
      'Accept': 'application/json',
      'User-Agent': 'MobileApplication/api',
      'Authorization': 'Bearer $token',
    };
    api_dio.FormData formData = api_dio.FormData.fromMap({
      'secure': _secureKey,
      'photo_url': photoUrl,
      'captions': captions
    });
    api_dio.Response<Map> response = await dio.post(
        "http://"+_serverUrl + "/api/post/store",
        data: formData,
        options: Options(
            headers: headersAuth
        )
    );
    Map? responseBody = response.data;
    var snackBar = const SnackBar(content: Text('Success, you got 10 point'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    Get.offAll(()=> HomePage(), transition: Transition.downToUp);
  }

  List<PostList> parsePost(String responseBody){
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<PostList>((json)=> PostList.fromjson(json)).toList();
  }

  Future<List<PostList>> getAllMyPost() async{
    String token = GetStorage().read('token').toString();
    Map<String, String> headersAuth = {
      'Accept': 'application/json',
      'User-Agent': 'MobileApplication/api',
      'Authorization': 'Bearer $token',
      'Charset': 'utf-8'
    };
    final response = await http.post(Uri.http(_serverUrl, '/api/profile/allpost'), body: {
      'secure': _secureKey,
    }, headers: headersAuth);
   if(response.statusCode == 200){
     print(jsonDecode(response.body));
     return compute(parsePost, response.body);
   }else{
     throw Exception('Failed to load album');
   }
  }

}