import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../helpers/http_helpers.dart';
import '../models/api_server.dart';

final apiServerProvider = ChangeNotifierProvider.autoDispose
    .family<ApiServerProvider, ApiServer>(
        (ref, apiServer) => ApiServerProvider(apiServer));

const String loginEnpoint = '/account/login';

class ApiServerProvider extends ChangeNotifier {
  final ApiServer apiServer;

  ApiServerProvider(this.apiServer);

  Future<bool> login() async {
    final url = removeTrailingSlash(apiServer.url);
    final uri = Uri.parse('${apiServer.url}$loginEnpoint');
    final body = json
        .encode({'email': apiServer.username, 'password': apiServer.password});
    try {
      var response = await http
          .post(uri, body: body, headers: {'Content-Type': 'application/json'});
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      if (response.statusCode < 400) return true;
      return false;
    } catch (e) {
      print('Error login to API server : $e');
      return false;
    }
  }
}
