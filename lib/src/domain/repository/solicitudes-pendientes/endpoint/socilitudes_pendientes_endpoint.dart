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
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IlNEQVZJTEEiLCJzdWIiOiIyNzIiLCJpYXQiOjE3MjY1MDY5NjgsImV4cCI6MTcyNjU5MzM2OH0.AKJtqQzNeM4BTBd8XWY47tmjN0x9jb7nZm-bVLp_3jk',
      };
  @override
  Map<String, dynamic> get queryParameters => {
        // if (queryParams != null) ...queryParams!,
        'database': 'MC_CH',
      };
}
