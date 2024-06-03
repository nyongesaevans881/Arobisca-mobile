import 'dart:developer';
import 'package:arobisca_online_store_app/core/data/data_provider.dart';
import 'package:arobisca_online_store_app/models/api_response.dart';
import 'package:arobisca_online_store_app/models/user.dart';
import 'package:arobisca_online_store_app/services/http_services.dart';
import 'package:arobisca_online_store_app/utility/constants.dart';
import 'package:arobisca_online_store_app/utility/snack_bar_helper.dart';
import 'package:get_storage/get_storage.dart';

import '../login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UserProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final box = GetStorage();

  UserProvider(this._dataProvider);

//---------- lOGIN FUNCTION
  Future<String?> login(email, password) async {
    try {
      Map<String, dynamic> loginData = {"email": email.toLowerCase(), "password": password};
      final response = await service.addItem(endpointUrl: 'users/login', itemData: loginData);
      if (response.isOk) {
        final ApiResponse<User> apiResponse =
        ApiResponse<User>.fromJson(response.body, (json) => User.fromJson(json as Map<String, dynamic>));
        if (apiResponse.success == true) {
          User? user = apiResponse.data;
          saveLoginInfo(user);
          SnackBarHelper.showSuccessSnackBar(apiResponse.message);
          log('Login success');
          return null;
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to Login: ${apiResponse.message}');
          return 'Failed to Login';
        }
      } else {
        SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusText}');
        return 'Error ${response.body?['message'] ?? response.statusText}';
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('An error occurred: $e');
      return 'An error occurred: $e';
    }
  }


//-------- REGISTER USER FUNCTION
Future<String?> register(String username, String email, String phoneNumber, String password) async {
  try {
    Map<String, dynamic> user = {
      "username": username,
      "email": email.toLowerCase(),
      "phoneNumber": phoneNumber,
      "password": password
    };
    final response = await service.addItem(endpointUrl: 'users/register', itemData: user);
    if (response.isOk) {
      ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
      if (apiResponse.success == true) {
        SnackBarHelper.showSuccessSnackBar(apiResponse.message);
        log('Register Success');
        return null;
      } else {
        SnackBarHelper.showErrorSnackBar('Failed to Register: ${apiResponse.message}');
        return 'Failed to Register: ${apiResponse.message}';
      }
    } else {
      SnackBarHelper.showErrorSnackBar('Error ${response.body?['message'] ?? response.statusText}');
      return 'Error ${response.body?['message'] ?? response.statusText}';
    }
  } catch (e) {
    print(e);
    SnackBarHelper.showErrorSnackBar('A frontend error occurred: $e');
    return 'A frontend error occurred: $e';
  }
}

//---------RESET PASSWORD FUNCTIONS
Future<String?> resetPassword(String email) async {
    try {
      Map<String, dynamic> userEmail = {
      "email": email
    };
      final response = await service.addItem(endpointUrl: 'password/requestPasswordReset', itemData: userEmail);
      if (response.isOk) {
        SnackBarHelper.showSuccessSnackBar('Password reset link sent to your email');
        return null;
      } else {
        SnackBarHelper.showErrorSnackBar('Error: ${response.body?['message'] ?? response.statusText}');
        return 'Error: ${response.body?['message'] ?? response.statusText}';
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('A frontend error occurred: $e');
      return 'A frontend error occurred: $e';
    }
  }



  //? to save login info after login
  Future<void> saveLoginInfo(User? loginUser) async {
    await box.write(USER_INFO_BOX, loginUser?.toJson());
    Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
  }

  //? to get the login user detail from any where the app
  User? getLoginUsr() {
    Map<String, dynamic>? userJson = box.read(USER_INFO_BOX);
    User? userLogged = User.fromJson(userJson ?? {});
    return userLogged;
  }

  //? to logout the user
  logOutUser() {
    box.remove(USER_INFO_BOX);
    Get.offAll(const LoginScreen());
  }
}
