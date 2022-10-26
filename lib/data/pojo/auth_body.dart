class AuthBody {
  final String _email = "email";
  final String _password = "password";
  final String _role = "role";

  String email;
  String password;
  AuthType authType;

  AuthBody(
      {required this.email, required this.password, required this.authType});

  Map<String, dynamic> toMap() {
    return {
      _email: email,
      _password: password,
      if (authType == AuthType.register) _role: "User",
    };
  }
}

enum AuthType { login, register }
