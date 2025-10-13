import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/config/helpers/autosave/hn/nueva_menor_hn_autosave.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/asalariado/local_db/solicitudes_hn_box_service.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/local_db/solicitud_nueva_menor_hn_local_db.dart';
import 'package:core_financiero_app/src/datasource/solicitudes/hn/solicitudes/nuevamenor/solicitud_nueva_menor_hn.dart';
import 'package:core_financiero_app/src/domain/repository/solicitudes_credito/hn/solicitudes_credito_hn_repository.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/utils/extensions/lang/lang_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'solicitud_nueva_menor_hn_state.dart';

class SolicitudNuevaMenorHnCubit extends Cubit<SolicitudNuevaMenorHnState> {
  final SolicitudesCreditoHnRepository _repository;
  late final NuevaMenorHnAutosave autoSaveHelper;
  final SolicitudesHnBoxService localDbProvider;
  SolicitudNuevaMenorHnCubit(
    this._repository,
    this.localDbProvider,
  ) : super(SolicitudNuevaMenorHnInitial());

  Future<void> createSolicitudNuevaMenor() async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final (isOk, msg, numeroSolicitud) =
          await _repository.createSolicitudNuevaMenor(
        solicitud: SolicitudNuevaMenorHn(
          email: state.email,
          nombre2: state.nombre2,
          apellido2: state.apellido2,
          database: state.database,
          origenSolicitudCodigo: state.origenSolicitudCodigo,
          nombre1: state.nombre1,
          apellido1: state.apellido1,
          cedula: state.cedula,
          paisEmisorCedulaCodigo: state.paisEmisorCedulaCodigo,
          fechaEmisionCedula: DateTime.parse(state.fechaEmisionCedula),
          fechaVencimientoCedula: DateTime.parse(state.fechaVencimientoCedula),
          fechaNacimiento: DateTime.parse(state.fechaNacimiento),
          telefono: state.telefono,
          celular: state.celular,
          direccionCasa: state.direccionCasa,
          barrioCasa: state.barrioCasa,
          municipioCasaCodigo: state.municipioCasaCodigo,
          departamentoCasaCodigo: state.departamentoCasaCodigo,
          paisCasaCodigo: state.paisCasaCodigo,
          profesion: state.profesion,
          ocupacion: state.ocupacion,
          condicionCasaCodigo: state.condicionCasaCodigo,
          anosResidirCasa: state.anosResidirCasa,
          monto: state.monto,
          monedaCodigo: state.monedaCodigo,
          propositoCodigo: state.propositoCodigo,
          frecuenciaCodigo: state.frecuenciaCodigo,
          cuota: state.cuota,
          sectorCodigo: state.sectorCodigo,
          nombreNegocio: state.nombreNegocio,
          tiempoFuncionamientoNegocio: state.tiempoFuncionamientoNegocio,
          direccionNegocio: state.direccionNegocio,
          barrioNegocio: state.barrioNegocio,
          municipioNegocioCodigo: state.municipioNegocioCodigo,
          condicionNegocioCodigo: state.condicionNegocioCodigo,
          horarioTrabajo: state.horarioTrabajo,
          horarioVisita: state.horarioVisita,
          personasACargo: state.personasACargo,
          estadoCivilCodigo: state.estadoCivilCodigo,
          nombreConyugue: state.nombreConyugue,
          trabajaConyugue: state.trabajaConyugue == 'input.yes'.tr(),
          trabajoConyugue: state.trabajoConyugue,
          direccionTrabajoConyugue: state.direccionTrabajoConyugue,
          telefonoTrabajoConyugue: state.telefonoTrabajoConyugue,
          productoCodigo: state.productoCodigo,
          observacion: state.observacion,
          sucursal: state.sucursal,
          ubicacionLongitud: state.ubicacionLongitud,
          ubicacionLatitud: state.ubicacionLatitud,
          escolaridadCodigo: state.escolaridadCodigo,
          cantidadHijos: state.cantidadHijos,
          nombrePublico: state.nombrePublico,
          sexoCodigo: state.sexoCodigo,
          paisNacimientoCodigo: state.paisNacimientoCodigo,
          nacionalidadConyugue: state.nacionalidadConyugue,
          ubicacion: state.ubicacion,
          espeps: state.espeps == 'input.yes'.tr(),
          nombreDeEntidadPeps: state.nombreDeEntidadPeps,
          paisPeps: state.paisPeps,
          periodoPeps: state.periodoPeps,
          cargoOficialPeps: state.cargoOficialPeps,
          tieneFamiliarPeps: state.tieneFamiliarPeps == 'input.yes'.tr(),
          nombreFamiliarPeps2: state.nombreFamiliarPeps2,
          parentescoFamiliarPeps2Codigo: state.parentescoFamiliarPeps2Codigo,
          cargoFamiliarPeps2: state.cargoFamiliarPeps2,
          nombreEntidadPeps2: state.nombreEntidadPeps2,
          periodoPeps2: state.periodoPeps2,
          paisPeps2: state.paisPeps2,
          esFamiliarEmpleado: state.esFamiliarEmpleado == 'input.yes'.tr(),
          nombreFamiliar: state.nombreFamiliar,
          cedulaFamiliar: state.cedulaFamiliar,
          tipoDocumentoCodigo: state.tipoDocumentoCodigo,
          tipoPersonaCodigo: state.tipoPersonaCodigo,
          plazoSolicitud: state.plazoSolicitud,
          fechaPrimerPagoSolicitud:
              DateTime.parse(state.fechaPrimerPagoSolicitud),
          isOffline: state.isOffline,
          codigoUsa: state.codigoUsa,
          nombre3: state.nombre3,
          apellido3: state.apellido3,
          rtn: state.rtn,
          telefonoNegocio: state.telefonoNegocio,
          celularNegocio: state.celularNegocio,
          actividadDescripcionConyugue: state.actividadDescripcionConyugue,
          exeperiencia: state.exeperiencia,
          puestoNegocio: state.puestoNegocio,
          actividadEconomicaCnbs1Codigo: state.actividadEconomicaCnbs1Codigo,
          actividadEconomicaCnbs2Codigo: state.actividadEconomicaCnbs2Codigo,
          actividaEconomicaDescipcion1: state.actividaEconomicaDescipcion1,
          actividaEconomicaDescipcion2: state.actividaEconomicaDescipcion2,
          actividaEconomicaDescipcion3: state.actividaEconomicaDescipcion3,
          ejerceApnfd: state.ejerceApnfd == 'input.yes'.tr(),
          esApnfd: state.esApnfd == 'input.yes'.tr(),
          nacinalidadCodigo: state.nacinalidadCodigo,
          nacinalidad2Codigo: state.nacinalidad2Codigo,
          nacinalidad3Codigo: state.nacinalidad3Codigo,
          departamentoDestinoCodigo: state.departamentoDestinoCodigo,
          tipoPersonaCnbsCodigo: state.tipoPersonaCnbsCodigo,
          tipoClienteCodigo: state.tipoClienteCodigo,
          aldeaDestinoCodigo: state.aldeaDestinoCodigo,
          municipioDestinoCodigo: state.municipioDestinoCodigo,
          aldeaNegocioCodigo: state.aldeaNegocioCodigo,
          departamentoNegocioCodigo: state.departamentoNegocioCodigo,
          nivelAproximadoIngresosCodigo: state.nivelAproximadoIngresosCodigo,
          documentoConyuge: state.documentoConyuge,
          ocupacionCodigo: state.ocupacionCodigo,
          profesionCodigo: state.profesionCodigo,
          aldeaCasaCodigo: state.aldeaCasaCodigo,
          ubicacionCodigo: state.ubicacionCodigo,
          medidasConocimientoCodigo: state.medidasConocimientoCodigo,
          caserioCasa: state.caserioCasa,
          caserioNegocio: state.caserioNegocio,
          caserioDestino: state.caserioDestino,
          barrioDestino: state.barrioDestino,
          descripcionDestino: state.descripcionDestino,
          ingresosNetos: state.ingresosNetos,
        ),
      );
      if (!isOk) {
        emit(
          state.copyWith(
            status: Status.error,
            errorMsg: msg,
          ),
        );
        return;
      }
      emit(state.copyWith(
        status: Status.done,
        numeroSolicitud: numeroSolicitud,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.error,
          errorMsg: e.toString(),
        ),
      );
    }
  }

  sendCedulaImages({required String numeroSolicitud}) async {
    try {
      await _repository.sendCedulaImageWhenSolicitudCreditoCreated(
        numeroSolicitud: int.parse(numeroSolicitud),
        cedulaCliente: state.cedula,
        imagenFrontal: state.cedulaFrontPath,
        imagenTrasera: state.cedulaBackPath,
      );
    } catch (_) {}
  }

  void initAutoSave({String? uuid}) {
    final newUuid = uuid ?? state.uuid ?? const Uuid().v4();

    emit(state.copyWith(uuid: newUuid));

    autoSaveHelper = NuevaMenorHnAutosave(
      box: localDbProvider.solicitudesNuevaMenorBox,
      buildModel: _buildModel,
      uuid: newUuid,
      onSaved: (m) {
        emit(state.copyWith(
          idLocalResponse: m.id,
          uuid: m.uuid,
        ));
      },
    );
  }

  SolicitudNuevaMenorHnLocalDb _buildModel(
    SolicitudNuevaMenorHnLocalDb? existing,
  ) {
    final prev = existing;

    return SolicitudNuevaMenorHnLocalDb(
      id: prev?.id ?? 0,
      uuid: prev?.uuid ?? state.uuid ?? const Uuid().v4(),
      database: _prefer(state.database, prev?.database),
      apellido2: _prefer(state.apellido2, prev?.apellido2),
      nombre2: _prefer(state.nombre2, prev?.nombre2),
      origenSolicitudCodigo:
          _prefer(state.origenSolicitudCodigo, prev?.origenSolicitudCodigo),
      nombre1: _prefer(state.nombre1, prev?.nombre1),
      apellido1: _prefer(state.apellido1, prev?.apellido1),
      cedula: _prefer(state.cedula, prev?.cedula),
      observacion: _prefer(state.observacion, prev?.observacion),
      fechaEmisionCedula: _preferDate(
        (state.fechaEmisionCedula),
        prev?.fechaEmisionCedula,
      ),
      fechaVencimientoCedula: _preferDate(
        (state.fechaVencimientoCedula),
        prev?.fechaVencimientoCedula,
      ),
      fechaNacimiento: _preferDate(
        (state.fechaNacimiento),
        prev?.fechaNacimiento,
      ),
      telefono: _prefer(state.telefono, prev?.telefono),
      celular: _prefer(state.celular, prev?.celular),
      direccionCasa: _prefer(state.direccionCasa, prev?.direccionCasa),
      barrioCasa: _prefer(state.barrioCasa, prev?.barrioCasa),
      municipioCasaCodigo:
          _prefer(state.municipioCasaCodigo, prev?.municipioCasaCodigo),
      departamentoCasaCodigo:
          _prefer(state.departamentoCasaCodigo, prev?.departamentoCasaCodigo),
      paisCasaCodigo: _prefer(state.paisCasaCodigo, prev?.paisCasaCodigo),
      profesion: _prefer(state.profesion, prev?.profesion),
      ocupacion: _prefer(state.ocupacion, prev?.ocupacion),
      condicionCasaCodigo:
          _prefer(state.condicionCasaCodigo, prev?.condicionCasaCodigo),
      anosResidirCasa: state.anosResidirCasa == 0
          ? (prev?.anosResidirCasa ?? 0)
          : state.anosResidirCasa,
      actividaEconomicaDescipcion1: _prefer(state.actividaEconomicaDescipcion1,
          prev?.actividaEconomicaDescipcion1),
      actividaEconomicaDescipcion2: _prefer(state.actividaEconomicaDescipcion2,
          prev?.actividaEconomicaDescipcion2),
      actividaEconomicaDescipcion3: _prefer(state.actividaEconomicaDescipcion3,
          prev?.actividaEconomicaDescipcion3),
      ejerceApnfd: _prefer(state.ejerceApnfd, prev?.ejerceApnfd),
      esApnfd: _prefer(state.esApnfd, prev?.esApnfd),
      nacinalidadCodigo:
          _prefer(state.nacinalidadCodigo, prev?.nacinalidadCodigo),
      nacinalidad2Codigo:
          _prefer(state.nacinalidad2Codigo, prev?.nacinalidad2Codigo),
      nacinalidad3Codigo:
          _prefer(state.nacinalidad3Codigo, prev?.nacinalidad3Codigo),
      departamentoDestinoCodigo: _prefer(
          state.departamentoDestinoCodigo, prev?.departamentoDestinoCodigo),
      tipoPersonaCodigo:
          _prefer(state.tipoPersonaCodigo, prev?.tipoPersonaCodigo),
      tipoClienteCodigo:
          _prefer(state.tipoClienteCodigo, prev?.tipoClienteCodigo),
      aldeaDestinoCodigo:
          _prefer(state.aldeaDestinoCodigo, prev?.aldeaDestinoCodigo),
      municipioDestinoCodigo:
          _prefer(state.municipioDestinoCodigo, prev?.municipioDestinoCodigo),
      aldeaNegocioCodigo:
          _prefer(state.aldeaNegocioCodigo, prev?.aldeaNegocioCodigo),
      departamentoNegocioCodigo: _prefer(
          state.departamentoNegocioCodigo, prev?.departamentoNegocioCodigo),
      nivelAproximadoIngresosCodigo: _prefer(
          state.nivelAproximadoIngresosCodigo,
          prev?.nivelAproximadoIngresosCodigo),
      documentoConyuge: _prefer(state.documentoConyuge, prev?.documentoConyuge),
      ocupacionCodigo: _prefer(state.ocupacionCodigo, prev?.ocupacionCodigo),
      profesionCodigo: _prefer(state.profesionCodigo, prev?.profesionCodigo),
      aldeaCasaCodigo: _prefer(state.aldeaCasaCodigo, prev?.aldeaCasaCodigo),
      ubicacionCodigo: _prefer(state.ubicacionCodigo, prev?.ubicacionCodigo),
      medidasConocimientoCodigo: _prefer(
          state.medidasConocimientoCodigo, prev?.medidasConocimientoCodigo),
      caserioCasa: _prefer(state.caserioCasa, prev?.caserioCasa),
      caserioNegocio: _prefer(state.caserioNegocio, prev?.caserioNegocio),
      caserioDestino: _prefer(state.caserioDestino, prev?.caserioDestino),
      barrioDestino: _prefer(state.barrioDestino, prev?.barrioDestino),
      descripcionDestino:
          _prefer(state.descripcionDestino, prev?.descripcionDestino),
      ingresosNetos: state.ingresosNetos == 0
          ? (prev?.ingresosNetos ?? 0)
          : state.ingresosNetos,
      actividadDescripcionConyugue: _prefer(state.actividadDescripcionConyugue,
          prev?.actividadDescripcionConyugue),
      exeperiencia: state.exeperiencia == 0
          ? (prev?.exeperiencia ?? 0)
          : state.exeperiencia,
      puestoNegocio: _prefer(state.puestoNegocio, prev?.puestoNegocio),
      actividadEconomicaCnbs1Codigo: _prefer(
          state.actividadEconomicaCnbs1Codigo,
          prev?.actividadEconomicaCnbs1Codigo),
      actividadEconomicaCnbs2Codigo: _prefer(
          state.actividadEconomicaCnbs2Codigo,
          prev?.actividadEconomicaCnbs2Codigo),
      apellido3: _prefer(state.apellido3, prev?.apellido3),
      rtn: _prefer(state.rtn, prev?.rtn),
      telefonoNegocio: _prefer(state.telefonoNegocio, prev?.telefonoNegocio),
      celularNegocio: _prefer(state.celularNegocio, prev?.celularNegocio),
      barrioNegocio: _prefer(state.barrioNegocio, prev?.barrioNegocio),
      municipioNegocioCodigo:
          _prefer(state.municipioNegocioCodigo, prev?.municipioNegocioCodigo),
      condicionNegocioCodigo:
          _prefer(state.condicionNegocioCodigo, prev?.condicionNegocioCodigo),
      horarioTrabajo: _prefer(state.horarioTrabajo, prev?.horarioTrabajo),
      horarioVisita: _prefer(state.horarioVisita, prev?.horarioVisita),
      personasACargo: state.personasACargo == 0
          ? (prev?.personasACargo ?? 0)
          : state.personasACargo,
      estadoCivilCodigo:
          _prefer(state.estadoCivilCodigo, prev?.estadoCivilCodigo),
      nombreConyugue: _prefer(state.nombreConyugue, prev?.nombreConyugue),
      trabajaConyugue: _prefer(state.trabajaConyugue, prev?.trabajaConyugue),
      trabajoConyugue: _prefer(state.trabajoConyugue, prev?.trabajoConyugue),
      direccionTrabajoConyugue: _prefer(
          state.direccionTrabajoConyugue, prev?.direccionTrabajoConyugue),
      telefonoTrabajoConyugue:
          _prefer(state.telefonoTrabajoConyugue, prev?.telefonoTrabajoConyugue),
      cantidadHijos: state.cantidadHijos == 0
          ? (prev?.cantidadHijos ?? 0)
          : state.cantidadHijos,
      nombrePublico: _prefer(state.nombrePublico, prev?.nombrePublico),
      sexoCodigo: _prefer(state.sexoCodigo, prev?.sexoCodigo),
      paisNacimientoCodigo:
          _prefer(state.paisNacimientoCodigo, prev?.paisNacimientoCodigo),
      nacionalidadConyugue:
          _prefer(state.nacionalidadConyugue, prev?.nacionalidadConyugue),
      ubicacion: _prefer(state.ubicacion, prev?.ubicacion),
      espeps: _prefer(state.espeps, prev?.espeps),
      nombreDeEntidadPeps:
          _prefer(state.nombreDeEntidadPeps, prev?.nombreDeEntidadPeps),
      paisPeps: _prefer(state.paisPeps, prev?.paisPeps),
      periodoPeps: _prefer(state.periodoPeps, prev?.periodoPeps),
      cargoOficialPeps: _prefer(state.cargoOficialPeps, prev?.cargoOficialPeps),
      tieneFamiliarPeps:
          _prefer(state.tieneFamiliarPeps, prev?.tieneFamiliarPeps),
      nombreFamiliarPeps2:
          _prefer(state.nombreFamiliarPeps2, prev?.nombreFamiliarPeps2),
      parentescoFamiliarPeps2Codigo: _prefer(
          state.parentescoFamiliarPeps2Codigo,
          prev?.parentescoFamiliarPeps2Codigo),
      cargoFamiliarPeps2:
          _prefer(state.cargoFamiliarPeps2, prev?.cargoFamiliarPeps2),
      nombreEntidadPeps2:
          _prefer(state.nombreEntidadPeps2, prev?.nombreEntidadPeps2),
      periodoPeps2: _prefer(state.periodoPeps2, prev?.periodoPeps2),
      paisPeps2: _prefer(state.paisPeps2, prev?.paisPeps2),
      esFamiliarEmpleado:
          _prefer(state.esFamiliarEmpleado, prev?.esFamiliarEmpleado),
      nombreFamiliar: _prefer(state.nombreFamiliar, prev?.nombreFamiliar),
      cedulaFamiliar: _prefer(state.cedulaFamiliar, prev?.cedulaFamiliar),
      tipoDocumentoCodigo:
          _prefer(state.tipoDocumentoCodigo, prev?.tipoDocumentoCodigo),
      codigoUsa: _prefer(state.codigoUsa, prev?.codigoUsa),
      nombre3: _prefer(state.nombre3, prev?.nombre3),
      cuota: state.cuota == 0 ? (prev?.cuota ?? 0) : state.cuota,
      sectorCodigo: _prefer(state.sectorCodigo, prev?.sectorCodigo),
      direccionNegocio: _prefer(state.direccionNegocio, prev?.direccionNegocio),
      tipoPersonaCnbsCodigo:
          _prefer(state.tipoPersonaCnbsCodigo, prev?.tipoPersonaCnbsCodigo),
      escolaridadCodigo:
          _prefer(state.escolaridadCodigo, prev?.escolaridadCodigo),
      ubicacionLongitud:
          _prefer(state.ubicacionLongitud, prev?.ubicacionLongitud),
      ubicacionLatitud: _prefer(state.ubicacionLatitud, prev?.ubicacionLatitud),
      fechaPrimerPagoSolicitud: _preferDate(
        state.fechaPrimerPagoSolicitud,
        prev?.fechaPrimerPagoSolicitud,
      ),
      frecuenciaCodigo: _prefer(state.frecuenciaCodigo, prev?.frecuenciaCodigo),
      monedaCodigo: _prefer(state.monedaCodigo, prev?.monedaCodigo),
      monto: state.monto == 0 ? (prev?.monto ?? 0) : state.monto,
      nombreNegocio: _prefer(state.nombreNegocio, prev?.nombreNegocio),
      tiempoFuncionamientoNegocio: _prefer(
          state.tiempoFuncionamientoNegocio, prev?.tiempoFuncionamientoNegocio),
      paisEmisorCedulaCodigo:
          _prefer(state.paisEmisorCedulaCodigo, prev?.paisEmisorCedulaCodigo),
      plazoSolicitud: state.plazoSolicitud == 0
          ? (prev?.plazoSolicitud ?? 0)
          : state.plazoSolicitud,
      productoCodigo: _prefer(state.productoCodigo, prev?.productoCodigo),
      propositoCodigo: _prefer(state.propositoCodigo, prev?.propositoCodigo),
      isOffline: prev?.isOffline ?? false,
      email: _prefer(state.email, prev?.email),
    );
  }

  void onFieldChanged(SolicitudNuevaMenorHnState Function() copyWithFn) {
    emit(copyWithFn());
    autoSaveHelper.trigger();
  }

  String _prefer(String? current, String? previous) =>
      current?.isNotEmpty == true ? current! : previous ?? '';
  DateTime? _preferDate(String? current, DateTime? previous) {
    final parsed = DateTime.tryParse(current ?? '');
    return parsed ?? previous;
  }

  void saveCedula({
    String? cedulaFrontPath,
    String? cedulaBackPath,
  }) {
    emit(
      state.copyWith(
        cedulaFrontPath: cedulaFrontPath,
        cedulaBackPath: cedulaBackPath,
      ),
    );
  }
}
