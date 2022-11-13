class RegisterBody {
  final String _userName = "username";
  final String _email = "email";
  final String _phoneNumber = "phonenumber";
  final String _password = "password";
  final String _cPassword = "confirmpassword";

  String userName;
  String email;
  String phoneNumber;
  String password;

  RegisterBody({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.password
  });

  Map<String, dynamic> toMap() {
    return {
      _userName: userName,
      _email: email,
      _phoneNumber: phoneNumber,
      _password: password,
      _cPassword: password,
    };
  }
}
