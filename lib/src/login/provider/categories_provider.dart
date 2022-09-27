import 'dart:convert';

import 'package:app_surtimasas/src/login/api/environment.dart';
import 'package:app_surtimasas/src/login/models/response_api.dart';
import 'package:app_surtimasas/src/login/models/user.dart';
import 'package:app_surtimasas/src/login/utils/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:app_surtimasas/src/login/models/category.dart';



class CategoriesProvider {
  String _url = Environment.API_SURTIMASAS;
  String _api = '/api/categories';
  BuildContext context;
  User sessionUser;

  Future init(BuildContext context, User sessionUser) {
    this.context = context;
    this.sessionUser = sessionUser;
  }

  Future<List<Category>> getAll() async {
    try {
      Uri url = Uri.http(_url, '$_api/getAll');

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };

      final res = await http.get(url, headers: headers);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'La Sesion se Cerro');
        new SharedPref().logout(context, sessionUser.id);
      }

      final data = json.decode(res.body); //obteniendo las categorias

      Category category = Category.fromJsonList(data);

      return category.toList;
    }
    catch(e) {
      print('Error: $e');
      return [];

    }
  }

  Future<ResponseApi> create(Category category) async {
    try {
      Uri url = Uri.http(_url, '$_api/create');
      String bodyParams = json.encode(category);
      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': sessionUser.sessionToken
      };

      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'La Sesion se Cerro');
        new SharedPref().logout(context, sessionUser.id);
      }

      final data = json.decode(res.body);

      ResponseApi responseApi = ResponseApi.fromJson(data);
      return responseApi;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
