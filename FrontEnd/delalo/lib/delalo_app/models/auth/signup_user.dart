class SignupUser {
  final String firstname;
  final String lastname;
  final String role;
  final String email;
  final String password;
  final String phone;
  final String image;
  final String address;

  SignupUser(
      {required this.email,
      required this.password,
      required this.firstname,
      required this.lastname,
      required this.role,
      required this.phone,
      required this.image,
      required this.address});
}
