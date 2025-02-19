// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'solicitud_nueva_menor_cubit.dart';

class SolicitudNuevaMenorState extends Equatable {
  final String errorMsg;
  final Status status;
  final String objOrigenSolicitudId;
  final String nombre1;
  final String nombre2;
  final String apellido1;
  final String apellido2;
  final String cedula;
  final String objPaisEmisorCedula;
  final String fechaEmisionCedula;
  final String fechaVencimientoCedula;
  final String fechaNacimiento;
  final String telefono;
  final String celular;
  final String direccionCasa;
  final String barrioCasa;
  final String objMunicipioCasaId;
  final String objDepartamentoCasaId;
  final String objPaisCasaId;
  final String profesion;
  final String ocupacion;
  final String nacionalidad;
  final String objCondicionCasaId;
  final int anosResidirCasa;
  final String email;
  final int monto;
  final String objMonedaId;
  final String objPropositoId;
  final String objFrecuenciaId;
  final int cuota;
  final String objActividadId;
  final String objActividadId1;
  final String objActividadId2;
  final String objSectorId;
  final String nombreNegocio;
  final String tiempoFuncionamientoNegocio;
  final String direccionNegocio;
  final String barrioNegocio;
  final String objMunicipioNegocioId;
  final String objCondicionNegocioId;
  final String horarioTrabajo;
  final String horarioVisita;
  final int personasACargo;
  final String objEstadoCivilId;
  final String nombreConyugue;
  final bool trabajaConyugue;
  final String trabajoConyugue;
  final String direccionTrabajoConyugue;
  final String telefonoTrabajoConyugue;
  final String beneficiarioSeguro;
  final String cedulaBeneficiarioSeguro;
  final String objParentescoBeneficiarioSeguroId;
  final String beneficiarioSeguro1;
  final String cedulaBeneficiarioSeguro1;
  final String objParentescoBeneficiarioSeguroId1;
  final String objEstadoSolicitudId;
  final String objOficialCreditoId;
  final String objProductoId;
  final String observacion;
  final String sucursal;
  final String ubicacionLongitud;
  final String ubicacionLatitud;
  final String ubicacionGradosLongitud;
  final String ubicacionGradosLatitud;
  final String objEscolaridadId;
  final int cantidadHijos;
  final String nombrePublico;
  final String objSexoId;
  final String objPaisNacimientoId;
  final String nacionalidadConyugue;
  final String database;
  final String ubicacion;
  final bool espeps;
  final String nombreDeEntidadPeps;
  final String paisPeps;
  final String periodoPeps;
  final String cargoOficialPeps;
  final bool tieneFamiliarPeps;
  final String nombreFamiliarPeps2;
  final String parentescoFamiliarPeps2;
  final String cargoFamiliarPeps2;
  final String nombreEntidadPeps2;
  final String periodoPeps2;
  final String paisPeps2;
  final String objRubroActividad;
  final String objActividadPredominante;
  final bool esFamiliarEmpleado;
  final String nombreFamiliar;
  final String cedulaFamiliar;
  final String objTipoDocumentoId;
  final String objRubroActividad2;
  final String objRubroActividad3;
  final String objRubroActividadPredominante;
  final String tipoPersona;
  final String objTipoPersonaId;
  final String telefonoBeneficiario;
  final String telefonoBeneficiarioSeguro1;
  final int plazoSolicitud;
  final String fechaPrimerPagoSolicitud;
  const SolicitudNuevaMenorState({
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.objOrigenSolicitudId = 'CEL',
    this.nombre1 = '',
    this.nombre2 = '',
    this.apellido1 = 'Perez',
    this.apellido2 = 'Lopez',
    this.cedula = '123456789',
    this.objPaisEmisorCedula = 'NIC',
    this.fechaEmisionCedula = '2023-01-01T00:00:00.000Z',
    this.fechaVencimientoCedula = '2028-01-01T00:00:00.000Z',
    this.fechaNacimiento = '1990-01-01T00:00:00.000Z',
    this.telefono = '555-1234',
    this.celular = '555-5678',
    this.direccionCasa = '123 Main St',
    this.barrioCasa = 'Downtown',
    this.objMunicipioCasaId = '361',
    this.objDepartamentoCasaId = 'BOA',
    this.objPaisCasaId = 'NIC',
    this.profesion = 'Engineer',
    this.ocupacion = 'Software Developer',
    this.nacionalidad = 'Honduran',
    this.objCondicionCasaId = 'FAM',
    this.anosResidirCasa = 5,
    this.email = 'juan.perez@example.com',
    this.monto = 5000,
    this.objMonedaId = 'DOLAR',
    this.objPropositoId = 'CAP',
    this.objFrecuenciaId = 'MEN',
    this.cuota = 250,
    this.objActividadId = 'GAN',
    this.objActividadId1 = 'ABA',
    this.objActividadId2 = 'ASA',
    this.objSectorId = 'IND',
    this.nombreNegocio = 'Tech Solutions',
    this.tiempoFuncionamientoNegocio = '5',
    this.direccionNegocio = '456 Market St',
    this.barrioNegocio = 'Uptown',
    this.objMunicipioNegocioId = 'BOA',
    this.objCondicionNegocioId = 'PROP',
    this.horarioTrabajo = '9:00 AM - 5:00 PM',
    this.horarioVisita = '2:00 PM - 4:00 PM',
    this.personasACargo = 10,
    this.objEstadoCivilId = 'UNI',
    this.nombreConyugue = 'Maria Lopez',
    this.trabajaConyugue = true,
    this.trabajoConyugue = 'Teacher',
    this.direccionTrabajoConyugue = '789 School St',
    this.telefonoTrabajoConyugue = '555-9876',
    this.beneficiarioSeguro = 'Carlos Perez',
    this.cedulaBeneficiarioSeguro = '987654321',
    this.objParentescoBeneficiarioSeguroId = 'PAP',
    this.beneficiarioSeguro1 = 'Ana Perez',
    this.cedulaBeneficiarioSeguro1 = '876543210',
    this.objParentescoBeneficiarioSeguroId1 = 'PAREJ',
    this.objEstadoSolicitudId = 'REG',
    this.objOficialCreditoId = 'FAM',
    this.objProductoId = 'ESTNU',
    this.observacion = 'First-time applicant',
    this.sucursal = 'CH',
    this.ubicacionLongitud = '-87.2167',
    this.ubicacionLatitud = '14.0833',
    this.ubicacionGradosLongitud = '87°13\'00"W',
    this.ubicacionGradosLatitud = '14°05\'00"N',
    this.objEscolaridadId = 'SEC',
    this.cantidadHijos = 2,
    this.nombrePublico = 'JPerez',
    this.objSexoId = 'M',
    this.objPaisNacimientoId = 'NIC',
    this.nacionalidadConyugue = 'Honduran',
    this.database = 'MC_CH',
    this.ubicacion = 'RURAL',
    this.espeps = true,
    this.nombreDeEntidadPeps = 'Entidad Peps Name',
    this.paisPeps = 'Country',
    this.periodoPeps = '2023',
    this.cargoOficialPeps = 'Official Position',
    this.tieneFamiliarPeps = false,
    this.nombreFamiliarPeps2 = 'Familiar Name',
    this.parentescoFamiliarPeps2 = 'PAP',
    this.cargoFamiliarPeps2 = 'Familiar Position',
    this.nombreEntidadPeps2 = 'Familiar Entity Name',
    this.periodoPeps2 = '2023',
    this.paisPeps2 = 'Country 2',
    this.objRubroActividad = 'TRANSAEREA',
    this.objActividadPredominante = 'BILLA',
    this.esFamiliarEmpleado = true,
    this.nombreFamiliar = 'Familiar Employee Name',
    this.cedulaFamiliar = '12345678',
    this.objTipoDocumentoId = 'PASAPORTE',
    this.objRubroActividad2 = 'TERRENGANAD',
    this.objRubroActividad3 = 'MAQEQUIGANAD',
    this.objRubroActividadPredominante = 'GANADVACREPRODUC',
    this.tipoPersona = '',
    this.objTipoPersonaId = 'PERSONAFISICA',
    this.telefonoBeneficiario = '123-456-7890',
    this.telefonoBeneficiarioSeguro1 = '987-654-3210',
    this.plazoSolicitud = 12,
    this.fechaPrimerPagoSolicitud = '2023-01-01T00:00:00.000Z',
  });

