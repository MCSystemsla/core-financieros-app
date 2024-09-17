import 'package:core_financiero_app/src/api/endpoint.dart';

class SolicitudesPendientesEndpoints extends Endpoint {
  SolicitudesPendientesEndpoints();

  @override
  Method get method => Method.get;

  @override
  String get path => '/kiva/solicitudes-pendientes';
  @override
  Map<String, String> get headers => {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IlNEQVZJTEEiLCJzdWIiOiIyNzIiLCJpYXQiOjE3MjY1OTcwMDAsImV4cCI6MTcyNjY4MzQwMH0.5AHS01uKtqheJ0Ch-lZPUnKm-ATlpf5vzDfEqqRbJSA',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        // if (queryParams != null) ...queryParams!,
        'database': 'MC_CH',
      };
}
