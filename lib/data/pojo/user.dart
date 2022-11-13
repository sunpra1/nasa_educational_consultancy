import 'dart:convert' as convert;

import '../../model/gender.dart';

class User {
  static const userIdKey = "userId";
  static const userNameKey = "userName";
  static const emailKey = "email";
  static const firstNameKey = "firstName";
  static const lastNameKey = "lastName";
  static const mobileNumberKey = "mobileNumber";
  static const genderKey = "gender";
  static const dobKey = "dob";
  static const countryKey = "country";
  static const stateKey = "state";
  static const cityKey = "city";
  static const addressKey = "address";
  static const profileIdKey = "profileId";
  static const userProfileId = "userProfileId";
  static const profileImageKey = "profileImage";
  static const profileShortImageKey = "profileShorImage";
  static const roleNameKey = "roleName";
  static const tokenKey = "token";

  String userId = "";
  String userName = "";
  String email = "";
  String firstName = "";
  String lastName = "";
  String mobileNumber = "";
  Gender gender = Gender.unSpeacified;
  String dob = "";
  String country = "";
  String state = "";
  String city = "";
  String address = "";
  String profileId = "";
  String profileImage = "";
  String profileShortImage = "";
  UserRole roleName = UserRole.user;
  String token = "";

  User({
    required this.userId,
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.mobileNumber,
    required this.gender,
    required this.dob,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.profileId,
    required this.profileImage,
    required this.profileShortImage,
    required this.roleName,
    required this.token,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userId: map[userIdKey] ?? "",
      userName: map[userNameKey] ?? "",
      email: map[emailKey] ?? "",
      firstName: map[firstNameKey] ?? "",
      lastName: map[lastNameKey] ?? "",
      mobileNumber: map[mobileNumberKey] ?? "",
      gender: GenderHelper.fromString(map[genderKey] ?? ""),
      dob: map[dobKey] ?? "",
      country: map[countryKey] ?? "",
      state: map[stateKey] ?? "",
      city: map[cityKey] ?? "",
      address: map[addressKey] ?? "",
      profileId: map[profileIdKey] ?? map[userProfileId] ?? "",
      profileImage: map[profileImageKey] ?? "",
      profileShortImage: map[profileShortImageKey] ?? "",
      roleName: _getRole(map[roleNameKey] ?? ""),
      token: map[tokenKey] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      userIdKey: userId,
      userNameKey: userName,
      email: email,
      firstNameKey: firstName,
      mobileNumberKey: mobileNumber,
      lastNameKey: lastName,
      genderKey: gender.value,
      countryKey: country,
      stateKey: state,
      cityKey: city,
      addressKey: address,
      userProfileId: profileId,
      profileShortImageKey: profileShortImage,
      roleNameKey: roleName.value,
      tokenKey: token,
    };
  }

  @override
  String toString() {
    return convert.jsonEncode(toMap());
  }

  static UserRole _getRole(String roleString) {
    UserRole value;
    switch (roleString) {
      case "Admin":
        value = UserRole.admin;
        break;
      case "User":
        value = UserRole.user;
        break;
      default:
        value = UserRole.user;
        break;
    }
    return value;
  }
}

enum UserRole { user, admin }

extension RequestEndPointExt on UserRole {
  String get value {
    String value;
    switch (this) {
      case UserRole.user:
        value = "User";
        break;
      case UserRole.admin:
        value = "Admin";
        break;
    }
    return value;
  }
}
