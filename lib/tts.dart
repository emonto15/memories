import 'dart:async';

import 'package:flutter/services.dart';

class Tts {
  static const MethodChannel _channel =
      const MethodChannel('co.edu.eafit.dis.p2.memories');

  static Future<bool> isLanguageAvailable(String language) =>
      _channel.invokeMethod(
          'isLanguageAvailable', <String, Object>{'language': language});

  static Future<bool> setLanguage(String language) => _channel
      .invokeMethod('setLanguage', <String, Object>{'language': language});

  static void speak(String text) =>
      _channel.invokeMethod('speak', <String, Object>{'text': text});
}
