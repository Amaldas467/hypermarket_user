import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../app_config/app_config.dart';

class AppUtils {
  ///use to print any data for testing and later will be useful to remove the print inside this
  printError(data) {
    print('============Error===============');
    print(data);
    print('============Error===============');
  }

  printData(data, {String info = 'DATA'}) {
    print('============$info===============');
    print(data);
    print('============$info===============');
  }

  //write datas need to use across all parts of the app here

  //vaidate password registration fields and cahnge fields
  static String? isPasswordValid(String password) {
    if (password.isEmpty) {
      return 'Password should not be empty.';
    }

    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }

    if (!RegExp(r'(?=.*[A-Z])').hasMatch(password)) {
      return 'Password should contain at least one uppercase letter.';
    }

    if (!RegExp(r'(?=.*[a-z])').hasMatch(password)) {
      return 'Password should contain at least one lowercase letter.';
    }

    if (!RegExp(r'(?=.*?[0-9])').hasMatch(password)) {
      return 'Password should contain at least one digit.';
    }

    if (!RegExp(r'(?=.*?[!@#\$&*~])').hasMatch(password)) {
      return 'Password should contain at least one special character (!@#\$&*~).';
    }

    // If all conditions pass, the password is valid.
    return null;
  }

  static bool validationOfEmail(String emailPassed) {
    var email = emailPassed;
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }

  static bool validationOfName(String namePassed) {
    var name = namePassed;
    bool nameValid = RegExp(r"^[a-zA-Z ][a-zA-Z ]+[a-zA-Z ]$").hasMatch(name);
    return nameValid;
  }

  static bool validationOfPIN(String passedPIN) {
    var pin = passedPIN;
    bool isValid = RegExp(r"^[1-9]{1}\d{2}\s?\d{3}$").hasMatch(pin);
    return isValid;
  }

  static bool validationOfPhone(String passedPhone) {
    var phone = passedPhone;
    bool isValid = RegExp(r"^[0-9]{10,10}").hasMatch(phone);
    return isValid;
  }

  static bool validateOTP(String otp) {
    bool isValid = RegExp(r"^[0-9]{4}$").hasMatch(otp);
    return isValid;
  }

  ///used this for luminar
  static Future<String?> getAccessKey() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    print("hai");

    if (sharedPreferences.get(AppConfig.LOGIN_DATA) != null) {
      print("hai1");
      final access = jsonDecode(
          sharedPreferences.get(AppConfig.LOGIN_DATA) as String)['access'];
      print("hai2");
      return access;
    } else {
      print("hai3");
      return null;
    }
  }

  // ///used this for luminar
  // static Future<String?> getGuestDetails() async {
  //   final sharedPreferences = await SharedPreferences.getInstance();
  //   if (sharedPreferences.getString(AppConfig.USER_NAME) != null) {
  //     final guestDetails = sharedPreferences.getString(AppConfig.USER_NAME);
  //     return guestDetails;
  //   } else {
  //     return null;
  //   }
  // }

  ///user this on every btn / or can be implemented on service before API call
  static Future<bool> isOnline() async {
    bool isOnline = await InternetConnectionChecker().hasConnection;
    if (isOnline) {
      return true;
    } else {
      // oneTimeSnackBar('No network connection!');
      return false;
    }
  }

  ///to log data for debugging
  static Logger logger = Logger();
  //use this for getting user id
  static Future<String?> getUserId() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.get(AppConfig.LOGIN_DATA) != null) {
      final userId = jsonDecode(
              sharedPreferences.get(AppConfig.LOGIN_DATA) as String)['userId']
          .toString();
      return userId;
    } else {
      return null;
    }
  }

  static oneTimeSnackBar(
    String? message, {
    int time = 2,
    Color? bgColor,
    TextStyle? textStyle,
    required BuildContext context,
    bool showOnTop = false,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();

    ///To CLEAR PREVIOUS SNACK BARS
    return ScaffoldMessenger.of(context)
        // ScaffoldMessenger.of(context??Routes.router.routerDelegate.navigatorKey.currentState!.context)
        .showSnackBar(
      SnackBar(
        /*action:SnackBarAction(label: "Ok",
        onPressed: (){
          SystemSettings.internalStorage();
        },
        ) ,*/

        behavior: showOnTop ? SnackBarBehavior.floating : null,
        backgroundColor: bgColor ?? Colors.yellow,
        content: Text(message!, style: textStyle),
        duration: Duration(seconds: time),
        margin: showOnTop
            ? EdgeInsets.only(
                bottom: MediaQuery.of(context ?? context).size.height - 100,
                right: 20,
                left: 20)
            : null,
      ),
    );
  }
}
