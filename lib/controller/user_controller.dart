import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Model/user_model.dart';
import '../utils/http/api_service.dart';

class UserController extends GetxController {

  RxList<UserModel>? users = RxList<UserModel>();
  RxList<UserModel>? actualUsers = RxList<UserModel>();
  Rx<bool> isErrorOccur = false.obs;
  Rx<bool> isLoading = false.obs;

  Future<List<UserModel>?> getUsers(BuildContext context) async {

    final postResponse = await ApiService().get(
      "https://jsonplaceholder.typicode.com/users",
      headers: {},
    );

    if (postResponse.statusCode == 200) {
      List<dynamic> userListJson = jsonDecode(postResponse.body.toString());
      List<UserModel> users = userListJson.map((userJson) {
        return UserModel.fromJson(userJson);
      }).toList();
      return users;
    }
    else {
      return null;
    }
  }

}