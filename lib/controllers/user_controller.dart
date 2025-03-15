import 'package:get/get.dart';

class UserController extends GetxController {
  var userName = ''.obs;
  var userEmail = ''.obs;

  void setUser(String name, String email) {
    userName.value = name;
    userEmail.value = email;
  }
}
