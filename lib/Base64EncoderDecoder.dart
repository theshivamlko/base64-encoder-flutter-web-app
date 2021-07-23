import 'dart:convert';

class Base64EncodeDecode {
  static Future<String?> decodeBase64ToText(String text) async {
    print('decodeBase64ToText1 $text');
    try {
      String result = String.fromCharCodes(Base64Decoder().convert(text));
      print('result $result');
      return result;
    } catch (e) {
      print('decodeBase64ToText2 $e');
      throw e;
    }
  }
}
