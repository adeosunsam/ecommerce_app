import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final apiBaseUrl = dotenv.env['Base_Url'] ?? 'Base url not found';

Future<T> apiRequest<T>(
  String endPoint,
  RequestMethod method, {
  Map<String, dynamic>? body,
  String? token,
}) async {
  final String url = apiBaseUrl + endPoint;
  final Map<String, String> headers = <String, String>{};
  headers.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json');
  if (token != null && token.isNotEmpty) {
    headers.putIfAbsent(
        HttpHeaders.authorizationHeader, () => 'Bearer ' + token);
  }
  try {
    switch (method) {
      case RequestMethod.get:
        return await http
            .get(Uri.parse(url), headers: headers)
            .then((value) => value.body as T);
      case RequestMethod.post:
        return await http
            .post(Uri.parse(url), headers: headers, body: jsonEncode(body))
            .then((value) => value.body as T);
      case RequestMethod.put:
        return await http
            .put(Uri.parse(url), headers: headers, body: jsonEncode(body))
            .then((value) => value.body as T);
      case RequestMethod.delete:
        return await http
            .delete(Uri.parse(url), headers: headers)
            .then((value) => value.body as T);
      case RequestMethod.patch:
        return await http
            .patch(Uri.parse(url), headers: headers, body: jsonEncode(body))
            .then((value) => value.body as T);
    }
  } catch (e) {
    rethrow;
  }
}

enum RequestMethod { get, post, put, delete, patch }
