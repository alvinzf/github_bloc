import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'app_exception.dart';

class ApiBaseHelper {
  Future<dynamic> get(String url) async {
    var responseJson;

    try {
      final response = await http.get(Uri.parse(url));
      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }
}

dynamic _returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
      var responseJson = json.decode(response.body.toString());

      return responseJson;
    case 201:
      var responseJson = json.decode(response.body.toString());

      return responseJson;
    case 400:
      var responseJson = json.decode(response.body.toString());

      return responseJson;
    case 401:
    case 403:
      throw UnauthorisedException(response.body.toString());
    case 500:
    default:
      throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
  }
}