  @override
  List<Object> get props => [
        errorMsg,
        status,
        objOrigenSolicitudId,
        nombre1,
        nombre2,
        apellido1,
        apellido2,
        cedula,
        objPaisEmisorCedula,
        fechaEmisionCedula,
        fechaVencimientoCedula,
        fechaNacimiento,
        telefono,
        celular,
        direccionCasa,
        barrioCasa,
        objMunicipioCasaId,
        objDepartamentoCasaId,
        objPaisCasaId,
        profesion,
        ocupacion,
        nacionalidad,
        objCondicionCasaId,
        anosResidirCasa,
        email,
        monto,
        objMonedaId,
        objPropositoId,
        objFrecuenciaId,
        cuota,
        objActividadId,
        objActividadId1,
        objActividadId2,
        objSectorId,
        nombreNegocio,
        tiempoFuncionamientoNegocio,
        direccionNegocio,
        barrioNegocio,
        objMunicipioNegocioId,
        objCondicionNegocioId,
        horarioTrabajo,
        horarioVisita,
        personasACargo,
        objEstadoCivilId,
        nombreConyugue,
        trabajaConyugue,
        trabajoConyugue,
        direccionTrabajoConyugue,
        telefonoTrabajoConyugue,
        beneficiarioSeguro,
        cedulaBeneficiarioSeguro,
        objParentescoBeneficiarioSeguroId,
        beneficiarioSeguro1,
        cedulaBeneficiarioSeguro1,
        objParentescoBeneficiarioSeguroId1,
        objEstadoSolicitudId,
        objOficialCreditoId,
        objProductoId,
        observacion,
        sucursal,
        ubicacionLongitud,
        ubicacionLatitud,
        ubicacionGradosLongitud,
        ubicacionGradosLatitud,
        objEscolaridadId,
        cantidadHijos,
        nombrePublico,
        objSexoId,
        objPaisNacimientoId,
        nacionalidadConyugue,
        database,
        ubicacion,
        espeps,
        nombreDeEntidadPeps,
        paisPeps,
        periodoPeps,
        cargoOficialPeps,
        tieneFamiliarPeps,
        nombreFamiliarPeps2,
        parentescoFamiliarPeps2,
        cargoFamiliarPeps2,
        nombreEntidadPeps2,
        periodoPeps2,
        paisPeps2,
        objRubroActividad,
        objActividadPredominante,
        esFamiliarEmpleado,
        nombreFamiliar,
        cedulaFamiliar,
        objTipoDocumentoId,
        objRubroActividad2,
        objRubroActividad3,
        objRubroActividadPredominante,
        tipoPersona,
        objTipoPersonaId,
        telefonoBeneficiario,
        telefonoBeneficiarioSeguro1,
        plazoSolicitud,
        fechaPrimerPagoSolicitud,
      ];

