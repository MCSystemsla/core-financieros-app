import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/datasource/analisis/hn/garantias/analisis_garantia_data_hn.dart';
import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_articulo/analisis_articulo_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_dpfs/analisis_dpfs_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/analisis_garantia_detalle/analisis_garantia_detalle_cubit.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/analisis_solicitudes/hn/garantia/interceptor/analisis_garantia_form_interceptor.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/crear_articulo_modal_sheet.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/search/sheet_search_dropdown.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_garantia/tipo_garantia_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CrearGarantiaDetalleScreen extends StatefulWidget {
  final int numeroSolicitud;
  final List<GarantiaData> garantias;
  final String tipoPersonaCodigo;
  final String cedulaCliente;
  const CrearGarantiaDetalleScreen({
    super.key,
    required this.numeroSolicitud,
    required this.garantias,
    required this.tipoPersonaCodigo,
    required this.cedulaCliente,
  });

  @override
  State<CrearGarantiaDetalleScreen> createState() =>
      _CrearGarantiaDetalleScreenState();
}

class _CrearGarantiaDetalleScreenState
    extends State<CrearGarantiaDetalleScreen> {
  bool showFab = false;
  @override
  Widget build(BuildContext context) {
    final repository = AnalisisRepositoryHNImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => AnalisisGarantiaDetalleCubit(
            repository,
          ),
        ),
        BlocProvider(
          create: (ctx) => AnalisisDpfsCubit(
            repository,
          )..getDpfsByCedula(
              tipoPersona: widget.tipoPersonaCodigo,
              cedula: widget.cedulaCliente,
            ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Crear Detalle de Garantía'),
        ),
        floatingActionButton: showFab
            ? FloatingActionButton.extended(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => BlocProvider.value(
                      value: context.read<AnalisisArticuloCubit>(),
                      child: CreateArticuloModalSheet(
                        numeroSolicitud: widget.numeroSolicitud,
                      ),
                    ),
                  );
                },
                backgroundColor: Colors.black,
                label: const Row(
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    Gap(5),
                    Text(
                      'Crear Articulo',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            : null,
        body: _ArticuloForm(
          garantias: widget.garantias,
          onTipoGarantiaChanged: (tipoGarantia) {
            setState(() {
              showFab = tipoGarantia != TipoGarantiaEnum.liquida.codigo;
            });
          },
        ),
      ),
    );
  }
}

class _ArticuloForm extends StatefulWidget {
  final List<GarantiaData> garantias;
  final void Function(String tipoGarantia) onTipoGarantiaChanged;
  const _ArticuloForm({
    required this.garantias,
    required this.onTipoGarantiaChanged,
  });
  @override
  State<_ArticuloForm> createState() => _ArticuloFormState();
}

class _ArticuloFormState extends State<_ArticuloForm> {
  final formKey = GlobalKey<FormState>();

  String? objAnalisisGarantiaID;
  String? tipoGarantiaName;
  int? dpfsId;
  int? articuloGarantiaCodigo;
  String? descripcion;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            const Gap(20),
            SheetSearchDropdown(
              title: 'Garantia',
              isRequired: true,
              onChanged: (v) {
                setState(() {
                  objAnalisisGarantiaID = v?.value;
                  tipoGarantiaName = v?.name;
                });
                widget.onTipoGarantiaChanged(tipoGarantiaName ?? '');
              },
              validator: (value) =>
                  ClassValidator.validateRequired(value?.value),
              hintText: 'Selecciona una garantia',
              enabled: true,
              items: widget.garantias
                  .map((e) => Item(name: e.tipoGarantia, value: e.id))
                  .toList(),
            ),
            if (tipoGarantiaName == TipoGarantiaEnum.liquida.codigo) ...[
              const Gap(20),
              BlocBuilder<AnalisisDpfsCubit, AnalisisDpfsState>(
                builder: (context, state) {
                  return switch (state.status) {
                    Status.inProgress => const LoadingWidget(),
                    Status.error => Text('Error : ${state.errorMsg}'),
                    Status.done => SheetSearchDropdown(
                        title: 'DPFs',
                        isRequired: true,
                        validator: (value) => ClassValidator.validateRequired(
                            value?.value.toString()),
                        onChanged: (v) {
                          dpfsId = v?.value;
                        },
                        hintText: state.data.isEmpty
                            ? 'No hay Dpfs registrado.'
                            : 'Selecciona un Dpf',
                        enabled: state.data.isNotEmpty,
                        items: state.data
                            .map((e) => Item(
                                  name: e.numeroCuenta,
                                  value: e.dpfId,
                                ))
                            .toList(),
                      ),
                    _ => const SizedBox(),
                  };
                },
              ),
            ],
            if (tipoGarantiaName != TipoGarantiaEnum.liquida.codigo &&
                tipoGarantiaName != null) ...[
              const Gap(20),
              BlocBuilder<AnalisisArticuloCubit, AnalisisArticuloState>(
                builder: (context, state) {
                  return SheetSearchDropdown(
                    title: 'Articulo',
                    isRequired: true,
                    validator: (value) => ClassValidator.validateRequired(
                        value?.value.toString()),
                    onChanged: (v) {
                      articuloGarantiaCodigo = v?.value;
                      descripcion = v?.anotherValue;
                    },
                    hintText: 'Selecciona un articulo',
                    enabled: true,
                    items: state.analisisGarantiaArticuloHn
                        .map((e) => Item(
                              name: e.nombre,
                              value: e.valor,
                              anotherValue: e.descripcion,
                            ))
                        .toList(),
                  );
                },
              ),
            ],
            AnalisisGarantiaFormInterceptor(
              key: ValueKey(tipoGarantiaName),
              tipoGarantia: tipoGarantiaName?.toTipoGarantiaEnum(),
              dpfsId: dpfsId ?? 0,
              objAnalisisGarantiaID:
                  int.tryParse(objAnalisisGarantiaID ?? '0') ?? 0,
              articuloGarantiaCodigo: articuloGarantiaCodigo,
              descripcion: descripcion,
            ),
          ],
        ),
      ),
    );
  }
}
