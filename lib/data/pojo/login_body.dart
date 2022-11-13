class LoginBody {
  final String _userName = "username";
  final String _email = "email";
  final String _password = "password";

  String userName;
  String email;
  String password;

  LoginBody({
    required this.userName,
    required this.email,
    required this.password
  });

  Map<String, dynamic> toMap() {
    return {
      _userName: userName,
      _email: email,
      _password: password,
    };
  }
}