  SolicitudNuevaMenorState copyWith({
    String? errorMsg,
    Status? status,
    String? objOrigenSolicitudId,
    String? nombre1,
    String? nombre2,
    String? apellido1,
    String? apellido2,
    String? cedula,
    String? objPaisEmisorCedula,
    String? fechaEmisionCedula,
    String? fechaVencimientoCedula,
    String? fechaNacimiento,
    String? telefono,
    String? celular,
    String? direccionCasa,
    String? barrioCasa,
    String? objMunicipioCasaId,
    String? objDepartamentoCasaId,
    String? objPaisCasaId,
    String? profesion,
    String? ocupacion,
    String? nacionalidad,
    String? objCondicionCasaId,
    int? anosResidirCasa,
    String? email,
    int? monto,
    String? objMonedaId,
    String? objPropositoId,
    String? objFrecuenciaId,
    int? cuota,
    String? objActividadId,
    String? objActividadId1,
    String? objActividadId2,
    String? objSectorId,
    String? nombreNegocio,
    String? tiempoFuncionamientoNegocio,
    String? direccionNegocio,
    String? barrioNegocio,
    String? objMunicipioNegocioId,
    String? objCondicionNegocioId,
    String? horarioTrabajo,
    String? horarioVisita,
    int? personasACargo,
    String? objEstadoCivilId,
    String? nombreConyugue,
    bool? trabajaConyugue,
    String? trabajoConyugue,
    String? direccionTrabajoConyugue,
    String? telefonoTrabajoConyugue,
    String? beneficiarioSeguro,
    String? cedulaBeneficiarioSeguro,
    String? objParentescoBeneficiarioSeguroId,
    String? beneficiarioSeguro1,
    String? cedulaBeneficiarioSeguro1,
    String? objParentescoBeneficiarioSeguroId1,
    String? objEstadoSolicitudId,
    String? objOficialCreditoId,
    String? objProductoId,
    String? observacion,
    String? sucursal,
    String? ubicacionLongitud,
    String? ubicacionLatitud,
    String? ubicacionGradosLongitud,
    String? ubicacionGradosLatitud,
    String? objEscolaridadId,
    int? cantidadHijos,
    String? nombrePublico,
    String? objSexoId,
    String? objPaisNacimientoId,
    String? nacionalidadConyugue,
    String? database,
    String? ubicacion,
    bool? espeps,
    String? nombreDeEntidadPeps,
    String? paisPeps,
    String? periodoPeps,
    String? cargoOficialPeps,
    bool? tieneFamiliarPeps,
    String? nombreFamiliarPeps2,
    String? parentescoFamiliarPeps2,
    String? cargoFamiliarPeps2,
    String? nombreEntidadPeps2,
    String? periodoPeps2,
    String? paisPeps2,
    String? objRubroActividad,
    String? objActividadPredominante,
    bool? esFamiliarEmpleado,
    String? nombreFamiliar,
    String? cedulaFamiliar,
    String? objTipoDocumentoId,
    String? objRubroActividad2,
    String? objRubroActividad3,
    String? objRubroActividadPredominante,
    String? tipoPersona,
    String? objTipoPersonaId,
    String? telefonoBeneficiario,
    String? telefonoBeneficiarioSeguro1,
    int? plazoSolicitud,
    String? fechaPrimerPagoSolicitud,
  }) {
    return SolicitudNuevaMenorState(
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      objOrigenSolicitudId: objOrigenSolicitudId ?? this.objOrigenSolicitudId,
      nombre1: nombre1 ?? this.nombre1,
      nombre2: nombre2 ?? this.nombre2,
      apellido1: apellido1 ?? this.apellido1,
      apellido2: apellido2 ?? this.apellido2,
      cedula: cedula ?? this.cedula,
      objPaisEmisorCedula: objPaisEmisorCedula ?? this.objPaisEmisorCedula,
      fechaEmisionCedula: fechaEmisionCedula ?? this.fechaEmisionCedula,
      fechaVencimientoCedula:
          fechaVencimientoCedula ?? this.fechaVencimientoCedula,
      fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
      telefono: telefono ?? this.telefono,
      celular: celular ?? this.celular,
      direccionCasa: direccionCasa ?? this.direccionCasa,
      barrioCasa: barrioCasa ?? this.barrioCasa,
      objMunicipioCasaId: objMunicipioCasaId ?? this.objMunicipioCasaId,
      objDepartamentoCasaId:
          objDepartamentoCasaId ?? this.objDepartamentoCasaId,
      objPaisCasaId: objPaisCasaId ?? this.objPaisCasaId,
      profesion: profesion ?? this.profesion,
      ocupacion: ocupacion ?? this.ocupacion,
      nacionalidad: nacionalidad ?? this.nacionalidad,
      objCondicionCasaId: objCondicionCasaId ?? this.objCondicionCasaId,
      anosResidirCasa: anosResidirCasa ?? this.anosResidirCasa,
      email: email ?? this.email,
      monto: monto ?? this.monto,
      objMonedaId: objMonedaId ?? this.objMonedaId,
      objPropositoId: objPropositoId ?? this.objPropositoId,
      objFrecuenciaId: objFrecuenciaId ?? this.objFrecuenciaId,
      cuota: cuota ?? this.cuota,
      objActividadId: objActividadId ?? this.objActividadId,
      objActividadId1: objActividadId1 ?? this.objActividadId1,
      objActividadId2: objActividadId2 ?? this.objActividadId2,
      objSectorId: objSectorId ?? this.objSectorId,
      nombreNegocio: nombreNegocio ?? this.nombreNegocio,
      tiempoFuncionamientoNegocio:
          tiempoFuncionamientoNegocio ?? this.tiempoFuncionamientoNegocio,
      direccionNegocio: direccionNegocio ?? this.direccionNegocio,
      barrioNegocio: barrioNegocio ?? this.barrioNegocio,
      objMunicipioNegocioId:
          objMunicipioNegocioId ?? this.objMunicipioNegocioId,
      objCondicionNegocioId:
          objCondicionNegocioId ?? this.objCondicionNegocioId,
      horarioTrabajo: horarioTrabajo ?? this.horarioTrabajo,
      horarioVisita: horarioVisita ?? this.horarioVisita,
      personasACargo: personasACargo ?? this.personasACargo,
      objEstadoCivilId: objEstadoCivilId ?? this.objEstadoCivilId,
      nombreConyugue: nombreConyugue ?? this.nombreConyugue,
      trabajaConyugue: trabajaConyugue ?? this.trabajaConyugue,
      trabajoConyugue: trabajoConyugue ?? this.trabajoConyugue,
      direccionTrabajoConyugue:
          direccionTrabajoConyugue ?? this.direccionTrabajoConyugue,
      telefonoTrabajoConyugue:
          telefonoTrabajoConyugue ?? this.telefonoTrabajoConyugue,
      beneficiarioSeguro: beneficiarioSeguro ?? this.beneficiarioSeguro,
      cedulaBeneficiarioSeguro:
          cedulaBeneficiarioSeguro ?? this.cedulaBeneficiarioSeguro,
      objParentescoBeneficiarioSeguroId: objParentescoBeneficiarioSeguroId ??
          this.objParentescoBeneficiarioSeguroId,
      beneficiarioSeguro1: beneficiarioSeguro1 ?? this.beneficiarioSeguro1,
      cedulaBeneficiarioSeguro1:
          cedulaBeneficiarioSeguro1 ?? this.cedulaBeneficiarioSeguro1,
      objParentescoBeneficiarioSeguroId1: objParentescoBeneficiarioSeguroId1 ??
          this.objParentescoBeneficiarioSeguroId1,
      objEstadoSolicitudId: objEstadoSolicitudId ?? this.objEstadoSolicitudId,
      objOficialCreditoId: objOficialCreditoId ?? this.objOficialCreditoId,
      objProductoId: objProductoId ?? this.objProductoId,
      observacion: observacion ?? this.observacion,
      sucursal: sucursal ?? this.sucursal,
      ubicacionLongitud: ubicacionLongitud ?? this.ubicacionLongitud,
      ubicacionLatitud: ubicacionLatitud ?? this.ubicacionLatitud,
      ubicacionGradosLongitud:
          ubicacionGradosLongitud ?? this.ubicacionGradosLongitud,
      ubicacionGradosLatitud:
          ubicacionGradosLatitud ?? this.ubicacionGradosLatitud,
      objEscolaridadId: objEscolaridadId ?? this.objEscolaridadId,
      cantidadHijos: cantidadHijos ?? this.cantidadHijos,
      nombrePublico: nombrePublico ?? this.nombrePublico,
      objSexoId: objSexoId ?? this.objSexoId,
      objPaisNacimientoId: objPaisNacimientoId ?? this.objPaisNacimientoId,
      nacionalidadConyugue: nacionalidadConyugue ?? this.nacionalidadConyugue,
      database: database ?? this.database,
      ubicacion: ubicacion ?? this.ubicacion,
      espeps: espeps ?? this.espeps,
      nombreDeEntidadPeps: nombreDeEntidadPeps ?? this.nombreDeEntidadPeps,
      paisPeps: paisPeps ?? this.paisPeps,
      periodoPeps: periodoPeps ?? this.periodoPeps,
      cargoOficialPeps: cargoOficialPeps ?? this.cargoOficialPeps,
      tieneFamiliarPeps: tieneFamiliarPeps ?? this.tieneFamiliarPeps,
      nombreFamiliarPeps2: nombreFamiliarPeps2 ?? this.nombreFamiliarPeps2,
      parentescoFamiliarPeps2:
          parentescoFamiliarPeps2 ?? this.parentescoFamiliarPeps2,
      cargoFamiliarPeps2: cargoFamiliarPeps2 ?? this.cargoFamiliarPeps2,
      nombreEntidadPeps2: nombreEntidadPeps2 ?? this.nombreEntidadPeps2,
      periodoPeps2: periodoPeps2 ?? this.periodoPeps2,
      paisPeps2: paisPeps2 ?? this.paisPeps2,
      objRubroActividad: objRubroActividad ?? this.objRubroActividad,
      objActividadPredominante:
          objActividadPredominante ?? this.objActividadPredominante,
      esFamiliarEmpleado: esFamiliarEmpleado ?? this.esFamiliarEmpleado,
      nombreFamiliar: nombreFamiliar ?? this.nombreFamiliar,
      cedulaFamiliar: cedulaFamiliar ?? this.cedulaFamiliar,
      objTipoDocumentoId: objTipoDocumentoId ?? this.objTipoDocumentoId,
      objRubroActividad2: objRubroActividad2 ?? this.objRubroActividad2,
      objRubroActividad3: objRubroActividad3 ?? this.objRubroActividad3,
      objRubroActividadPredominante:
          objRubroActividadPredominante ?? this.objRubroActividadPredominante,
      tipoPersona: tipoPersona ?? this.tipoPersona,
      objTipoPersonaId: objTipoPersonaId ?? this.objTipoPersonaId,
      telefonoBeneficiario: telefonoBeneficiario ?? this.telefonoBeneficiario,
      telefonoBeneficiarioSeguro1:
          telefonoBeneficiarioSeguro1 ?? this.telefonoBeneficiarioSeguro1,
      plazoSolicitud: plazoSolicitud ?? this.plazoSolicitud,
      fechaPrimerPagoSolicitud:
          fechaPrimerPagoSolicitud ?? this.fechaPrimerPagoSolicitud,
    );
  }
}

final class SolicitudNuevaMenorInitial extends SolicitudNuevaMenorState {}
