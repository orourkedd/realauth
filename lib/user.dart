import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String email;
  final String name;
  final String password;

  User({
    required this.email,
    required this.name,
    required this.password,
  });

  User copyWith({
    String? email,
    String? name,
    String? password,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [email, name, password];
}
