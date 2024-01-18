import 'dart:convert';

import 'package:flutter/widgets.dart';

class UserModel {
  final String name;
  final String? email;
  UserModel({
    required this.name,
    this.email,
  });

  UserModel copyWith({
    String? name,
    ValueGetter<String?>? email,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email != null ? email() : this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'],
    );
  }

  @override
  String toString() => 'UserModel(name: $name, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel && other.name == name && other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode;

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));
}
