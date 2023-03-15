import 'dart:convert';

import 'package:http/http.dart' as http;

Future Getdata(url) async {
  try {
    http.Response response = await http.get(url);
    return json.decode(response.body);
  } catch (error) {
    rethrow;
  }
}

Future Postdata(url, form) async {
  var headers = {
    'Accept': 'application/json, text/plain, */*',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  try {
    http.Response response = await http.post(url, body: form, headers: headers);
    return json.decode(response.body);
  } catch (error) {
    rethrow; // re-throw the same error to the caller
  }
}
