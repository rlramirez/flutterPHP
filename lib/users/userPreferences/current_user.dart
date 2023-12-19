import 'package:flutter_9nov24/users/model/user.dart';
import 'package:flutter_9nov24/users/userPreferences/userPreferences.dart';
import 'package:get/get.dart';

class CurrentUser extends GetxController {
  Rx<User> _currentUser = User(0, '', '', '').obs;
  User get user => _currentUser.value;
  getUserInfo() async {
    User? getUserInfoFromLocalStore = await RememberUserPrefs.readUserInfo();
    _currentUser.value = getUserInfoFromLocalStore!;
  }
}
