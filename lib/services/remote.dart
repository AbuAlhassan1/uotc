import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';

class Remote{
  static http.Client client = http.Client();

  static Future<http.Response?> apiCall({
    required String path,
    Map<String, String>? header,
    Map<String, String>? body,
  }) async {

    Uri uri = Uri.parse(debugApiUrl + path);
    http.Response? response;

    try{
      response = await client.post(uri, headers: header, body: jsonEncode(body)).timeout(const Duration(seconds: 3));
    }catch(e){
      return null;
    }

    return response;
  }
}