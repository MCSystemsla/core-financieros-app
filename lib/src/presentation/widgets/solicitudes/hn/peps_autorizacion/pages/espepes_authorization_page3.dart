import 'package:flutter/material.dart';
import 'package:core_financiero_app/src/presentation/screens/solicitudes/hn/autorizacion/espeps_autorizacion_form/espeps_autorizacion_form_screen.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/analisis_credit/hn/analisis_card_list_hn.dart';
import 'package:core_financiero_app/src/presentation/widgets/solicitudes/hn/peps_autorizacion/tables/table_detalle_familiar_peps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../../bloc/solicitudes/hn/cubit/informacion_peps_hn/informacion_peps_hn_cubit.dart';

class EsPepsAuthorizationPage3 extends StatelessWidget {
  final PageController pageController;
  const EsPepsAuthorizationPage3({
    super.key,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(20),
            Text(
              'Informacion Familiares',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const Gap(10),
            AnalisisCardListHn(
              title: 'Detalle de Abuelos (as)',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<InformacionPepsHnCubit>(),
                      child: const TableDetalleFamiliarPeps(
                        parentescoCodigo: 'ABU',
                      ),
                    ),
                  ),
                );
              },
              items: [
                AnalisisCardItem(
                  icon: Icons.person,
                  label: 'Nombre completo de Abuelos (as) ',
                  value: '',
                  color: Colors.blueGrey,
                ),
              ],
            ),
            const Gap(10),
            AnalisisCardListHn(
              title: 'Detalle de Hermanos (as)',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<InformacionPepsHnCubit>(),
                      child: const TableDetalleFamiliarPeps(
                        parentescoCodigo: 'HER',
                      ),
                    ),
                  ),
                );
              },
              items: [
                AnalisisCardItem(
                  icon: Icons.person,
                  label: 'Nombre completo de Hermanos (as) ',
                  value: '',
                  color: Colors.blueGrey,
                ),
              ],
            ),
            const Gap(10),
            AnalisisCardListHn(
              title: 'Nombre completo de Esposos(as) de los hermanos ',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<InformacionPepsHnCubit>(),
                      child: const TableDetalleFamiliarPeps(
                        parentescoCodigo: 'HER',
                      ),
                    ),
                  ),
                );
              },
              items: [
                AnalisisCardItem(
                  icon: Icons.person,
                  label: 'Nombre completo de Esposos(as) de los hermanos ',
                  value: '',
                  color: Colors.blueGrey,
                ),
              ],
            ),
            const Gap(10),
            AnalisisCardListHn(
              title: 'Detalle de Hijos (as):',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<InformacionPepsHnCubit>(),
                      child: const TableDetalleFamiliarPeps(
                        parentescoCodigo: 'HIJ',
                      ),
                    ),
                  ),
                );
              },
              items: [
                AnalisisCardItem(
                  icon: Icons.person,
                  label: 'Nombre completo de Hijos (as)',
                  value: '',
                  color: Colors.blueGrey,
                ),
              ],
            ),
            const Gap(10),
            AnalisisCardListHn(
              title: 'Detalle de Yernos o Nueras (as):',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<InformacionPepsHnCubit>(),
                      child: const TableDetalleFamiliarPeps(
                        parentescoCodigo: 'NUE',
                      ),
                    ),
                  ),
                );
              },
              items: [
                AnalisisCardItem(
                  icon: Icons.person,
                  label: 'Nombre completo de Yerno(s) o Nuera (s)',
                  value: '',
                  color: Colors.blueGrey,
                ),
              ],
            ),
            const Gap(10),
            // TODO: FALTA CATALOGO PARA SUEGROS
            AnalisisCardListHn(
              title: 'Nombres de los Suegros',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<InformacionPepsHnCubit>(),
                      child: const TableDetalleFamiliarPeps(
                        parentescoCodigo: 'NUE',
                      ),
                    ),
                  ),
                );
              },
              items: [
                AnalisisCardItem(
                  icon: Icons.woman,
                  label: 'Nombre completo de Suegra',
                  value: '2',
                  color: Colors.blueGrey,
                ),
                AnalisisCardItem(
                  icon: Icons.man,
                  label: 'Nombre completo de Suegro',
                  value: '',
                  color: Colors.blueGrey,
                ),
              ],
            ),
            const Gap(10),
            // TODO: FALTA CATALOGO PARA NIETOS
            AnalisisCardListHn(
              title: 'Detalle de Nieto (as)',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BlocProvider.value(
                      value: context.read<InformacionPepsHnCubit>(),
                      child: const TableDetalleFamiliarPeps(
                        parentescoCodigo: 'NUE',
                      ),
                    ),
                  ),
                );
              },
              items: [
                AnalisisCardItem(
                  icon: Icons.person,
                  label: 'Nombre completo de Nietos (as)',
                  value: '',
                  color: Colors.blueGrey,
                ),
              ],
            ),
            const Gap(10),
            AnalisisCardListHn(
              title: 'Detalle de Abuelos (as) Cónyuge:',
              onTap: () {},
              items: [
                AnalisisCardItem(
                  icon: Icons.person,
                  label: 'Nombre completo de Abuelos (as) Cónyuge',
                  value: '',
                  color: Colors.blueGrey,
                ),
              ],
            ),
            const Gap(10),
            AnalisisCardListHn(
              title: 'Detalle de Hermanos (as) del cónyuge',
              onTap: () {},
              items: [
                AnalisisCardItem(
                  icon: Icons.person,
                  label: 'Nombre completo Hermanos (as) de cónyuge',
                  value: '',
                  color: Colors.blueGrey,
                ),
              ],
            ),
            const Gap(20),
            esPepsSiguienteButton(context, pageController),
            esPepsAtrasButton(context, pageController),
            const Gap(10),
          ],
        ),
      ),
    );
  }
}
