import 'dart:io';

import 'package:http_parser/http_parser.dart' show MediaType;

class MultipartFile {
  final File file;
  final MediaType mediaType;
  final String fileName;

  MultipartFile(
      {required this.file, required this.mediaType, required this.fileName,});
}
