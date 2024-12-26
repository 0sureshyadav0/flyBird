import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

class EmailProvider extends ChangeNotifier {
  String _email = '';
  String _password = '';
  String _username = '';
  bool _isLoggedIn = false;
  bool _isLoading = true;

  String get email => _email;
  String get password => _password;
  String get username => _username;
  bool get isLoggedIn => _isLoggedIn;
  bool get isLoading => _isLoading;

  Future<void> setEmail(String email, String username, String password) async {
    var box = await Hive.openBox("EmailBox");
    await box.put("Email", email);
    await box.put("UserName", username);
    await box.put("Password", password);
    await box.put("isLoggedIn", true);

    notifyListeners();
  }

  Future<bool> isUserLoggedIn() async {
    var box = await Hive.openBox("EmailBox");
    _isLoading = true;
    if (await box.get("isLoggedIn") != null) {
      _isLoggedIn = await box.get("isLoggedIn");
    }

    _isLoading = false;
    notifyListeners();
    return _isLoggedIn;
  }

  Future<void> loadEmail() async {
    var box = await Hive.openBox("EmailBox");
    _email = await box.get("Email");
    _username = await box.get("UserName");
    _password = await box.get("Password");
    // Get.snackbar("Error", "$e", colorText: Colors.white);
    notifyListeners();
  }

  Future<void> setNewEmail(String newEmail) async {
    var box = await Hive.openBox("EmailBox");
    await box.delete("Email");
    await box.put("Email", newEmail);
    _email = await box.get("Email");
    Get.snackbar("Success", "$newEmail has been saved",
        colorText: Colors.white);
    notifyListeners();
  }

  Future<void> setNewPassword(String newPassword) async {
    var box = await Hive.openBox("EmailBox");
    await box.delete("Password");
    await box.put("Password", newPassword);
    _password = await box.get("Password");
    Get.snackbar("Success", "$newPassword has been saved",
        colorText: Colors.white);
    notifyListeners();
  }

  Future<void> setNewUserName(String newUserName) async {
    var box = await Hive.openBox("EmailBox");
    await box.delete("UserName");
    await box.put("UserName", newUserName);
    _username = await box.get("UserName");
    Get.snackbar("Success", "$newUserName has been saved",
        colorText: Colors.white);
    notifyListeners();
  }
}
