// ignore_for_file: deprecated_member_use

import 'package:core_financiero_app/src/presentation/bloc/solicitudes/solicitud_represtamo/solicitud_represtamo_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/represtamo/represtamo_form.dart';
import 'package:flutter/material.dart';
import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/image_asset/image_asset.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/catalogo/catalogo_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/local_db/solicitudes_db_service.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_form.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../bloc/solicitudes/calculo_cuota/calculo_cuota_cubit.dart';
import '../../bloc/solicitudes/solicitud_nueva_menor/solicitud_nueva_menor_cubit.dart';

enum TypeForm {
  nueva,
  asalariado,
  represtamo,
}

class CrearSolicitudScreen extends StatelessWidget {
  final TypeForm? typeForm;
  final int? objClienteId;
  const CrearSolicitudScreen({
    super.key,
    this.typeForm,
    this.objClienteId,
  });

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();
    final pageController = PageController();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => CalculoCuotaCubit(),
        ),
        BlocProvider(
          create: (ctx) => SolicitudNuevaMenorCubit(
            SolicitudCreditoRepositoryImpl(),
            localDbProvider,
          ),
        ),
        BlocProvider(
          create: (ctx) => SolicitudReprestamoCubit(
            SolicitudCreditoRepositoryImpl(),
            localDbProvider,
          ),
        ),
      ],
      child: Scaffold(
        body: switch (typeForm) {
          TypeForm.nueva => NuevaMenorForm(pageController: pageController),
          TypeForm.asalariado => const Text('ASALARIADO'),
          TypeForm.represtamo => ReprestamoForm(
              controller: pageController,
              objClienteId: objClienteId ?? 0,
            ),
          _ => const SizedBox(),
        },
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
  final ValidatorCallback validator;
  const CatalogoValorNacionalidad({
    super.key,
    required this.hintText,
    required this.title,
    required this.onChanged,
    required this.codigo,
    this.where,
    this.initialValue,
    this.validator,
  });

  @override
  State<CatalogoValorNacionalidad> createState() =>
      _CatalogoValorNacionalidadState();
}

class _CatalogoValorNacionalidadState extends State<CatalogoValorNacionalidad> {
  late String value;
  late String whereClause;
  @override
  void didUpdateWidget(covariant CatalogoValorNacionalidad oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.where != widget.where) {
      setState(() {
        whereClause = widget.where ?? '';
      });
    }
  }

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
      codigo: widget.codigo,
      whereClause: whereClause,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(5),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Gap(15),
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: DropdownSearch<ItemNacionalidad>(
              validator: widget.validator,
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: true,
                searchFieldProps: TextFieldProps(
                  decoration: InputDecoration(
                    hintText: widget.hintText.isEmpty
                        ? 'input.select_option'.tr()
                        : widget.hintText,
                    labelText: 'Buscar',
                    border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
              ),
              items: items,
              itemAsString: (ItemNacionalidad? item) => item?.nombre ?? 'N/A',
              onChanged: widget.onChanged,
              selectedItem: ItemNacionalidad(
                nombre: widget.hintText.isEmpty
                    ? 'input.select_option'.tr()
                    : widget.hintText,
                valor: widget.hintText.isEmpty
                    ? 'input.select_option'.tr()
                    : widget.hintText,
                relacion: '',
                id: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CatalogoValorDropdownWidget extends StatefulWidget {
  final String hintText;
  final String title;
  final ItemCallback<CatalogoLocalDb> onChanged;
  final String codigo;
  final String? initialValue;
  final bool? isRequired;
  final ValidatorCallback validator;
  const CatalogoValorDropdownWidget({
    super.key,
    this.initialValue,
    required this.codigo,
    required this.onChanged,
    required this.title,
    this.hintText = 'Selecciona una opción',
    this.isRequired = false,
    this.validator,
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
    // value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final localDbProvider = global<ObjectBoxService>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(5),
          Text(
            widget.title,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
          ),
          const Gap(15),
          DropdownSearch<CatalogoLocalDb>(
            validator: widget.validator,
            dropdownDecoratorProps: DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            popupProps: PopupProps.menu(
              showSearchBox: true,
              searchFieldProps: TextFieldProps(
                decoration: InputDecoration(
                  hintText: widget.hintText,
                  labelText: 'Buscar',
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
            ),
            items: localDbProvider.findParentescosByNombre(type: widget.codigo),
            itemAsString: (CatalogoLocalDb? item) => item?.nombre ?? 'N/A',
            onChanged: widget.onChanged,
            selectedItem: CatalogoLocalDb(
              type: widget.codigo,
              nombre: widget.initialValue ?? 'input.select_option'.tr(),
              valor: widget.initialValue ?? 'input.select_option'.tr(),
            ),
          ),
        ],
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

class Navbar extends StatelessWidget {
  final String? imageUrl;
  final String title;
  const Navbar({
    super.key,
    required this.title,
    this.imageUrl = ImageAsset.carteraBg2,
  });

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
          child: Image(
            fit: BoxFit.cover,
            image: AssetImage(
              imageUrl!,
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
                    title,
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
