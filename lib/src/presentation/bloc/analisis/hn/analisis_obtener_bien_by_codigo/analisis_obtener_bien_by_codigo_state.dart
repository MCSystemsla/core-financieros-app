// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_obtener_bien_by_codigo_cubit.dart';

class AnalisisObtenerBienByCodigoState extends Equatable {
  final String errorMsg;
  final Status status;
  final String bienId;
  final String bienCodigo;
  final String cedulaPropietario;
  final String observaciones;
  final String tipo;
  final String marca;
  final String modelo;
  final String color;
  final int anio;
  final String placa;
  final String serie;
  final String lugar;
  final String numeroReferencia;
  final String asiento;
  final String numTomo;
  final String folio;
  final String fechaInscripcion;
  final num areaVarasCuadradas;
  final num areaMetrosCuadrados;
  final String direccion;
  final int objTipoGarantiaId;
  final String departamentoCodigo;
  final String departamentoNombre;
  final String municipioCodigo;
  final String municipioNombre;
  final String aldeaCodigo;
  final String aldeaNombre;
  final String analisisGarantiaId;
  final String numeroSolicitud;
  final num montoGarantia;
  final int articuloCodigo;
  final String articuloTipo;
  final String articuloDescripcion;
  final String tipoValoracionCodigo;
  final String tipoValoracionNombre;
  final num valorComercial;
  final num valorAvaluo;
  final int evaluadorId;
  final String evaluadorNombre;
  const AnalisisObtenerBienByCodigoState({
    this.errorMsg = '',
    this.status = Status.notStarted,
    this.bienId = '',
    this.bienCodigo = '',
    this.cedulaPropietario = '',
    this.observaciones = '',
    this.tipo = '',
    this.marca = '',
    this.modelo = '',
    this.color = '',
    this.anio = 0,
    this.placa = '',
    this.serie = '',
    this.lugar = '',
    this.numeroReferencia = '',
    this.asiento = '',
    this.numTomo = '',
    this.folio = '',
    this.fechaInscripcion = '',
    this.areaVarasCuadradas = 0,
    this.areaMetrosCuadrados = 0,
    this.direccion = '',
    this.objTipoGarantiaId = 0,
    this.departamentoCodigo = '',
    this.departamentoNombre = '',
    this.municipioCodigo = '',
    this.municipioNombre = '',
    this.aldeaCodigo = '',
    this.aldeaNombre = '',
    this.analisisGarantiaId = '',
    this.numeroSolicitud = '',
    this.montoGarantia = 0,
    this.articuloCodigo = 0,
    this.articuloTipo = '',
    this.articuloDescripcion = '',
    this.tipoValoracionCodigo = '',
    this.tipoValoracionNombre = '',
    this.valorComercial = 0,
    this.valorAvaluo = 0,
    this.evaluadorId = 0,
    this.evaluadorNombre = '',
  });

  @override
  List<Object> get props => [
        errorMsg,
        status,
        bienId,
        bienCodigo,
        cedulaPropietario,
        observaciones,
        tipo,
        marca,
        modelo,
        color,
        anio,
        placa,
        serie,
        lugar,
        numeroReferencia,
        asiento,
        numTomo,
        folio,
        fechaInscripcion,
        areaVarasCuadradas,
        areaMetrosCuadrados,
        direccion,
        objTipoGarantiaId,
        departamentoCodigo,
        departamentoNombre,
        municipioCodigo,
        municipioNombre,
        aldeaCodigo,
        aldeaNombre,
        analisisGarantiaId,
        numeroSolicitud,
        montoGarantia,
        articuloCodigo,
        articuloTipo,
        articuloDescripcion,
        tipoValoracionCodigo,
        tipoValoracionNombre,
        valorComercial,
        valorAvaluo,
        evaluadorId,
        evaluadorNombre,
      ];

