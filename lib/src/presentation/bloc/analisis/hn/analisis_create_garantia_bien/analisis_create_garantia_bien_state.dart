// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'analisis_create_garantia_bien_cubit.dart';

class AnalisisCreateGarantiaBienState extends Equatable {
  final Status status;
  final String erroMsg;
  final String familia;
  final String numTomo;
  final String folio;
  final String numEscritura;
  final String fechaInscripcion;
  final double areaVaras2;
  final double areaMetros2;
  final String direccion;
  final String departamentoCodigo;
  final String municipioCodigo;
  final String aldeaCodigo;
  final String tipo;
  final String marca;
  final String modelo;
  final int anio;
  final String color;
  final String placa;
  final String serie;
  final String observaciones;
  final double valorComercial;
  final double valorAvaluo;
  final int objValuadorID;
  final String tipoValoracionCodigo;
  final String succesMsg;
  final int objGarantiaBienId;
  final String lugar;
  final String numeroReferencia;
  final String descripcion;
  const AnalisisCreateGarantiaBienState({
    this.status = Status.notStarted,
    this.erroMsg = '',
    this.familia = '',
    this.numTomo = '',
    this.folio = '',
    this.numEscritura = '',
    this.fechaInscripcion = '',
    this.areaVaras2 = 0,
    this.areaMetros2 = 0,
    this.direccion = '',
    this.departamentoCodigo = '',
    this.municipioCodigo = '',
    this.aldeaCodigo = '',
    this.tipo = '',
    this.marca = '',
    this.modelo = '',
    this.anio = 0,
    this.color = '',
    this.placa = '',
    this.serie = '',
    this.observaciones = '',
    this.valorComercial = 0,
    this.valorAvaluo = 0,
    this.objValuadorID = 0,
    this.tipoValoracionCodigo = '',
    this.succesMsg = '',
    this.objGarantiaBienId = 0,
    this.lugar = '',
    this.numeroReferencia = '',
    this.descripcion = '',
  });

  @override
  List<Object> get props => [
        status,
        erroMsg,
        familia,
        numTomo,
        folio,
        numEscritura,
        fechaInscripcion,
        areaVaras2,
        areaMetros2,
        direccion,
        departamentoCodigo,
        municipioCodigo,
        aldeaCodigo,
        tipo,
        marca,
        modelo,
        anio,
        color,
        placa,
        serie,
        observaciones,
        valorComercial,
        valorAvaluo,
        objValuadorID,
        tipoValoracionCodigo,
        succesMsg,
        objGarantiaBienId,
        lugar,
        numeroReferencia,
        descripcion,
      ];

  AnalisisCreateGarantiaBienState copyWith({
    Status? status,
    String? erroMsg,
    String? familia,
    String? numTomo,
    String? folio,
    String? numEscritura,
    String? fechaInscripcion,
    double? areaVaras2,
    double? areaMetros2,
    String? direccion,
    String? departamentoCodigo,
    String? municipioCodigo,
    String? aldeaCodigo,
    String? tipo,
    String? marca,
    String? modelo,
    int? anio,
    String? color,
    String? placa,
    String? serie,
    String? observaciones,
    double? valorComercial,
    double? valorAvaluo,
    int? objValuadorID,
    String? tipoValoracionCodigo,
    String? succesMsg,
    int? objGarantiaBienId,
    String? lugar,
    String? numeroReferencia,
    String? descripcion,
  }) {
    return AnalisisCreateGarantiaBienState(
      status: status ?? this.status,
      erroMsg: erroMsg ?? this.erroMsg,
      familia: familia ?? this.familia,
      numTomo: numTomo ?? this.numTomo,
      folio: folio ?? this.folio,
      numEscritura: numEscritura ?? this.numEscritura,
      fechaInscripcion: fechaInscripcion ?? this.fechaInscripcion,
      areaVaras2: areaVaras2 ?? this.areaVaras2,
      areaMetros2: areaMetros2 ?? this.areaMetros2,
      direccion: direccion ?? this.direccion,
      departamentoCodigo: departamentoCodigo ?? this.departamentoCodigo,
      municipioCodigo: municipioCodigo ?? this.municipioCodigo,
      aldeaCodigo: aldeaCodigo ?? this.aldeaCodigo,
      tipo: tipo ?? this.tipo,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      anio: anio ?? this.anio,
      color: color ?? this.color,
      placa: placa ?? this.placa,
      serie: serie ?? this.serie,
      observaciones: observaciones ?? this.observaciones,
      valorComercial: valorComercial ?? this.valorComercial,
      valorAvaluo: valorAvaluo ?? this.valorAvaluo,
      objValuadorID: objValuadorID ?? this.objValuadorID,
      tipoValoracionCodigo: tipoValoracionCodigo ?? this.tipoValoracionCodigo,
      succesMsg: succesMsg ?? this.succesMsg,
      objGarantiaBienId: objGarantiaBienId ?? this.objGarantiaBienId,
      lugar: lugar ?? this.lugar,
      numeroReferencia: numeroReferencia ?? this.numeroReferencia,
      descripcion: descripcion ?? this.descripcion,
    );
  }
}

final class AnalisisCreateGarantiaBienInitial
    extends AnalisisCreateGarantiaBienState {}
