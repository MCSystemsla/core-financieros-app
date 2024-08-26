import 'dart:io';

import 'endpoint.dart';

class FileUploadEndpoint extends Endpoint {
  @override
  Method get method => Method.post;

  @override
  Map<String, String> get headers => {
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
      };

  @override
  String get path => 'api/upload';
}
