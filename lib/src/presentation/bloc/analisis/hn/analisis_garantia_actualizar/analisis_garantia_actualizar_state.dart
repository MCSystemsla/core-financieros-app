// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_garantia_actualizar_cubit.dart';

class AnalisisGarantiaActualizarState extends Equatable {
  final Status status;
  final String errorMsg;
  final String codigoBien;
  final int objAnalisisGarantiaId;
  final String observaciones;
  final String cedulaPropietario;
  final String departamentoCodigo;
  final String municipioCodigo;
  final String aldeaCodigo;
  final double valorComercial;
  final double valorAvaluo;
  final String tipoValoracionCodigo;
  final int objValuadorId;
  final String familia;
  final String numEscritura;
  final String numTomo;
  final String folio;
  final String fechaInscripcion;
  final double areaVarasCuadradas;
  final double areaMetrosCuadrados;
  final String direccion;
  final String tipo;
  final String marca;
  final String modelo;
  final int anio;
  final String color;
  final String placa;
  final String serie;
  final String lugar;
  final String numeroReferencia;
  final String descripcion;

  const AnalisisGarantiaActualizarState({
    this.status = Status.notStarted,
    this.errorMsg = '',
    this.codigoBien = '',
    this.objAnalisisGarantiaId = 0,
    this.observaciones = '',
    this.cedulaPropietario = '',
    this.departamentoCodigo = '',
    this.municipioCodigo = '',
    this.aldeaCodigo = '',
    this.valorComercial = 0,
    this.valorAvaluo = 0,
    this.tipoValoracionCodigo = '',
    this.objValuadorId = 0,
    this.familia = '',
    this.numEscritura = '',
    this.numTomo = '',
    this.folio = '',
    this.fechaInscripcion = '',
    this.areaVarasCuadradas = 0,
    this.areaMetrosCuadrados = 0,
    this.direccion = '',
    this.tipo = '',
    this.marca = '',
    this.modelo = '',
    this.anio = 0,
    this.color = '',
    this.placa = '',
    this.serie = '',
    this.lugar = '',
    this.numeroReferencia = '',
    this.descripcion = '',
  });

  @override
  List<Object> get props => [
        status,
        errorMsg,
        codigoBien,
        objAnalisisGarantiaId,
        observaciones,
        cedulaPropietario,
        departamentoCodigo,
        municipioCodigo,
        aldeaCodigo,
        valorComercial,
        valorAvaluo,
        tipoValoracionCodigo,
        objValuadorId,
        familia,
        numEscritura,
        numTomo,
        folio,
        fechaInscripcion,
        areaVarasCuadradas,
        areaMetrosCuadrados,
        direccion,
        tipo,
        marca,
        modelo,
        anio,
        color,
        placa,
        serie,
        lugar,
        numeroReferencia,
        descripcion,
      ];

  AnalisisGarantiaActualizarState copyWith({
    Status? status,
    String? errorMsg,
    String? codigoBien,
    int? objAnalisisGarantiaId,
    String? observaciones,
    String? cedulaPropietario,
    String? departamentoCodigo,
    String? municipioCodigo,
    String? aldeaCodigo,
    double? valorComercial,
    double? valorAvaluo,
    String? tipoValoracionCodigo,
    int? objValuadorId,
    String? familia,
    String? numEscritura,
    String? numTomo,
    String? folio,
    String? fechaInscripcion,
    double? areaVarasCuadradas,
    double? areaMetrosCuadrados,
    String? direccion,
    String? tipo,
    String? marca,
    String? modelo,
    int? anio,
    String? color,
    String? placa,
    String? serie,
    String? lugar,
    String? numeroReferencia,
    String? descripcion,
  }) {
    return AnalisisGarantiaActualizarState(
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      codigoBien: codigoBien ?? this.codigoBien,
      objAnalisisGarantiaId:
          objAnalisisGarantiaId ?? this.objAnalisisGarantiaId,
      observaciones: observaciones ?? this.observaciones,
      cedulaPropietario: cedulaPropietario ?? this.cedulaPropietario,
      departamentoCodigo: departamentoCodigo ?? this.departamentoCodigo,
      municipioCodigo: municipioCodigo ?? this.municipioCodigo,
      aldeaCodigo: aldeaCodigo ?? this.aldeaCodigo,
      valorComercial: valorComercial ?? this.valorComercial,
      valorAvaluo: valorAvaluo ?? this.valorAvaluo,
      tipoValoracionCodigo: tipoValoracionCodigo ?? this.tipoValoracionCodigo,
      objValuadorId: objValuadorId ?? this.objValuadorId,
      familia: familia ?? this.familia,
      numEscritura: numEscritura ?? this.numEscritura,
      numTomo: numTomo ?? this.numTomo,
      folio: folio ?? this.folio,
      fechaInscripcion: fechaInscripcion ?? this.fechaInscripcion,
      areaVarasCuadradas: areaVarasCuadradas ?? this.areaVarasCuadradas,
      areaMetrosCuadrados: areaMetrosCuadrados ?? this.areaMetrosCuadrados,
      direccion: direccion ?? this.direccion,
      tipo: tipo ?? this.tipo,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      anio: anio ?? this.anio,
      color: color ?? this.color,
      placa: placa ?? this.placa,
      serie: serie ?? this.serie,
      lugar: lugar ?? this.lugar,
      numeroReferencia: numeroReferencia ?? this.numeroReferencia,
      descripcion: descripcion ?? this.descripcion,
    );
  }
}

final class AnalisisGarantiaActualizarInitial
    extends AnalisisGarantiaActualizarState {}
