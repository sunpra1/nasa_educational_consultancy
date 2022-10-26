import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../data/pojo/auth_body.dart';
import '../data/pojo/user.dart';
import '../provider/user_provider.dart';
import '../utils/api_request.dart';
import '../widgets/app_drawer.dart';
import '../widgets/gradient_button.dart';
import '../widgets/progress_dialog.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "/registerScreen";

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const emailKey = "email";
  static const passwordKey = "password";
  static const confirmPasswordKey = "cPassword";

  bool isPasswordEnabled = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode cPasswordFocusNode = FocusNode();

  HashMap<String, String> formErrors = HashMap<String, String>();

  @override
  void dispose() {
    super.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    cPasswordFocusNode.dispose();

    emailController.dispose();
    passwordController.dispose();
    cPasswordController.dispose();
  }

  bool _validateEmail({bool displayError = true}) {
    _clearError(emailKey);
    bool isValid = true;
    String value = emailController.value.text;
    if (value.isEmpty) {
      formErrors[emailKey] = "Email is required.";
      isValid = false;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value)) {
      formErrors[emailKey] = "Email is not valid.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(emailKey)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validatePassword({bool displayError = true}) {
    _clearError(passwordKey);
    bool isValid = true;
    String value = passwordController.value.text;
    if (value.isEmpty) {
      formErrors[passwordKey] = "Password is required.";
      isValid = false;
    } else if (value.length < 6) {
      formErrors[passwordKey] =
          "Password must be at-least six characters long.";
      isValid = false;
    } else if (!RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{6,}$")
        .hasMatch(value)) {
      formErrors[passwordKey] =
          "Password must al-least contain one uppercase letter, one special character, and one number.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(passwordKey)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validateCPassword({bool displayError = true}) {
    _clearError(confirmPasswordKey);
    bool isValid = true;
    String value = cPasswordController.value.text;
    String password = passwordController.value.text;
    if (value.isEmpty) {
      formErrors[confirmPasswordKey] = "Password is required.";
      isValid = false;
    } else if (value.length < 6) {
      formErrors[confirmPasswordKey] =
          "Password must be at-least six characters long.";
      isValid = false;
    } else if (!RegExp(
            r"^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#$&*~]).{6,}$")
        .hasMatch(value)) {
      formErrors[confirmPasswordKey] =
          "Password must at-least contain one uppercase and lowercase letter, one special character, and one number.";
      isValid = false;
    } else if (value != password) {
      formErrors[confirmPasswordKey] =
          "Confirm password doesn't match with password.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(confirmPasswordKey)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validate() {
    bool isValid = true;
    if (!_validateEmail(displayError: false)) {
      isValid = false;
    }
    if (!_validatePassword(displayError: false)) {
      isValid = false;
    }
    if (!_validateCPassword(displayError: false)) {
      isValid = false;
    }
    if (!isValid) {
      setState(() {});
    }
    return isValid;
  }

  void _clearError(String key) {
    HashMap<String, String> newErrors = HashMap.from(formErrors);
    if (newErrors.containsKey(key)) {
      newErrors.remove(key);
    }
    setState(() {
      formErrors = newErrors;
    });
  }

  Future<void> _onFormSubmitted(BuildContext context) async {
    NavigatorState navigatorState = Navigator.of(context);
    UserProvider userProvider = context.read<UserProvider>();
    if (_validate()) {
      showDialog(
        context: context,
        builder: (_) => const ProgressDialog(message: "LOADING..."),
        barrierDismissible: false,
      );
      AuthBody body = AuthBody(
        email: emailController.text,
        password: passwordController.text,
        authType: AuthType.register,
      );
      dynamic response = await APIRequest(
              requestType: RequestType.post,
              requestEndPoint: RequestEndPoint.register,
              body: body.toMap())
          .make();
      navigatorState.pop();
      if (response.success) {
        userProvider.setLoggedInUser(
          User.fromMap({
            "userName": body.email,
            "roleName": UserRole.user,
            "token": response.data,
          }),
        );
        navigatorState.popUntil(ModalRoute.withName("/"));
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("REGISTRATION FAILED"),
            content: Text(response.message ??
                "Registration failed, please try again sometime later."),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"))
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: const AppDrawer(),
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.33,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              Image.asset("asset/image/register.png").image,
                        ),
                        boxShadow: const [
                          BoxShadow(
                              spreadRadius: 12,
                              blurRadius: 6,
                              color: Colors.black,
                              blurStyle: BlurStyle.outer,
                              offset: Offset(0, 4))
                        ],
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -60),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Card(
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 16.0,
                          ),
                          child: Column(
                            children: [
                              Focus(
                                onFocusChange: (hasFocus) {
                                  if (hasFocus) {
                                    _clearError(emailKey);
                                  } else {
                                    _validateEmail();
                                  }
                                },
                                child: TextFormField(
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                  decoration: InputDecoration(
                                    errorText: formErrors[emailKey],
                                    errorMaxLines: 2,
                                    contentPadding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(1.0),
                                      ),
                                    ),
                                    labelText: "Email",
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: Colors.grey.shade600),
                                  ),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context)
                                          .requestFocus(passwordFocusNode),
                                ),
                              ),
                              const SizedBox(height: 18.0),
                              Focus(
                                onFocusChange: (hasFocus) {
                                  if (hasFocus) {
                                    _clearError(passwordKey);
                                  } else {
                                    _validatePassword();
                                  }
                                },
                                child: TextFormField(
                                  controller: passwordController,
                                  focusNode: passwordFocusNode,
                                  decoration: InputDecoration(
                                    errorText: formErrors[passwordKey],
                                    errorMaxLines: 2,
                                    contentPadding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(1.0),
                                      ),
                                    ),
                                    labelText: "Password",
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: Colors.grey.shade600),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordEnabled =
                                              !isPasswordEnabled;
                                        });
                                      },
                                      icon: isPasswordEnabled
                                          ? Icon(
                                              const FaIcon(FontAwesomeIcons.eye)
                                                  .icon)
                                          : Icon(const FaIcon(
                                                  FontAwesomeIcons.eyeSlash)
                                              .icon),
                                    ),
                                  ),
                                  obscureText: isPasswordEnabled,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context)
                                          .requestFocus(cPasswordFocusNode),
                                ),
                              ),
                              const SizedBox(height: 18.0),
                              Focus(
                                onFocusChange: (hasFocus) {
                                  if (hasFocus) {
                                    _clearError(confirmPasswordKey);
                                  } else {
                                    _validateCPassword();
                                  }
                                },
                                child: TextFormField(
                                  controller: cPasswordController,
                                  focusNode: cPasswordFocusNode,
                                  decoration: InputDecoration(
                                    errorText: formErrors[confirmPasswordKey],
                                    errorMaxLines: 2,
                                    contentPadding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(1.0),
                                      ),
                                    ),
                                    labelText: "Confirm Password",
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: Colors.grey.shade600),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          isPasswordEnabled =
                                              !isPasswordEnabled;
                                        });
                                      },
                                      icon: isPasswordEnabled
                                          ? Icon(
                                              const FaIcon(FontAwesomeIcons.eye)
                                                  .icon)
                                          : Icon(const FaIcon(
                                                  FontAwesomeIcons.eyeSlash)
                                              .icon),
                                    ),
                                  ),
                                  obscureText: isPasswordEnabled,
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) =>
                                      _onFormSubmitted(context),
                                ),
                              ),
                              const SizedBox(height: 18.0),
                              GradientButton(
                                text: "REGISTER",
                                onPressed: () => _onFormSubmitted(context),
                              ),
                              const SizedBox(height: 18.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum ContactIntent { viewOnMap, mail, call, openLink }
