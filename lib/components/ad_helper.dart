import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId{
    if(Platform.isAndroid){
      return 'ca-app-pub-3940256099942544/6300978111';
    }else if (Platform.isIOS){

    }else{
      throw UnsupportedError("Unsupported device");
    }
    return "ca-app-pub-3940256099942544/6300978111";
  }
}