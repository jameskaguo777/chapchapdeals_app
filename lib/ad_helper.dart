import 'dart:io';

import 'package:flutter/foundation.dart';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/6300978111';
      } else {
        return 'ca-app-pub-3038794138306316/2462477156';
      }
    } else if (Platform.isIOS) {
      if (kDebugMode) {
        return 'ca-app-pub-3940256099942544/2934735716';
      } else {
        return 'ca-app-pub-3038794138306316/8435926357';
      }
      
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      if (kDebugMode) {
        return "ca-app-pub-3940256099942544/1033173712";
      } else {
        return "ca-app-pub-3038794138306316/7723936290";
      }
      
    } else if (Platform.isIOS) {
      if (kDebugMode) {
        return "ca-app-pub-3940256099942544/4411468910";
      } else {
        return "ca-app-pub-3038794138306316/5145874411";
      }
      
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/5224354917";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/1712485313";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
