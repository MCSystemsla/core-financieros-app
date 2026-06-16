import 'package:core_financiero_app/src/domain/repository/analisis/hn/analisis_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/analisis/hn/evaluadores_cnbs/evaluadores_cnbs_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/hipotecario/crear_detalle_bien_hipotecario.dart';

import 'package:core_financiero_app/src/presentation/widgets/analisis_solicitudes/hn/garantia/v2/prendario/crear_detalle_bien_prendario_hn.dart';

import 'package:core_financiero_app/src/utils/extensions/tipo_articulo/tipo_articulo_extension.dart';
import 'package:core_financiero_app/src/utils/extensions/tipo_garantia/tipo_garantia_enum.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../bloc/analisis/hn/analisis_create_garantia_bien/analisis_create_garantia_bien_cubit.dart';

class V2CrearGarantiaDetalleScreen extends StatelessWidget {
  final TipoGarantiaEnumV2 tipoGarantia;
  final int objAnalisisGarantiaId;
  final TipoArticuloEnum tipoArticulo;
  const V2CrearGarantiaDetalleScreen({
    super.key,
    required this.tipoGarantia,
    required this.objAnalisisGarantiaId,
    required this.tipoArticulo,
  });

  @override
  Widget build(BuildContext context) {
    final repository = AnalisisRepositoryHNImpl();
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => EvaluadoresCnbsCubit(
            repository,
          )..getEvaluadoresGarantia(),
        ),
        BlocProvider(
          create: (ctx) => AnalisisCreateGarantiaBienCubit(
            repository,
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Agregar detalle ${tipoArticulo.name}'),
        ),
        body: V2CreateGarantiaDetalleBienInterceptor(
          tipoGarantia: tipoGarantia,
          objAnalisisGarantiaId: objAnalisisGarantiaId,
          tipoArticulo: tipoArticulo,
        ),
      ),
    );
  }
}

class V2CreateGarantiaDetalleBienInterceptor extends StatelessWidget {
  final TipoGarantiaEnumV2 tipoGarantia;
  final int objAnalisisGarantiaId;
  final TipoArticuloEnum tipoArticulo;
  const V2CreateGarantiaDetalleBienInterceptor({
    super.key,
    required this.tipoGarantia,
    required this.objAnalisisGarantiaId,
    required this.tipoArticulo,
  });

  @override
  Widget build(BuildContext context) {
    return switch (tipoGarantia) {
      TipoGarantiaEnumV2.prendaria => CrearDetalleBienPrendario(
          objAnalisisGarantiaId: objAnalisisGarantiaId,
          tipoArticulo: tipoArticulo,
        ),
      TipoGarantiaEnumV2.hipotecario => CrearDetalleBienHipotecario(
          objAnalisisGarantiaId: objAnalisisGarantiaId,
        ),
      TipoGarantiaEnumV2.liquido => const Text('Liquido'),
    };
  }
}
