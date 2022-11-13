import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../data/pojo/login_body.dart';
import '../data/pojo/user.dart';
import '../data/repository.dart';
import '../provider/user_provider.dart';
import '../utils/show_toast.dart';
import '../widgets/app_drawer.dart';
import '../widgets/gradient_button.dart';
import '../widgets/progress_dialog.dart';
import 'register_screen.dart';
import 'root_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "/loginScreen";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const passwordKey = "password";
  static const userNameKey = "userName";
  static const emailKey = "email";

  bool isPasswordEnabled = true;

  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  FocusNode usernameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  HashMap<String, String> formErrors = HashMap<String, String>();

  @override
  void dispose() {
    super.dispose();
    usernameFocusNode.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    userNameController.dispose();
    passwordController.dispose();
    emailController.dispose();
  }

  bool _validateUserName({bool displayError = true}) {
    _clearError(userNameKey);
    bool isValid = true;
    String value = userNameController.value.text;
    if (value.isEmpty) {
      formErrors[userNameKey] = "Username is required.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(userNameKey)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validateEmail({bool displayError = true}) {
    _clearError(emailKey);
    bool isValid = true;
    String value = emailController.value.text;
    if (value.isEmpty) {
      formErrors[emailKey] = "Email is required.";
      isValid = false;
    } else if (!(RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(value))) {
      formErrors[emailKey] = "Invalid email address.";
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
          "Password must at-least contain one uppercase and lowercase letter, one special character, and one number.";
      isValid = false;
    }
    if (displayError && formErrors.containsKey(passwordKey)) {
      setState(() {});
    }
    return isValid;
  }

  bool _validate() {
    bool isValid = true;
    if (!_validateUserName(displayError: false)) {
      isValid = false;
    }
    if (!_validateEmail(displayError: false)) {
      isValid = false;
    }
    if (!_validatePassword(displayError: false)) {
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

  void _handleRegisterBtnClick(BuildContext context) {
    Navigator.of(context).pushNamed(RegisterScreen.routeName);
  }

  Future<void> _onFormSubmitted(BuildContext context) async {
    NavigatorState navigatorState = Navigator.of(context);
    UserProvider userProvider = context.read<UserProvider>();
    ShowToast showToast = ShowToast(context: context);
    if (_validate()) {
      showDialog(
        context: context,
        builder: (_) => const ProgressDialog(message: "LOADING..."),
        barrierDismissible: false,
      );
      LoginBody body = LoginBody(
        userName: userNameController.text,
        email: userNameController.text,
        password: passwordController.text,
      );
      dynamic response = await Repository.login(body);
      navigatorState.pop();
      if (response.success) {
        userProvider.setLoggedInUser(
          User.fromMap({
            User.userNameKey: body.userName,
            User.emailKey: body.email,
          }),
        );
        userProvider.setLoggedInUser(User.fromMap(response.data));
        showToast.show("Login success.");
        navigatorState.popUntil(ModalRoute.withName(RootScreen.routeName));
      } else {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("LOGIN FAILED"),
            content: Text(response.message ??
                "Login failed, please try again sometime later."),
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
                          image: Image.asset("asset/image/login.webp").image,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            spreadRadius: 12,
                            blurRadius: 6,
                            color: Colors.black,
                            blurStyle: BlurStyle.outer,
                            offset: Offset(0, 4),
                          )
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
                                    _clearError(userNameKey);
                                  } else {
                                    _validateEmail();
                                  }
                                },
                                child: TextFormField(
                                  controller: userNameController,
                                  focusNode: usernameFocusNode,
                                  decoration: InputDecoration(
                                    errorText: formErrors[userNameKey],
                                    errorMaxLines: 2,
                                    contentPadding: const EdgeInsets.only(
                                        left: 12, right: 12),
                                    border: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(1.0),
                                      ),
                                    ),
                                    labelText: "Username",
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(color: Colors.grey.shade600),
                                  ),
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (_) =>
                                      FocusScope.of(context)
                                          .requestFocus(emailFocusNode),
                                ),
                              ),
                              const SizedBox(height: 18.0),
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
                                      _onFormSubmitted(context),
                                ),
                              ),
                              const SizedBox(height: 18.0),
                              GradientButton(
                                text: "LOGIN",
                                onPressed: () => _onFormSubmitted(context),
                              ),
                              const SizedBox(height: 18.0),
                              Text(
                                "If you are a new user please click on a register button.",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(color: Colors.deepPurple),
                              ),
                              const SizedBox(height: 18.0),
                              GradientButton(
                                text: "REGISTER",
                                onPressed: () =>
                                    _handleRegisterBtnClick(context),
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
