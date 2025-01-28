import 'package:core_financiero_app/src/datasource/solicitudes/catalogo/catalogo_valor.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/solicitudes_credito_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/solicitud_catalogo/solicitud_catalogo_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/nueva_menor_beneficiario_widget.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/nueva_menor_business_data_widget.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/nueva_menor_espeps_widget.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/nueva_menor_monto_widget.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/nueva_menor_working_data_widget.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/dropdown/jlux_dropdown.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_menor_actividad_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/nueva_menor/nueva_,menor_data_client_widget.dart';

class CrearSolicitudScreen extends StatelessWidget {
  const CrearSolicitudScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final objectBox = getIt<ObjectBoxService>();
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

class CatalogoValorDropdownWidget extends StatefulWidget {
  final String hintText;
  final String title;
  final ItemCallback<Catalogo> onChanged;
  final String codigo;
  final String initialValue;
  const CatalogoValorDropdownWidget({
    super.key,
    required this.initialValue,
    required this.codigo,
    required this.onChanged,
    required this.title,
    this.hintText = 'Selecciona una opción',
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
    return BlocProvider(
      create: (ctx) => SolicitudCatalogoCubit(SolicitudCreditoRepositoryImpl())
        ..getCatalogoByCodigo(codigo: widget.codigo),
      child: BlocBuilder<SolicitudCatalogoCubit, SolicitudCatalogoState>(
        builder: (context, state) {
          if (state is SolicitudCatalogoSuccess) {
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
                items: state.data.data,
                onChanged: widget.onChanged,
                toStringItem: (item) {
                  return item.nombre;
                },
                hintText: widget.hintText,
              ),
            );
          }
          return const SizedBox();
        },
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
              'assets/images/cartera_banner.jpg',
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
