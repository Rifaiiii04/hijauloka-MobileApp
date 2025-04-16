import 'package:get/get.dart';

class UserController extends GetxController {
  final userName = ''.obs;
  final userEmail = ''.obs;
  final userToken = ''.obs;

  void updateUserData(String name, String email, String token) {
    userName.value = name;
    userEmail.value = email;
    userToken.value = token;
  }

  void clearUserData() {
    userName.value = '';
    userEmail.value = '';
    userToken.value = '';
  }
}