  AnalisisObtenerBienByCodigoState copyWith({
    String? errorMsg,
    Status? status,
    String? bienId,
    String? bienCodigo,
    String? cedulaPropietario,
    String? observaciones,
    String? tipo,
    String? marca,
    String? modelo,
    String? color,
    int? anio,
    String? placa,
    String? serie,
    String? lugar,
    String? numeroReferencia,
    String? asiento,
    String? numTomo,
    String? folio,
    String? fechaInscripcion,
    num? areaVarasCuadradas,
    num? areaMetrosCuadrados,
    String? direccion,
    int? objTipoGarantiaId,
    String? departamentoCodigo,
    String? departamentoNombre,
    String? municipioCodigo,
    String? municipioNombre,
    String? aldeaCodigo,
    String? aldeaNombre,
    String? analisisGarantiaId,
    String? numeroSolicitud,
    num? montoGarantia,
    int? articuloCodigo,
    String? articuloTipo,
    String? articuloDescripcion,
    String? tipoValoracionCodigo,
    String? tipoValoracionNombre,
    num? valorComercial,
    num? valorAvaluo,
    int? evaluadorId,
    String? evaluadorNombre,
  }) {
    return AnalisisObtenerBienByCodigoState(
      errorMsg: errorMsg ?? this.errorMsg,
      status: status ?? this.status,
      bienId: bienId ?? this.bienId,
      bienCodigo: bienCodigo ?? this.bienCodigo,
      cedulaPropietario: cedulaPropietario ?? this.cedulaPropietario,
      observaciones: observaciones ?? this.observaciones,
      tipo: tipo ?? this.tipo,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      color: color ?? this.color,
      anio: anio ?? this.anio,
      placa: placa ?? this.placa,
      serie: serie ?? this.serie,
      lugar: lugar ?? this.lugar,
      numeroReferencia: numeroReferencia ?? this.numeroReferencia,
      asiento: asiento ?? this.asiento,
      numTomo: numTomo ?? this.numTomo,
      folio: folio ?? this.folio,
      fechaInscripcion: fechaInscripcion ?? this.fechaInscripcion,
      areaVarasCuadradas: areaVarasCuadradas ?? this.areaVarasCuadradas,
      areaMetrosCuadrados: areaMetrosCuadrados ?? this.areaMetrosCuadrados,
      direccion: direccion ?? this.direccion,
      objTipoGarantiaId: objTipoGarantiaId ?? this.objTipoGarantiaId,
      departamentoCodigo: departamentoCodigo ?? this.departamentoCodigo,
      departamentoNombre: departamentoNombre ?? this.departamentoNombre,
      municipioCodigo: municipioCodigo ?? this.municipioCodigo,
      municipioNombre: municipioNombre ?? this.municipioNombre,
      aldeaCodigo: aldeaCodigo ?? this.aldeaCodigo,
      aldeaNombre: aldeaNombre ?? this.aldeaNombre,
      analisisGarantiaId: analisisGarantiaId ?? this.analisisGarantiaId,
      numeroSolicitud: numeroSolicitud ?? this.numeroSolicitud,
      montoGarantia: montoGarantia ?? this.montoGarantia,
      articuloCodigo: articuloCodigo ?? this.articuloCodigo,
      articuloTipo: articuloTipo ?? this.articuloTipo,
      articuloDescripcion: articuloDescripcion ?? this.articuloDescripcion,
      tipoValoracionCodigo: tipoValoracionCodigo ?? this.tipoValoracionCodigo,
      tipoValoracionNombre: tipoValoracionNombre ?? this.tipoValoracionNombre,
      valorComercial: valorComercial ?? this.valorComercial,
      valorAvaluo: valorAvaluo ?? this.valorAvaluo,
      evaluadorId: evaluadorId ?? this.evaluadorId,
      evaluadorNombre: evaluadorNombre ?? this.evaluadorNombre,
    );
  }
}

final class AnalisisObtenerBienByCodigoInitial
    extends AnalisisObtenerBienByCodigoState {}
