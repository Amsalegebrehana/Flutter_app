class UserOnly {
  const UserOnly({
    required this.id,
    required this.firstname,
    required this.lastname,
    required this.password,
    required this.email,
    required this.role,
    required this.phone,
    required this.image,
    required this.address,
  });
  final String id;
  final String firstname;
  final String lastname;
  final String password;
  final String email;
  final String role;
  final String phone;
  final String image;
  final String address;

  @override
  List<Object> get props =>
      [id, firstname, lastname, password, email, role, phone, address];

  factory UserOnly.fromJson(Map<String, dynamic> json) {
    return UserOnly(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      password: json['password'],
      email: json['email'],
      role: json['role'],
      phone: json['phone'],
      image: json['image'],
      address: json['address'],
    );
  }
  @override
  String toString() =>
      'UserOnly {id: $id, firstname: $firstname, lastname: $lastname,  password: $password, email: $email,  role: $role, phone: $phone, address: $address}';
}
