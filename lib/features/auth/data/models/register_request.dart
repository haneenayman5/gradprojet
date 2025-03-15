class RegisterRequest{
  final String username;
  final String password;
  final String firstName;
  final String lastName;
  final DateTime dateOfBirth;
  final String email;

  RegisterRequest({required this.username, required this.password, required this.firstName, required this.lastName, required this.dateOfBirth, required this.email});

  Map<String, dynamic> toJson() => {
    "username": username.trim(),
    "password": password,
    "first_name": firstName.trim(),
    "last_name": lastName.trim(),
    "dateOfBirth": dateOfBirth.toIso8601String(),
    "email": email
  };
}