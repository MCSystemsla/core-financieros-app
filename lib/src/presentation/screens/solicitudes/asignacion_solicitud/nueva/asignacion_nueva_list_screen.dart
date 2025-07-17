// ignore_for_file: deprecated_member_use
import 'package:animate_do/animate_do.dart';
import 'package:core_financiero_app/src/config/helpers/class_validator/class_validator.dart';
import 'package:core_financiero_app/src/config/helpers/estado_credito/estado_credito.dart';
import 'package:core_financiero_app/src/config/helpers/uppercase_text/uppercase_text_formatter.dart';
import 'package:core_financiero_app/src/config/theme/app_colors.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/solicitud_by_estado/solicitud_by_estado.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitudes_nueva_by_estado/solicitud_nueva_by_estado_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/crear_solicitud_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/forms/outline_textfield_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/search_bar/search_bar.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/buttons/custon_elevated_button.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/credit_producto/credit_product_item.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/error/on_error_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/loading/loading_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/modal_sheet/show_filter_creditos_by_estado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AsignacionListScreen extends StatelessWidget {
  final TypeForm typeForm;
  const AsignacionListScreen({super.key, required this.typeForm});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => SolicitudNuevaByEstadoCubit(
            SolicitudCreditoRepositoryImpl(),
          )..getSolicitudesByEstado(typeForm: typeForm),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Asignar Credito a Asesor'),
        ),
        body: BlocBuilder<SolicitudNuevaByEstadoCubit,
            SolicitudNuevaByEstadoState>(
          builder: (context, state) {
            return switch (state) {
              OnSolicitudNuevaByEstadoLoading() => const LoadingWidget(),
              OnSolicitudNuevaByEstadoSuccess() => _AsignacionNuevaListView(
                  solicitudByEstado: state.solicitudByEstado,
                  typeForm: typeForm,
                ),
              OnSolicitudNuevaByEstadoError() => OnErrorWidget(
                  errorMsg: state.errorMsg,
                  onPressed: () {
                    context
                        .read<SolicitudNuevaByEstadoCubit>()
                        .getSolicitudesByEstado(typeForm: typeForm);
                  },
                ),
              _ => const SizedBox(),
            };
          },
        ),
      ),
    );
  }
}

class _AsignacionNuevaListView extends StatelessWidget {
  final SolicitudByEstado solicitudByEstado;
  final TypeForm typeForm;
  const _AsignacionNuevaListView({
    required this.solicitudByEstado,
    required this.typeForm,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          const _HeaderContent(),
          const Gap(20),
          _FilterContent(
            typeForm: typeForm,
          ),
          const Gap(20),
          solicitudByEstado.data.isEmpty
              ? const _AsignListCreditNoData()
              : ListView.builder(
                  itemCount: solicitudByEstado.data.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return CreditProductItem(
                      typeForm: typeForm,
                      solicitudId: solicitudByEstado.data[index].id,
                      nombre:
                          'Numero Solicitud: ${solicitudByEstado.data[index].numero}',
                      cuota: solicitudByEstado.data[index].cuota
                          .toCurrencyString(),
                      monto: solicitudByEstado.data[index].monto
                          .toCurrencyString(),
                      estadoCodigo: solicitudByEstado.data[index].codigo,
                      sucursal: solicitudByEstado.data[index].sucursal,
                      nombreCliente:
                          solicitudByEstado.data[index].nombreCompleto,
                    );
                  },
                ),
          const Gap(20),
        ],
      ),
    );
  }
}

