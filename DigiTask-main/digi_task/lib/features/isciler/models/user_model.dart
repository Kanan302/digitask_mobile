import 'package:digi_task/features/performance/data/model/performance_model.dart';

class User {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String userType;
  final Group? group;
  final bool isStaff;

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.userType,
    required this.group,
    required this.isStaff,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phone: json['phone'],
      userType: json['user_type'],
      group: json['group'] != null ? Group.fromJson(json['group']) : null,
      isStaff: json['is_staff'],
    );
  }
}

