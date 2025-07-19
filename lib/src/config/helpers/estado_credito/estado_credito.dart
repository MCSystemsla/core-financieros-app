import 'package:flutter/material.dart';

enum EstadoCredito {
  rechazada('RECH'),
  desembolsada('DESEMB'),
  asignada('AUT'),
  registrada('REG'),
  enComite('CERRADA'),
  enRevision('REV'),
  procesada('PROC'),
  enPreCierre('PRECIERRE'),
  formalizada('FORM'),
  prorrogado('PRORRAD'),
  pendiente('PEND'),
  desistimiento('DESI');

  final String codigo;

  const EstadoCredito(this.codigo);
}

class EstadoCreditoInfo {
  final EstadoCredito estado;
  final String nombre;
  final String codigo;
  final IconData icono;

  EstadoCreditoInfo({
    required this.estado,
    required this.nombre,
    required this.codigo,
    required this.icono,
  });
}

final List<EstadoCreditoInfo> creditStatesListData = [
  EstadoCreditoInfo(
    estado: EstadoCredito.asignada,
    nombre: 'Asignada',
    codigo: EstadoCredito.asignada.codigo,
    icono: Icons.assignment_ind_outlined,
  ),
  EstadoCreditoInfo(
    estado: EstadoCredito.registrada,
    nombre: 'Registrada',
    codigo: EstadoCredito.registrada.codigo,
    icono: Icons.app_registration,
  ),
];
