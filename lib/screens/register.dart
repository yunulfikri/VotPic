import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'login.dart';
import '../components/background_auth.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import '../helper/api_helper.dart';
class RegisterScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordVerifyController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  registerFunction(ctx)async{

    String apiUrl = GetStorage().read('apiUrl');
    var url = Uri.http(apiUrl,'/api/register');
    try{
      var response = await http.post(url,body: {
        'name': nameController.text,
        'email': emailController.text, 'password': passwordController.text
      });
      var data = jsonDecode(response.body);

      print(response.statusCode);
      if(response.statusCode == 200){
        Get.to(()=> LoginScreen(), transition: Transition.rightToLeft);

      }else{
        var snackBar = SnackBar(content: Text('The email has already been taken or try again'));

        ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
      }
    }catch(e){
      var snackBar = SnackBar(content: Text('The email has already been taken. TRY AGAIN'));

      ScaffoldMessenger.of(ctx).showSnackBar(snackBar);
    }

  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Background(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    "REGISTER",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA),
                        fontSize: 36
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child:  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                        labelText: "Name"
                    ),
                  ),
                ),

                SizedBox(height: size.height * 0.03),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        labelText: "Email"
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        labelText: "Password"
                    ),
                    obscureText: true,
                  ),
                ),

                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: passwordVerifyController,
                    decoration: const InputDecoration(
                        labelText: "Password Verify"
                    ),
                    obscureText: true,
                  ),
                ),

                SizedBox(height: size.height * 0.05),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: MaterialButton(
                    onPressed: () {
                      // registerFunction(context);
                      print("data proses");
                      ApiHelper().register(
                          nameController.text,
                          emailController.text,
                          passwordController.text,
                          passwordVerifyController.text,
                          context);
                    },
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    textColor: Colors.white,
                    padding: const EdgeInsets.all(0),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50.0,
                      width: size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80.0),
                          gradient: const LinearGradient(
                              colors: [
                                Color.fromARGB(255, 255, 136, 34),
                                Color.fromARGB(255, 255, 177, 41)
                              ]
                          )
                      ),
                      padding: const EdgeInsets.all(0),
                      child: const Text(
                        "SIGN UP",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                ),

                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))
                    },
                    child: const Text(
                      "Already Have an Account? Sign in",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2661FA)
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}