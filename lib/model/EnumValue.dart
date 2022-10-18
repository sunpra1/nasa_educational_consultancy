class EnumValue<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValue(this.map){
    reverseMap = map.map((k, v) => MapEntry(v, k));
  }

  Map<T, String> get reverse {
    return reverseMap;
  }
}
