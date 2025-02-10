import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_actividad_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_data_client_widget.dart';

import '../../widgets/solicitudes/nueva_menor/nueva_menor_beneficiario_widget.dart';
import '../../widgets/solicitudes/nueva_menor/nueva_menor_business_data_widget.dart';
import '../../widgets/solicitudes/nueva_menor/nueva_menor_espeps_widget.dart';
import '../../widgets/solicitudes/nueva_menor/nueva_menor_monto_widget.dart';
import '../../widgets/solicitudes/nueva_menor/nueva_menor_working_data_widget.dart';

class CrearSolicitudScreen extends StatelessWidget {
  const CrearSolicitudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Scaffold(
      body: Column(
        children: [
          const _Navbar(),
          Expanded(
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              children: [
                NuevaMenorDataClientWidget(
                  controller: pageController,
                ),
                NuevaMenorWorkingDataWidget(
                  controller: pageController,
                ),
                NuevaMenorMontoWidget(
                  pageController: pageController,
                ),
                NuevaMenorBusinessDataWidget(
                  pageController: pageController,
                ),
                NuevaMenorBeneficiarioWidget(
                  pageController: pageController,
                ),
                NuevaMenorEsPepsWidget(
                  pageController: pageController,
                ),
                NuevaMenorActividadWidget(
                  pageController: pageController,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ItemNacionalidad extends Equatable {
  final int id;
  final String valor;
  final String nombre;
  final String relacion;

  const ItemNacionalidad(
      {required this.id,
      required this.valor,
      required this.nombre,
      required this.relacion});
  @override
  List<Object?> get props => [
        id,
        valor,
        nombre,
        relacion,
      ];
}

class CatalogoValorNacionalidad extends StatefulWidget {
  final String hintText;
  final String title;
  final ItemCallback<ItemNacionalidad> onChanged;
  final String codigo;
  final String? where;
  final ItemNacionalidad? initialValue;
  const CatalogoValorNacionalidad({
    super.key,
    required this.hintText,
    required this.title,
    required this.onChanged,
    required this.codigo,
    this.where,
    this.initialValue,
  });

  @override
  State<CatalogoValorNacionalidad> createState() =>
      _CatalogoValorNacionalidadState();
}

class _CatalogoValorNacionalidadState extends State<CatalogoValorNacionalidad> {
  late String value;
  late String whereClause;

  @override
  void initState() {
    // value = widget.initialValue;
    whereClause = widget.where ?? '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final items = localDbProvider.getNacionalidadPaises(
        codigo: widget.codigo, whereClause: widget.where ?? '');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: JLuxDropdown(
        dropdownColor: Colors.white,
        isContainIcon: true,
        initialValue: widget.initialValue,
        // isLoading: state.status == Status.inProgress,
        // validator: (value) {
        //   if (value == null) return 'auth.errors.branchTeam'.tr();

        //   return null;
        // },
        title: widget.title,
        items: items,
        onChanged: (item) {
          if (item == null) return;
          widget.onChanged(item);
        },
        toStringItem: (item) {
          return item.nombre;
        },
        hintText: widget.hintText,
      ),
    );
  }
}

class CatalogoValorDropdownWidget extends StatefulWidget {
  final String hintText;
  final String title;
  final ItemCallback<CatalogoLocalDb> onChanged;
  final String codigo;
  final String initialValue;
  final bool? isRequired;
  const CatalogoValorDropdownWidget({
    super.key,
    required this.initialValue,
    required this.codigo,
    required this.onChanged,
    required this.title,
    this.hintText = 'Selecciona una opción',
    this.isRequired = false,
  });

  @override
  State<CatalogoValorDropdownWidget> createState() =>
      _CatalogoValorDropdownWidgetState();
}

class _CatalogoValorDropdownWidgetState
    extends State<CatalogoValorDropdownWidget> {
  late String value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: JLuxDropdown(
        hintText: widget.hintText,
        dropdownColor: Colors.white,
        isContainIcon: true,
        // isLoading: state.status == Status.inProgress,
        // validator: (value) {
        //   if (value == null) return 'auth.errors.branchTeam'.tr();

        //   return null;
        // },
        title: '${widget.title} ${widget.isRequired! ? '*' : ''}',
        items: localDbProvider.findParentescosByNombre(type: widget.codigo),
        onChanged: widget.onChanged,
        toStringItem: (item) {
          return item.nombre;
        },
      ),
    );
  }
}

class CatalogoValorDepartamentos extends StatefulWidget {
  final String hintText;
  final String title;
  final ItemCallback<ItemNacionalidad> onChanged;
  final String codigo;
  final String where;
  const CatalogoValorDepartamentos({
    super.key,
    required this.hintText,
    required this.title,
    required this.onChanged,
    required this.codigo,
    required this.where,
  });

  @override
  State<CatalogoValorDepartamentos> createState() =>
      _CatalogoValorDepartamentosState();
}

class _CatalogoValorDepartamentosState
    extends State<CatalogoValorDepartamentos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: JLuxDropdown(
        dropdownColor: Colors.white,
        isContainIcon: true,
        // isLoading: state.status == Status.inProgress,
        // validator: (value) {
        //   if (value == null) return 'auth.errors.branchTeam'.tr();

        //   return null;
        // },
        title: widget.title,
        items: localDbProvider.getNacionalidadesDep(valor: widget.where),
        onChanged: widget.onChanged,
        toStringItem: (item) {
          return item.nombre;
        },
        hintText: widget.hintText,
      ),
    );
  }
}

class _Navbar extends StatelessWidget {
  const _Navbar();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return Stack(
      children: [
        Container(
          height: size.height * 0.3,
          width: double.infinity,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: const Image(
            fit: BoxFit.cover,
            image: AssetImage(
              ImageAsset.carteraBg2,
            ),
          ),
        ),
        Container(
          height: size.height * 0.3,
          decoration: const BoxDecoration(
            color: Colors.black38,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          width: double.infinity,
        ),
        Container(
          height: size.height * 0.3,
          width: double.infinity,
          decoration: const BoxDecoration(
            // color: AppColors.getPrimaryColor().withOpacity(0.6),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Crear nueva Solicitud Nueva Menor',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                  ),
                  const Gap(10),
                  Text(
                    'Complete los detalles para registrar una nueva solicitud',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
