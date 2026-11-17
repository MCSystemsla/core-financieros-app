import 'package:core_financiero_app/src/datasource/analisis/hn/fiadores/fiador_solicitud_hn.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/domain/repository/expediente_digital/expediente_digital_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_search_by_document/analisis_search_by_document_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/cedula/add_cedula_photos_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/fiadores/analisis_fiadores_actividades.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/fiadores/analisis_fiadores_datos_de_actividad.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/fiadores/analisis_fiadores_datos_de_ingresos.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/fiadores/analisis_fiadores_datos_generales.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/fiadores/analisis_fiadores_datos_personales.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/fiadores/signature/fiador_signature_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/actividades_economicas_alias_filtered_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum FiadoresHnFormType {
  conyugue('TFD2'),
  aval('TFD1'),
  codeudor('TFD3');

  final String codigo;

  const FiadoresHnFormType(this.codigo);

  /// Tipo según `TipoFiadorCodigo`. Un código desconocido usa [aval].
  static FiadoresHnFormType fromCodigo(String codigo) => values.firstWhere(
        (type) => type.codigo == codigo,
        orElse: () => aval,
      );
}

class FiadoresHnFormScreen extends StatelessWidget {
  final FiadoresHnFormType type;
  final int numeroSolicitud;

  /// Fiador ya registrado en el backend (SPEC 10). Si no es null, el formulario
  /// se abre en solo lectura: sin fotos de la cédula ni firma, sin validar y
  /// con "Cerrar" en vez de "Enviar".
  final FiadorSolicitudHn? fiadorRegistrado;

  const FiadoresHnFormScreen({
    super.key,
    required this.type,
    required this.numeroSolicitud,
    this.fiadorRegistrado,
  });

  @override
  Widget build(BuildContext context) {
    final registrado = fiadorRegistrado;
    // En solo lectura no hay `AnalisisSearchByDocumentCubit` en el árbol: la
    // pantalla se abre desde `FiadoresHnScreen`, no desde la búsqueda.
    final pageController = PageController();
    if (registrado != null) return _verFiador(registrado, pageController);

    return BlocBuilder<AnalisisSearchByDocumentCubit,
        AnalisisSearchByDocumentState>(
      builder: (context, state) => _crearFiador(state, pageController),
    );
  }

  Widget _verFiador(
    FiadorSolicitudHn registrado,
    PageController pageController,
  ) {
    final fiador = registrado.fiador;
    return BlocProvider(
      create: (ctx) => AnalisisFiadoresCubit(
        AnalisisRepositoryHNImpl(),
        ExpedienteDigitalRepositoryImpl(),
      )..cargarFiadorRegistrado(registrado),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Ver fiador'),
        ),
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              AnalisisFiadoresDatosGenerales(
                pageController: pageController,
                readOnly: true,
                cedula: fiador.cedula,
                primerNombre: fiador.nombre1,
                segundoNombre: fiador.nombre2,
                primerApellido: fiador.apellido1,
                segundoApellido: fiador.apellido2,
                fechaNacimiento: fiador.fechaNacimiento,
                sexo: fiador.sexoCodigo,
                pais: fiador.paisCodigo,
                departamento: fiador.departamentoCodigo,
                municipio: fiador.municipioCodigo,
                direccion: fiador.direccion,
                fechaEmision: fiador.fechaEmisionCedula,
                fechaExpira: fiador.fechaVencimientoCedula,
                tipoDocumento: fiador.tipoDocumentoCodigo,
              ),
              AnalisisFiadoresDatosPersonales(
                pageController: pageController,
                readOnly: true,
              ),
              AnalisisFiadoresActividades(
                pageController: pageController,
                readOnly: true,
              ),
              AnalisisDatosDeActividad(
                pageController: pageController,
                readOnly: true,
              ),
              AnalisisFiadoresDatosDeIngresos(
                pageController: pageController,
                readOnly: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _crearFiador(
    AnalisisSearchByDocumentState state,
    PageController pageController,
  ) {
    return BlocProvider(
      create: (ctx) => AnalisisFiadoresCubit(
        AnalisisRepositoryHNImpl(),
        ExpedienteDigitalRepositoryImpl(),
      )..setRelacionCliente(type.codigo, numeroSolicitud),
      child: Scaffold(
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: const Icon(Icons.build),
            onPressed: () {
              buildActividadesEconomicasAliasFilteredDropdown(
                context: context,
              );
            },
          ),
        ),
        appBar: AppBar(
          title: const Text('Crear Fiador'),
        ),
        body: SafeArea(
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageController,
            children: [
              Builder(
                builder: (ctx) {
                  final cubit = ctx.read<AnalisisFiadoresCubit>();
                  return AddCedulaPhotosScreen(
                    controller: pageController,
                    onCedulaFrontTaken: (imagePath) => cubit.onFieldChanged(
                      () => cubit.state.copyWith(cedulaFrontPath: imagePath),
                    ),
                    onCedulaBackTaken: (imagePath) => cubit.onFieldChanged(
                      () => cubit.state.copyWith(cedulaBackPath: imagePath),
                    ),
                  );
                },
              ),
              FiadorSignatureWidget(
                pageController: pageController,
              ),
              AnalisisFiadoresDatosGenerales(
                pageController: pageController,
                cedula: state.cedula,
                primerNombre: state.primerNombre,
                segundoNombre: state.segundoNombre,
                primerApellido: state.primerApellido,
                segundoApellido: state.segundoApellido,
                fechaNacimiento: DateTime.tryParse(state.fechaNacimiento),
                sexo: state.sexo,
                pais: state.pais,
                departamento: state.departamento,
                municipio: state.municipio,
                direccion: state.direccion,
                fechaEmision: DateTime.tryParse(state.fechaEmision),
                fechaExpira: DateTime.tryParse(state.fechaExpira),
                tipoDocumento: state.tipoDocumento,
              ),
              AnalisisFiadoresDatosPersonales(
                pageController: pageController,
              ),
              AnalisisFiadoresActividades(
                pageController: pageController,
              ),
              AnalisisDatosDeActividad(
                pageController: pageController,
              ),
              AnalisisFiadoresDatosDeIngresos(
                pageController: pageController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
