import 'dart:convert';

import 'package:core_financiero_app/src/config/helpers/parsers/parse_format.dart';

UpdateSolicitudNuevaResponse updateSolicitudNuevaResponseFromJson(String str) =>
    UpdateSolicitudNuevaResponse.fromJson(json.decode(str));

class UpdateSolicitudNuevaResponse {
  final UpdateSolicitudNuevaData data;

  UpdateSolicitudNuevaResponse({
    required this.data,
  });

  factory UpdateSolicitudNuevaResponse.fromJson(Map<String, dynamic> json) =>
      UpdateSolicitudNuevaResponse(
        data: UpdateSolicitudNuevaData.fromJson(json['data']),
      );
}

class UpdateSolicitudNuevaData {
  final String? id;
  final String? origenSolicitudCodigo;
  final String? origenSolicitudNombre;
  final String? nombre1;
  final String? nombre2;
  final String? apellido1;
  final String? apellido2;
  final String? cedula;
  final String? paisEmisorCedulaCodigo;
  final String? paisEmisorCedulaNombre;
  final String? tipoDocumentoCodigo;
  final String? tipoDocumentoNombre;
  final String? tipoDocumentoConyugeCodigo;
  final String? tipoDocumentoConyugeNombre;
  final String? nombrePublico;
  final DateTime? fechaEmisionCedula;
  final DateTime? fechaVencimientoCedula;
  final DateTime? fechaNacimiento;
  final String? telefono;
  final String? celular;
  final String? direccionCasa;
  final String? barrioCasa;
  final String? municipioCasaCodigo;
  final String? municipioCasaNombre;
  final String? departamentoCasaCodigo;
  final String? departamentoCasaNombre;
  final String? paisCasaCodigo;
  final String? paisCasaNombre;
  final String? nacionalidad;
  final String? condicionCasaCodigo;
  final String? condicionCasaNombre;
  final int? anosResidirCasa;
  final String? email;
  final int? monto;
  final String? monedaCodigo;
  final String? monedaNombre;
  final String? propositoCodigo;
  final String? propositoNombre;
  final String? descripcionDestino;
  final String? frecuenciaCodigo;
  final String? frecuenciaNombre;
  final int? cuota;
  final String? sectorCodigo;
  final String? sectorNombre;
  final int? personasACargo;
  final String? estadoCivilCodigo;
  final String? estadoCivilNombre;
  final String? nombreConyugue;
  final bool? trabajaConyugue;
  final String? trabajoConyugue;
  final String? direccionTrabajoConyugue;
  final String? telefonoTrabajoConyugue;
  final String? productoCodigo;
  final String? productoNombre;
  final String? observacion;
  final String? ubicacionLongitud;
  final String? ubicacionLatitud;
  final String? escolaridadCodigo;
  final String? escolaridadNombre;
  final int? cantidadHijos;
  final String? sexoCodigo;
  final String? sexoNombre;
  final String? paisNacimientoCodigo;
  final String? paisNacimientoNombre;
  final String? nacionalidadConyugue;
  final String? ubicacion;
  final bool? esPeps;
  final String? nombreDeEntidadPeps;
  final String? paisPeps;
  final String? periodoPeps;
  final String? cargoOficialPeps;
  final bool? tieneFamiliarPeps;
  final String? nombreFamiliarPeps2;
  final String? parentescoFamiliarPeps2Codigo;
  final String? parentescoFamiliarPeps2Nombre;
  final String? cargoFamiliarPeps2;
  final String? nombreEntidadPeps2;
  final String? periodoPeps2;
  final String? paisPeps2;
  final String? actividadPredominanteCodigo;
  final String? actividadPredominanteNombre;
  final bool? esFamiliarEmpleado;
  final String? nombreFamiliar;
  final String? cedulaFamiliar;
  final String? tipoPersonaCodigo;
  final String? tipoPersonaNombre;
  final int? plazoSolicitud;
  final DateTime? fechaPrimerPagoSolicitud;
  final String? rtn;
  final String? codigoUsa;
  final String? tipoClienteCodigo;
  final String? tipoClienteNombre;
  final String? actividadEconomicaCiuu1Codigo;
  final String? actividadEconomicaCiuu1Nombre;
  final String? actividadEconomicaCiuu2Codigo;
  final String? actividadEconomicaCiuu2Nombre;
  final String? actividadEconomicaCiuu3Codigo;
  final String? actividadEconomicaCiuu3Nombre;
  final String? ocupacionCodigo;
  final String? ocupacionNombre;
  final String? profesionCodigo;
  final String? profesionNombre;
  final String? actividadEconomicaDescripcion1;
  final String? actividadEconomicaDescripcion2;
  final String? actividadEconomicaDescripcion3;
  final bool? ejerceApnfd;
  final bool? esApnfd;
  final String? paisDestinoCodigo;
  final String? paisDestinoNombre;
  final String? departamentoDestinoCodigo;
  final String? departamentoDestinoNombre;
  final String? municipioDestinoCodigo;
  final String? municipioDestinoNombre;
  final String? aldeaDestinoCodigo;
  final String? aldeaDestinoNombre;
  final String? caserioDestino;
  final String? barrioDestino;
  final String? caserioCasa;
  final String? aldeaCodigo;
  final String? aldeaNombre;
  final String? nombreNegocio;
  final String? direccionNegocio;
  final String? barrioNegocio;
  final String? caserioNegocio;
  final String? paisNegocioCodigo;
  final String? paisNegocioNombre;
  final String? departamentoNegocioCodigo;
  final String? departamentoNegocioNombre;
  final String? municipioNegocioCodigo;
  final String? municipioNegocioNombre;
  final String? aldeaNegocioCodigo;
  final String? aldeaNegocioNombre;
  final String? condicionNegocioCodigo;
  final String? condicionNegocioNombre;
  final String? telefonoNegocio;
  final String? celularNegocio;
  final String? tiempoFuncionamientoNegocio;
  final String? puestoNegocio;
  final String? horarioTrabajo;
  final String? experiencia;
  final String? horarioVisita;
  final int? ingresosNetos;
  final int? grupoCicloId;
  final String? cicloEstadoNombre;
  final String? cicloEstadoCodigo;
  final String? grupoNombre;
  final String? grupoCodigo;
  final String? nombre3;
  final String? apellido3;
  final String? nacionalidad2Codigo;
  final String? nacionalidad3Codigo;
  final String? nacionalidad2Nombre;
  final String? nacionalidad3Nombre;
  final String? tipoPersonaCNBSCodigo;
  final String? tipoPersonaCNBSNombre;
  final String? cargoGrupoCodigo;
  final String? cargoGrupoNombre;
  final String? actividadDescripcionConyuge;
  final String? documentoConyuge;
  final String? cargo;
  final String? direccionTrabajo;
  final String? barrioTrabajo;
  final String? telefonoTrabajo;
  final String? tiempoLaboral;
  final String? lugarTrabajoAnterior;
  final int? salarioNetoCordoba;
  final int? totalIngresoMes;
  final String? fuenteOtrosIngresos;
  final String? nombreTrabajo;
  final int? otrosIngresosCordoba;
  final String? profesionConyugue;
  final String? tiempoLaborarConyugue;
  final int? sueldoMesConyugue;
  final int? otrosIngresosConyugue;
  final String? fuenteOtrosIngresosConyugue;
  final String? nombreFamiliarCercano;
  final String? direccionFamiliarCercano;
  final String? telefonoFamiliarCercano;
  UpdateSolicitudNuevaData({
    this.id,
    this.origenSolicitudCodigo,
    this.origenSolicitudNombre,
    this.nombre1,
    this.nombre2,
    this.apellido1,
    this.apellido2,
    this.cedula,
    this.paisEmisorCedulaCodigo,
    this.paisEmisorCedulaNombre,
    this.tipoDocumentoCodigo,
    this.tipoDocumentoNombre,
    this.tipoDocumentoConyugeCodigo,
    this.tipoDocumentoConyugeNombre,
    this.nombrePublico,
    this.fechaEmisionCedula,
    this.fechaVencimientoCedula,
    this.fechaNacimiento,
    this.telefono,
    this.celular,
    this.direccionCasa,
    this.barrioCasa,
    this.municipioCasaCodigo,
    this.municipioCasaNombre,
    this.departamentoCasaCodigo,
    this.departamentoCasaNombre,
    this.paisCasaCodigo,
    this.paisCasaNombre,
    this.nacionalidad,
    this.condicionCasaCodigo,
    this.condicionCasaNombre,
    this.anosResidirCasa,
    this.email,
    this.monto,
    this.monedaCodigo,
    this.monedaNombre,
    this.propositoCodigo,
    this.propositoNombre,
    this.descripcionDestino,
    this.frecuenciaCodigo,
    this.frecuenciaNombre,
    this.cuota,
    this.sectorCodigo,
    this.sectorNombre,
    this.personasACargo,
    this.estadoCivilCodigo,
    this.estadoCivilNombre,
    this.nombreConyugue,
    this.trabajaConyugue,
    this.trabajoConyugue,
    this.direccionTrabajoConyugue,
    this.telefonoTrabajoConyugue,
    this.productoCodigo,
    this.productoNombre,
    this.observacion,
    this.ubicacionLongitud,
    this.ubicacionLatitud,
    this.escolaridadCodigo,
    this.escolaridadNombre,
    this.cantidadHijos,
    this.sexoCodigo,
    this.sexoNombre,
    this.paisNacimientoCodigo,
    this.paisNacimientoNombre,
    this.nacionalidadConyugue,
    this.ubicacion,
    this.esPeps,
    this.nombreDeEntidadPeps,
    this.paisPeps,
    this.periodoPeps,
    this.cargoOficialPeps,
    this.tieneFamiliarPeps,
    this.nombreFamiliarPeps2,
    this.parentescoFamiliarPeps2Codigo,
    this.parentescoFamiliarPeps2Nombre,
    this.cargoFamiliarPeps2,
    this.nombreEntidadPeps2,
    this.periodoPeps2,
    this.paisPeps2,
    this.actividadPredominanteCodigo,
    this.actividadPredominanteNombre,
    this.esFamiliarEmpleado,
    this.nombreFamiliar,
    this.cedulaFamiliar,
    this.tipoPersonaCodigo,
    this.tipoPersonaNombre,
    this.plazoSolicitud,
    this.fechaPrimerPagoSolicitud,
    this.rtn,
    this.codigoUsa,
    this.tipoClienteCodigo,
    this.tipoClienteNombre,
    this.actividadEconomicaCiuu1Codigo,
    this.actividadEconomicaCiuu1Nombre,
    this.actividadEconomicaCiuu2Codigo,
    this.actividadEconomicaCiuu2Nombre,
    this.actividadEconomicaCiuu3Codigo,
    this.actividadEconomicaCiuu3Nombre,
    this.ocupacionCodigo,
    this.ocupacionNombre,
    this.profesionCodigo,
    this.profesionNombre,
    this.actividadEconomicaDescripcion1,
    this.actividadEconomicaDescripcion2,
    this.actividadEconomicaDescripcion3,
    this.ejerceApnfd,
    this.esApnfd,
    this.paisDestinoCodigo,
    this.paisDestinoNombre,
    this.departamentoDestinoCodigo,
    this.departamentoDestinoNombre,
    this.municipioDestinoCodigo,
    this.municipioDestinoNombre,
    this.aldeaDestinoCodigo,
    this.aldeaDestinoNombre,
    this.caserioDestino,
    this.barrioDestino,
    this.caserioCasa,
    this.aldeaCodigo,
    this.aldeaNombre,
    this.nombreNegocio,
    this.direccionNegocio,
    this.barrioNegocio,
    this.caserioNegocio,
    this.paisNegocioCodigo,
    this.paisNegocioNombre,
    this.departamentoNegocioCodigo,
    this.departamentoNegocioNombre,
    this.municipioNegocioCodigo,
    this.municipioNegocioNombre,
    this.aldeaNegocioCodigo,
    this.aldeaNegocioNombre,
    this.condicionNegocioCodigo,
    this.condicionNegocioNombre,
    this.telefonoNegocio,
    this.celularNegocio,
    this.tiempoFuncionamientoNegocio,
    this.puestoNegocio,
    this.horarioTrabajo,
    this.experiencia,
    this.horarioVisita,
    this.ingresosNetos,
    this.grupoCicloId,
    this.cicloEstadoNombre,
    this.cicloEstadoCodigo,
    this.grupoNombre,
    this.grupoCodigo,
    this.nombre3,
    this.apellido3,
    this.nacionalidad2Codigo,
    this.nacionalidad3Codigo,
    this.nacionalidad2Nombre,
    this.nacionalidad3Nombre,
    this.tipoPersonaCNBSCodigo,
    this.tipoPersonaCNBSNombre,
    this.cargoGrupoCodigo,
    this.cargoGrupoNombre,
    this.actividadDescripcionConyuge,
    this.documentoConyuge,
    this.cargo,
    this.direccionTrabajo,
    this.barrioTrabajo,
    this.telefonoTrabajo,
    this.tiempoLaboral,
    this.lugarTrabajoAnterior,
    this.salarioNetoCordoba,
    this.totalIngresoMes,
    this.fuenteOtrosIngresos,
    this.nombreTrabajo,
    this.otrosIngresosCordoba,
    this.profesionConyugue,
    this.tiempoLaborarConyugue,
    this.sueldoMesConyugue,
    this.otrosIngresosConyugue,
    this.fuenteOtrosIngresosConyugue,
    this.nombreFamiliarCercano,
    this.direccionFamiliarCercano,
    this.telefonoFamiliarCercano,
  });

