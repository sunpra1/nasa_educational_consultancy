import 'dart:convert' as convert;
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../model/multipart_file.dart';

class APIRequest {
  static String baseUrl = "103.140.1.187";
  static const String _contentType = "Content-Type";
  static const String _contentTypeValue = "application/json; charset=utf-8";

  RequestType requestType;
  RequestEndPoint requestEndPoint;
  Map<String, dynamic>? queryParameters;
  final Map<String, String> _requiredHeaders = const {
    _contentType: _contentTypeValue
  };
  Map<String, String>? headers;
  Map<String, dynamic>? body;
  List<MultipartFile>? multipartFiles;

  APIRequest({
    required this.requestType,
    required this.requestEndPoint,
    this.queryParameters,
    this.headers,
    this.body,
    this.multipartFiles,
  });

  Future<dynamic> make({List<String> pathParams = const []}) async {
    Uri uri = Uri.http(
      baseUrl,
      requestEndPoint.getValue(pathParams: pathParams),
      queryParameters,
    );
    http.Response response;
    if (headers != null) _requiredHeaders.addAll(headers!);
    switch (requestType) {
      case RequestType.get:
        response = await http.get(uri, headers: _requiredHeaders);
        break;
      case RequestType.post:
        response = await http.post(uri,
            headers: _requiredHeaders, body: convert.jsonEncode(body));
        break;
      case RequestType.put:
        response = await http.put(uri,
            headers: _requiredHeaders, body: convert.jsonEncode(body));
        break;
      case RequestType.patch:
        response = await http.patch(uri,
            headers: _requiredHeaders, body: convert.jsonEncode(body));
        break;
      case RequestType.delete:
        response = await http.delete(uri,
            headers: _requiredHeaders, body: convert.jsonEncode(body));
        break;
    }
    log("Response ${response.body}");
    return convert.jsonDecode(response.body);
  }

  Future<dynamic> makeMultipart({List<String> pathParams = const []}) async {
    Uri uri = Uri.http(baseUrl,
        requestEndPoint.getValue(pathParams: pathParams), queryParameters);
    http.MultipartRequest request =
        http.MultipartRequest(requestType.value, uri);
    if (headers != null) _requiredHeaders.addAll(headers!);
    request.headers.addAll(_requiredHeaders);
    body?.entries.map((e) {
      request.fields[e.key] = e.value;
    });

    multipartFiles?.map((e) async {
      request.files.add(
        await http.MultipartFile.fromPath(e.fileName, e.file.path,
            contentType: e.mediaType, filename: e.fileName),
      );
    });
    http.StreamedResponse response = await request.send();
    String responseString = await response.stream.bytesToString();
    log("Multipart Response: $responseString");
    return convert.jsonDecode(responseString);
  }
}

enum RequestType { get, post, put, patch, delete }

extension RequestTypeExt on RequestType {
  String get value {
    String value;
    switch (this) {
      case RequestType.put:
        value = "PUT";
        break;
      case RequestType.patch:
        value = "PATCH";
        break;
      case RequestType.get:
        value = "GET";
        break;
      case RequestType.post:
       value = "POST";
        break;
      case RequestType.delete:
       value = "DELETE";
        break;
    }
    return value;
  }
}

enum RequestEndPoint { contactUs }

extension RequestEndPointExt on RequestEndPoint {
  String getValue({List<String> pathParams = const []}) {
    String value;
    switch (this) {
      case RequestEndPoint.contactUs:
        value = "/contact_us";
        break;
    }
    return value;
  }

  String _formatPath(String path, List<String> pathParams) {
    for (var element in pathParams) {
      if (path.contains("%s")) {
        path = path.replaceFirst("%s", element);
      }
    }
    return path;
  }
}
