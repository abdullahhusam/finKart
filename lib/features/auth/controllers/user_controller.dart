import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';

final userControllerProvider =
    Provider<UserController>((ref) => UserController());

class UserController {
  final Box<User> userBox;
  final Box<String> sessionBox;

  String? loggedInEmail;

  UserController()
      : userBox = Hive.box<User>('userBox'),
        sessionBox = Hive.box<String>('sessionBox') {
    // Load session data on initialization
    loggedInEmail = sessionBox.get('loggedInEmail');
  }

  // Set the email of the currently logged-in user and save it in the session box
  void setLoggedInUser(String email) {
    loggedInEmail = email;
    sessionBox.put('loggedInEmail', email);
  }

  // Getter to retrieve the current logged-in user
  User? get currentUser {
    if (loggedInEmail == null) return null;
    return userBox.get(loggedInEmail);
  }

  // Method to create a new user
  Future<bool> createUser(String firstName, String lastName, String country,
      String phone, String email, String password, String? userPhoto) async {
    if (userBox.containsKey(email)) return false;

    final newUser = User(
      firstName: firstName,
      lastName: lastName,
      country: country,
      phone: phone,
      email: email,
      password: password,
      userPhoto: userPhoto,
    );
    await userBox.put(email, newUser);
    return true;
  }

  // Method to update the current user's profile information
  Future<void> updateUser(String firstName, String lastName, String country,
      String phone, String? userPhoto) async {
    if (loggedInEmail == null) return;

    final user = userBox.get(loggedInEmail);
    if (user != null) {
      final updatedUser = User(
        firstName: firstName,
        lastName: lastName,
        country: country,
        phone: phone,
        email: user.email,
        password: user.password,
        userPhoto: userPhoto ?? user.userPhoto,
      );
      await userBox.put(loggedInEmail!, updatedUser);
    }
  }

  // Method to authenticate the user during login
  Future<bool> loginUser(String email, String password) async {
    final user = userBox.get(email);
    if (user != null && user.password == password) {
      setLoggedInUser(email);
      return true;
    }
    return false;
  }

  // Method to log out the current user
  void logout() {
    sessionBox.delete('loggedInEmail');
    loggedInEmail = null;
  }
}
