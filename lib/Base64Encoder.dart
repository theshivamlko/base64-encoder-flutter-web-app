import 'dart:async';
 import 'dart:convert';

class Base64Encoder {
  static StreamController<String> resultStream = StreamController<String>();

  static Future<String?> encodeTextToBase64(String text) async {
    try {
      Codec<String, String> stringToBase64 = utf8.fuse(base64);
      String result = stringToBase64.encode(text);
      resultStream.add('');
      return result;
    } catch (e) {
      print('$e');
      resultStream.addError("Error! Failed to convert");
      throw (e);
    }
  }
}
