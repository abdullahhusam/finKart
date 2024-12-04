import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  final String firstName;

  @HiveField(1)
  final String lastName;

  @HiveField(2)
  final String country;

  @HiveField(3)
  final String phone;

  @HiveField(4)
  final String email;

  @HiveField(5)
  final String password;

  @HiveField(6)
  final String? userPhoto; // Path to the profile photo

  User({
    required this.firstName,
    required this.lastName,
    required this.country,
    required this.phone,
    required this.email,
    required this.password,
    this.userPhoto,
  });
}