  factory UpdateSolicitudNuevaData.fromJson(Map<String, dynamic> json) =>
      UpdateSolicitudNuevaData(
        id: json['ID'],
        origenSolicitudCodigo: json['OrigenSolicitudCodigo'],
        origenSolicitudNombre: json['OrigenSolicitudNombre'],
        nombre1: json['Nombre1'],
        nombre2: json['Nombre2'],
        apellido1: json['Apellido1'],
        apellido2: json['Apellido2'],
        cedula: json['Cedula'],
        paisEmisorCedulaCodigo: json['PaisEmisorCedulaCodigo'],
        paisEmisorCedulaNombre: json['PaisEmisorCedulaNombre'],
        tipoDocumentoCodigo: json['TipoDocumentoCodigo'],
        tipoDocumentoNombre: json['TipoDocumentoNombre'],
        tipoDocumentoConyugeCodigo: json['TipoDocumentoConyugeCodigo'],
        tipoDocumentoConyugeNombre: json['TipoDocumentoConyugeNombre'],
        nombrePublico: json['NombrePublico'],
        fechaEmisionCedula: parseDate(json['FechaEmisionCedula']),
        fechaVencimientoCedula: parseDate(json['FechaVencimientoCedula']),
        fechaNacimiento: parseDate(json['FechaNacimiento']),
        telefono: json['Telefono'],
        celular: json['Celular'],
        direccionCasa: json['DireccionCasa'],
        barrioCasa: json['BarrioCasa'],
        municipioCasaCodigo: json['MunicipioCasaCodigo'],
        municipioCasaNombre: json['MunicipioCasaNombre'],
        departamentoCasaCodigo: json['DepartamentoCasaCodigo'],
        departamentoCasaNombre: json['DepartamentoCasaNombre'],
        paisCasaCodigo: json['PaisCasaCodigo'],
        paisCasaNombre: json['PaisCasaNombre'],
        nacionalidad: json['NacionalidadCodigo'],
        condicionCasaCodigo: json['CondicionCasaCodigo'],
        condicionCasaNombre: json['CondicionCasaNombre'],
        anosResidirCasa: parseInt(json['AnosResidirCasa']),
        email: json['Email'],
        monto: parseInt(json['Monto']),
        monedaCodigo: json['MonedaCodigo'],
        monedaNombre: json['MonedaNombre'],
        propositoCodigo: json['PropositoCodigo'],
        propositoNombre: json['PropositoNombre'],
        descripcionDestino: json['DescripcionDestino'],
        frecuenciaCodigo: json['FrecuenciaCodigo'],
        frecuenciaNombre: json['FrecuenciaNombre'],
        cuota: parseInt(json['Cuota']),
        sectorCodigo: json['SectorCodigo'],
        sectorNombre: json['SectorNombre'],
        personasACargo: parseInt(json['PersonasACargo']),
        estadoCivilCodigo: json['EstadoCivilCodigo'],
        estadoCivilNombre: json['EstadoCivilNombre'],
        nombreConyugue: json['NombreConyugue'],
        trabajaConyugue: parseBool(json['TrabajaConyugue']),
        trabajoConyugue: json['TrabajoConyugue'],
        direccionTrabajoConyugue: json['DireccionTrabajoConyugue'],
        telefonoTrabajoConyugue: json['TelefonoTrabajoConyugue'],
        productoCodigo: json['ProductoCodigo'],
        productoNombre: json['ProductoNombre'],
        observacion: json['Observacion'],
        ubicacionLongitud: json['UbicacionLongitud'],
        ubicacionLatitud: json['UbicacionLatitud'],
        escolaridadCodigo: json['EscolaridadCodigo'],
        escolaridadNombre: json['EscolaridadNombre'],
        cantidadHijos: parseInt(json['CantidadHijos']),
        sexoCodigo: json['SexoCodigo'],
        sexoNombre: json['SexoNombre'],
        paisNacimientoCodigo: json['PaisNacimientoCodigo'],
        paisNacimientoNombre: json['PaisNacimientoNombre'],
        nacionalidadConyugue: json['NacionalidadConyugue'],
        ubicacion: json['Ubicacion'],
        esPeps: parseBool(json['EsPEPS']),
        nombreDeEntidadPeps: json['NombreDeEntidadPeps'],
        paisPeps: json['PaisPeps'],
        periodoPeps: json['PeriodoPeps'],
        cargoOficialPeps: json['CargoOficialPeps'],
        tieneFamiliarPeps: parseBool(json['TieneFamiliarPeps']),
        nombreFamiliarPeps2: json['NombreFamiliarPeps2'],
        parentescoFamiliarPeps2Codigo: json['ParentescoFamiliarPeps2Codigo'],
        parentescoFamiliarPeps2Nombre: json['ParentescoFamiliarPeps2Nombre'],
        cargoFamiliarPeps2: json['CargoFamiliarPeps2'],
        nombreEntidadPeps2: json['NombreEntidadPeps2'],
        periodoPeps2: json['PeriodoPeps2'],
        paisPeps2: json['PaisPeps2'],
        actividadPredominanteCodigo: json['ActividadPredominanteCodigo'],
        actividadPredominanteNombre: json['ActividadPredominanteNombre'],
        esFamiliarEmpleado: parseBool(json['EsFamiliarEmpleado']),
        nombreFamiliar: json['NombreFamiliar'],
        cedulaFamiliar: json['CedulaFamiliar'],
        tipoPersonaCodigo: json['TipoPersonaCodigo'],
        tipoPersonaNombre: json['TipoPersonaNombre'],
        plazoSolicitud: parseInt(json['PlazoSolicitud']),
        fechaPrimerPagoSolicitud: parseDate(json['FechaPrimerPagoSolicitud']),
        rtn: json['RTN'],
        codigoUsa: json['CodigoUSA'],
        tipoClienteCodigo: json['TipoClienteCodigo'],
        tipoClienteNombre: json['TipoClienteNombre'],
        actividadEconomicaCiuu1Codigo: json['ActividadEconomicaCIUU1Codigo'],
        actividadEconomicaCiuu1Nombre: json['ActividadEconomicaCIUU1Nombre'],
        actividadEconomicaCiuu2Codigo: json['ActividadEconomicaCIUU2Codigo'],
        actividadEconomicaCiuu2Nombre: json['ActividadEconomicaCIUU2Nombre'],
        actividadEconomicaCiuu3Codigo: json['ActividadEconomicaCIUU3Codigo'],
        actividadEconomicaCiuu3Nombre: json['ActividadEconomicaCIUU3Nombre'],
        ocupacionCodigo: json['OcupacionCodigo'],
        ocupacionNombre: json['OcupacionNombre'],
        profesionCodigo: json['ProfesionCodigo'],
        profesionNombre: json['ProfesionNombre'],
        actividadEconomicaDescripcion1: json['ActividadEconomicaDescripcion1'],
        actividadEconomicaDescripcion2: json['ActividadEconomicaDescripcion2'],
        actividadEconomicaDescripcion3: json['ActividadEconomicaDescripcion3'],
        ejerceApnfd: parseBool(json['EjerceAPNFD']),
        esApnfd: parseBool(json['EsAPNFD']),
        paisDestinoCodigo: json['PaisDestinoCodigo'],
        paisDestinoNombre: json['PaisDestinoNombre'],
        departamentoDestinoCodigo: json['DepartamentoDestinoCodigo'],
        departamentoDestinoNombre: json['DepartamentoDestinoNombre'],
        municipioDestinoCodigo: json['MunicipioDestinoCodigo'],
        municipioDestinoNombre: json['MunicipioDestinoNombre'],
        aldeaDestinoCodigo: json['AldeaDestinoCodigo'],
        aldeaDestinoNombre: json['AldeaDestinoNombre'],
        caserioDestino: json['CaserioDestino'],
        barrioDestino: json['BarrioDestino'],
        caserioCasa: json['CaserioCasa'],
        aldeaCodigo: json['AldeaCodigo'],
        aldeaNombre: json['AldeaNombre'],
        nombreNegocio: json['NombreNegocio'],
        direccionNegocio: json['DireccionNegocio'],
        barrioNegocio: json['BarrioNegocio'],
        caserioNegocio: json['CaserioNegocio'],
        paisNegocioCodigo: json['PaisNegocioCodigo'],
        paisNegocioNombre: json['PaisNegocioNombre'],
        departamentoNegocioCodigo: json['DepartamentoNegocioCodigo'],
        departamentoNegocioNombre: json['DepartamentoNegocioNombre'],
        municipioNegocioCodigo: json['MunicipioNegocioCodigo'],
        municipioNegocioNombre: json['MunicipioNegocioNombre'],
        aldeaNegocioCodigo: json['AldeaNegocioCodigo'],
        aldeaNegocioNombre: json['AldeaNegocioNombre'],
        condicionNegocioCodigo: json['CondicionNegocioCodigo'],
        condicionNegocioNombre: json['CondicionNegocioNombre'],
        telefonoNegocio: json['TelefonoNegocio'],
        celularNegocio: json['CelularNegocio'],
        tiempoFuncionamientoNegocio: json['TiempoFuncionamientoNegocio'],
        puestoNegocio: json['puestoNegocio'],
        horarioTrabajo: json['HorarioTrabajo'],
        experiencia: json['experiencia'],
        horarioVisita: json['HorarioVisita'],
        ingresosNetos: parseInt(json['IngresosNetos']),
        grupoCicloId: parseInt(json['GrupoCicloID']),
        cicloEstadoNombre: json['CicloEstadoNombre'],
        cicloEstadoCodigo: json['CicloEstadoCodigo'],
        grupoNombre: json['GrupoNombre'],
        grupoCodigo: json['GrupoCodigo'],
        nombre3: json['Nombre3'],
        apellido3: json['Apellido3'],
        nacionalidad2Codigo: json['Nacionalidad2Codigo'],
        nacionalidad3Codigo: json['Nacionalidad3Codigo'],
        nacionalidad2Nombre: json['Nacionalidad2Nombre'],
        nacionalidad3Nombre: json['Nacionalidad3Nombre'],
        tipoPersonaCNBSCodigo: json['TipoPersonaCNBSCodigo'],
        tipoPersonaCNBSNombre: json['TipoPersonaCNBSNombre'],
        cargoGrupoCodigo: json['CargoGrupoCodigo'],
        cargoGrupoNombre: json['CargoGrupoNombre'],
        actividadDescripcionConyuge: json['ActividadDescripcionConyuge'],
        documentoConyuge: json['DocumentoConyuge'],
        cargo: json['Cargo'],
        direccionTrabajo: json['DireccionTrabajo'],
        barrioTrabajo: json['BarrioTrabajo'],
        telefonoTrabajo: json['TelefonoTrabajo'],
        tiempoLaboral: json['TiempoLaborar'],
        lugarTrabajoAnterior: json['LugarTrabajoAnterior'],
        salarioNetoCordoba: parseInt(json['SalarioNetoCordoba']),
        totalIngresoMes: parseInt(json['TotalIngresoMes']),
        fuenteOtrosIngresos: json['FuenteOtrosIngresos'],
        nombreTrabajo: json['NombreTrabajo'],
        otrosIngresosCordoba: parseInt(json['OtrosIngresosCordoba']),
        profesionConyugue: json['ProfesionConyugue'],
        tiempoLaborarConyugue: json['TiempoLaborarConyugue'],
        sueldoMesConyugue: parseInt(json['SueldoMesConyugue']),
        otrosIngresosConyugue: parseInt(json['OtrosIngresosConyugue']),
        fuenteOtrosIngresosConyugue: json['FuenteOtrosIngresosConyugue'],
        nombreFamiliarCercano: json['NombreFamiliarCercano'],
        direccionFamiliarCercano: json['DireccionFamiliarCercano'],
        telefonoFamiliarCercano: json['TelefonoFamiliarCercano'],
      );
}
