enum Method { get, post, put, delete, patch }

// ignore: constant_identifier_names
enum TypeBody { raw, formData, x_www_form_urlencoded }

abstract class Endpoint {
  // si se require cambiar la url del api que se asigna en las variables de entorno
  String? setApiUrl;

  String get path;

  Method get method;

  TypeBody typeBody = TypeBody.raw;

  Map<String, dynamic> queryParameters = {};

  Map<String, String> headers = {};

  Map<String, dynamic> body = {};

  List<ImagesModelEndpoint> files = [];

  Endpoint();
}

class ImagesModelEndpoint {
  String path;
  String key;
  String? url;

  ImagesModelEndpoint({
    required this.path,
    required this.key,
    this.url,
  });

  factory ImagesModelEndpoint.fromJson(Map<String, dynamic> json) =>
      ImagesModelEndpoint(
        path: json['path'] == null ? '' : json['path'].toString(),
        key: json['key'] == null ? 'file' : json['key'].toString(),
        url: json['url'],
      );

  Map<String, dynamic> toJson() => {
        'path': path,
        'key': key,
        'url': url,
      };
}
