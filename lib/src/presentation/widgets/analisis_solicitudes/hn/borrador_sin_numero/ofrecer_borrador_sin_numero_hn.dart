import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/config/local_storage/local_storage.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/local_db/services/analisis_box_service_hn.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/analisis_solicitudes_hn_offline_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/borrador_sin_numero/usar_borrador_sin_numero_dialog.dart';
import 'package:flutter/material.dart';

/// Antes de abrir el sheet de una solicitud AUT (SPEC 06): si el usuario tiene
/// un borrador sin número con la misma cédula y tipo, pregunta si lo usa.
///
/// - "Usar" pasa los datos del borrador a [numeroSolicitud] y muestra el
///   resumen.
/// - "Ahora no" no toca nada.
/// - "Descartar" borra el borrador y sus datos.
///
/// Solo Honduras y nunca en solicitudes grupales. El `Future` termina cuando
/// el asesor ya decidió, para que el llamador abra el sheet.
Future<void> ofrecerBorradorSinNumeroHn(
  BuildContext context, {
  required String cedula,
  required String tipoSolicitud,
  required String monto,
  required String numeroSolicitud,
  required bool esGrupal,
}) async {
  if (global<FlavorCubit>().state.flavor != Flavor.honduras || esGrupal) {
    return;
  }
  final numeroReal = int.tryParse(numeroSolicitud) ?? 0;
  if (numeroReal <= 0 || cedula.isEmpty) return;

  final localDb = global<AnalisisBoxServiceHn>();
  final borrador = localDb.findBorradorSinNumero(
    userId: LocalStorage().userId,
    cedula: cedula,
    tipoSolicitud: tipoSolicitud,
  );
  if (borrador == null) return;

  final accion = await UsarBorradorSinNumeroDialog.show(
    context,
    borrador: borrador,
    numeroSolicitud: numeroSolicitud,
  );

  switch (accion) {
    case AccionBorradorSinNumero.ahoraNo:
      return;
    case AccionBorradorSinNumero.descartar:
      await localDb.descartarBorradorSinNumero(borrador);
      return;
    case AccionBorradorSinNumero.usar:
      // Si el monto de la AUT cambia el formulario (menor ↔ mayor de mil), el
      // análisis del borrador ya no sirve.
      final formularioBorrador = getTipoSolicitud(
        tipoSolicitud: borrador.tipoSolicitud,
        monto: borrador.monto.toString(),
        esGrupal: false,
      );
      final formularioAut = getTipoSolicitud(
        tipoSolicitud: tipoSolicitud,
        monto: monto,
        esGrupal: false,
      );
      final resultado = await localDb.vincularBorradorSinNumero(
        borrador: borrador,
        numeroReal: numeroReal,
        descartarAnalisis: formularioBorrador != formularioAut,
      );
      if (!context.mounted) return;
      await ResumenVinculoBorradorDialog.show(context, resultado: resultado);
  }
}
