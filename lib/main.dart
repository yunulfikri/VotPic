import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photoshare/screens/login.dart';
import 'package:photoshare/screens/home.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async{
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuth = false;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    _checkIfLoggedIn();
  }
  void _checkIfLoggedIn() async{
    var token = GetStorage().read('token');
    if(token != null){
      if(mounted){
        setState(() {
          isAuth = true;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    Widget _child;
    if(isAuth){
      _child = HomePage();
    }else{
      _child = LoginScreen();
    }
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context,child) => GetMaterialApp(
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          primaryColor: const Color(0xFF2661FA),
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home:  _child,
      ),
    );
  }
}
