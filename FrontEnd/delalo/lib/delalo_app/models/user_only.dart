//category model
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Users extends Equatable {
  const Users({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.password,
    required this.email,
    required this.role,
    required this.phone,
    required this.address,
  });

  final String id;
  final String firstname;
  final String lastname;
  final String password;
  final String email;
  final String role;
  final String phone;
  final String address;

  List<Object?> get props =>
      [id, firstname, lastname, password, email, role, phone, address];
  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      password: json['password'],
      email: json['email'],
      role: json['role'],
      phone: json['phone'],
      address: json['address'],
    );
  }
  @override
  String toString() =>
      'Users {id: $id , firstname: $firstname, lastname: $lastname, password: $password, role: $role, phone:$phone, address: $address}';
}
