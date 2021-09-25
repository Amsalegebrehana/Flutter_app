
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class User extends Equatable {
  const User(
      {required this.id,
      required this.firstname,
      required this.lastname,
      required this.password,
      required this.email,
      required this.role,
      required this.phone,
      required this.address,
      this.image,
      this.description,
      this.category,
      this.jobs_done,
      this.recommendation,
      this.average_rating,
      this.per_hour_wage});
  final String id;
  final String firstname;
  final String lastname;
  final String password;
  final String email;
  final String role;
  final String phone;
  final String? image;
  final String address;
  final String? description;
  final String? category;
  final int? jobs_done;
  final int? per_hour_wage;
  final String? recommendation;
  final double? average_rating;
  
  @override
  List<Object?> get props => [
        id,
        firstname,
        lastname,
        password,
        email,
        role,
        phone,
        address,
        average_rating,
      ];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['_id'],
        firstname: json['firstname'],
        lastname: json['lastname'],
        password: json['password'],
        email: json['email'],
        role: json['role'],
        phone: json['phone'],
        address: json['address'],
        description: json['description'],
        category: json['category'],
        jobs_done: json['jobs_done'],
        image: json['image'],
        per_hour_wage: json['per_hour_wage']?.toDouble(),
        recommendation: json['recommendation'],
        average_rating: json['average_rating']?.toDouble(),
      );
  }
  @override
  String toString() =>
      'User { firstname: $firstname, lastname: $lastname, email: $email,  role: $role, phone: $phone, adderess: $address , average_rating: $average_rating }';
}
