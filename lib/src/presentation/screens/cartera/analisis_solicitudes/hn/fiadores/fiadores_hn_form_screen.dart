import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_fiadores/analisis_fiadores_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_search_by_document/analisis_search_by_document_cubit.dart';
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
}

class FiadoresHnFormScreen extends StatelessWidget {
  final FiadoresHnFormType type;
  final int numeroSolicitud;
  const FiadoresHnFormScreen({
    super.key,
    required this.type,
    required this.numeroSolicitud,
  });

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return BlocBuilder<AnalisisSearchByDocumentCubit,
        AnalisisSearchByDocumentState>(
      builder: (context, state) {
        return BlocProvider(
          create: (ctx) => AnalisisFiadoresCubit(
            AnalisisRepositoryHNImpl(),
          )..setRelacionCliente(type.codigo, numeroSolicitud),
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.build),
              onPressed: () {
                buildActividadesEconomicasAliasFilteredDropdown(
                  context: context,
                );
              },
            ),
            appBar: AppBar(
              title: const Text('Crear Fiador'),
            ),
            body: SafeArea(
              child: PageView(
                controller: pageController,
                children: [
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
      },
    );
  }
}