class _AsignListCreditNoData extends StatelessWidget {
  const _AsignListCreditNoData();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Gap(50),
            Icon(Icons.inbox, size: 60, color: AppColors.getPrimaryColor()),
            const SizedBox(height: 16),
            const Text(
              'No se encontraron solicitudes credito para el estado seleccionado',
              style: TextStyle(fontSize: 18, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterContent extends StatefulWidget {
  final TypeForm typeForm;
  const _FilterContent({
    required this.typeForm,
  });

  @override
  State<_FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<_FilterContent> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SolicitudNuevaByEstadoCubit>();
    return BlocBuilder<SolicitudNuevaByEstadoCubit,
        SolicitudNuevaByEstadoState>(
      builder: (context, state) {
        final estadoCredito = state is OnSolicitudNuevaByEstadoSuccess
            ? state.estadoCredito
            : EstadoCredito.registrada;
        final isAsignadaToAsesorCredito =
            state is OnSolicitudNuevaByEstadoSuccess
                ? state.isAsignadaToAsesorCredito
                : false;
        final isNumeroSolicitudFilter = state is OnSolicitudNuevaByEstadoSuccess
            ? state.isNumeroSolicitudFilter
            : false;
        final isCedulaSolicitudFilter = state is OnSolicitudNuevaByEstadoSuccess
            ? state.isCedulaSolicitudFilter
            : false;
        final numeroSolicitud = state is OnSolicitudNuevaByEstadoSuccess
            ? state.numeroSolicitud
            : null;
        final cedulaCliente = state is OnSolicitudNuevaByEstadoSuccess
            ? state.cedulaCliente
            : null;

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                flex: 6,
                child: SearchBarCustom(
                  onItemSelected: (s) {},
                  onPressed: () {},
                  onTap: () {
                    showFilterGetByCedualAndNumeroSolicitud(
                      context,
                      isNumeroSolicitudFilter,
                      numeroSolicitud,
                      isCedulaSolicitudFilter,
                      cedulaCliente,
                      widget.typeForm,
                      cubit,
                      estadoCredito,
                      isAsignadaToAsesorCredito,
                    );
                  },
                ),
              ),
              const Gap(10),
              Expanded(
                child: FilterView(
                  onTap: () {
                    showFilterCreditosByEstado(
                      context,
                      widget.typeForm,
                      estadoCredito,
                      isAsignadaToAsesorCredito,
                      cubit,
                      isNumeroSolicitudFilter,
                      numeroSolicitud,
                      isCedulaSolicitudFilter,
                      cedulaCliente,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

void showFilterGetByCedualAndNumeroSolicitud(
  BuildContext context,
  bool isNumeroSolicitudFilter,
  String? numeroSolicitud,
  bool isCedulaSolicitudFilter,
  String? cedulaCliente,
  TypeForm typeForm,
  SolicitudNuevaByEstadoCubit cubit,
  EstadoCredito estadoCredito,
  bool isAsignadaToAsesorCredito,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
    ),
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 24,
            left: 20,
            right: 20,
          ),
          child: StatefulBuilder(
            builder: (context, setState) {
              final formKey = GlobalKey<FormState>();
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.filter_alt_rounded,
                            size: 24,
                            color: Colors.indigo,
                          ),
                          const Gap(15),
                          Text(
                            'Filtrar por tipo de solicitud',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const Gap(10),
                      Text(
                        'Filtra las solicitudes por Cedula Cliente y Numero Solciitud',
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: Colors.grey[600]),
                      ),
                      const Gap(20),
                      SwitchListTile(
                        value: isNumeroSolicitudFilter,
                        onChanged: (value) {
                          setState(() {
                            isNumeroSolicitudFilter = value;
                          });
                        },
                        title: const Text('Numero Solicitud'),
                        subtitle: const Text(
                          'Filtra las solicitudes por numero de solicitud',
                        ),
                      ),
                      if (isNumeroSolicitudFilter)
                        FadeIn(
                          child: OutlineTextfieldWidget(
                            initialValue: numeroSolicitud,
                            onChange: (value) {
                              numeroSolicitud = value;
                            },
                            validator: (value) =>
                                ClassValidator.validateRequired(value),
                            title: 'Ingresa el numero de solicitud',
                            hintText: 'Ej: 33234',
                            icon: const Icon(Icons.request_page),
                            textInputType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                          ),
                        ),
                      const Gap(20),
                      SwitchListTile(
                        value: isCedulaSolicitudFilter,
                        onChanged: (value) {
                          setState(() {
                            isCedulaSolicitudFilter = value;
                          });
                        },
                        title: const Text('Cedula del Cliente'),
                        subtitle: const Text(
                          'Filtra las solicitudes por cedula del cliente',
                        ),
                      ),
                      if (isCedulaSolicitudFilter)
                        FadeIn(
                          child: OutlineTextfieldWidget(
                            initialValue: cedulaCliente,
                            validator: (value) =>
                                ClassValidator.validateRequired(value),
                            title: 'Ingresa cedula del Cliente',
                            hintText: 'Ej: 0809199901218T',
                            icon: const Icon(Icons.person),
                            onChange: (value) {
                              cedulaCliente = value;
                            },
                            inputFormatters: [
                              UpperCaseTextFormatter(),
                            ],
                          ),
                        ),
                      const Gap(20),
                      CustomElevatedButton(
                        enabled:
                            isNumeroSolicitudFilter || isCedulaSolicitudFilter,
                        onPressed: () {
                          if (!formKey.currentState!.validate()) return;
                          if (!isNumeroSolicitudFilter) {
                            numeroSolicitud = null;
                          }
                          if (!isCedulaSolicitudFilter) {
                            cedulaCliente = null;
                          }
                          cubit.getSolicitudesByEstado(
                            typeForm: typeForm,
                            isNumeroSolicitudFilter: isNumeroSolicitudFilter,
                            isCedulaSolicitudFilter: isCedulaSolicitudFilter,
                            numeroSolicitud: numeroSolicitud,
                            cedulaCliente: cedulaCliente,
                            estadoCredito: estadoCredito,
                            isAsignadaToAsesorCredito:
                                isAsignadaToAsesorCredito,
                          );
                          context.pop();
                        },
                        text: 'Guardar Cambios',
                        color: AppColors.getSecondaryColor(),
                        icon: const Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                      ),
                      const Gap(20),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}

class _HeaderContent extends StatelessWidget {
  const _HeaderContent();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            'Designar Asesor para el Crédito',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
          child: Text(
            'Seleccioná al asesor que estará a cargo del crédito. Esta acción es clave para garantizar una correcta gestión y seguimiento del proceso crediticio.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
