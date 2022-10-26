enum Gender { male, female, others, unSpeacified }

extension GenderExr on Gender {
  String get value {
    String value;
    switch (this) {
      case Gender.male:
        value = "MALE";
        break;
      case Gender.female:
        value = "FEMALE";
        break;
      case Gender.others:
        value = "OTHERS";
        break;
      case Gender.unSpeacified:
        value = "SELECT GENDER";
        break;
    }
    return value;
  }
}

class GenderHelper {
  static Gender fromString(String stringGender) {
    String lowerGender = stringGender.toLowerCase();
    if (lowerGender == "male" || lowerGender == "m") {
      return Gender.male;
    } else if (lowerGender == "female" || lowerGender == "f") {
      return Gender.female;
    } else if (lowerGender == "other" ||
        lowerGender == "others" ||
        lowerGender == "o") {
      return Gender.others;
    } else {
      return Gender.unSpeacified;
    }
  }
}
