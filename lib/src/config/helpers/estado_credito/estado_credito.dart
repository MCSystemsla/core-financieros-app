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
    estado: EstadoCredito.rechazada,
    nombre: 'Rechazada',
    codigo: EstadoCredito.rechazada.codigo,
    icono: Icons.cancel_outlined,
  ),
  EstadoCreditoInfo(
    estado: EstadoCredito.desembolsada,
    nombre: 'Desembolsada',
    codigo: EstadoCredito.desembolsada.codigo,
    icono: Icons.attach_money,
  ),
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
  EstadoCreditoInfo(
    estado: EstadoCredito.enComite,
    nombre: 'En Comité',
    codigo: EstadoCredito.enComite.codigo,
    icono: Icons.groups_2_outlined,
  ),
  EstadoCreditoInfo(
    estado: EstadoCredito.enRevision,
    nombre: 'En Revisión',
    codigo: EstadoCredito.enRevision.codigo,
    icono: Icons.find_in_page_outlined,
  ),
  EstadoCreditoInfo(
    estado: EstadoCredito.procesada,
    nombre: 'Procesada',
    codigo: EstadoCredito.procesada.codigo,
    icono: Icons.playlist_add_check_outlined,
  ),
  EstadoCreditoInfo(
    estado: EstadoCredito.enPreCierre,
    nombre: 'En Pre-Cierre',
    codigo: EstadoCredito.enPreCierre.codigo,
    icono: Icons.timelapse_outlined,
  ),
  EstadoCreditoInfo(
    estado: EstadoCredito.formalizada,
    nombre: 'Formalizada',
    codigo: EstadoCredito.formalizada.codigo,
    icono: Icons.description_outlined,
  ),
  EstadoCreditoInfo(
    estado: EstadoCredito.prorrogado,
    nombre: 'Prorrogado',
    codigo: EstadoCredito.prorrogado.codigo,
    icono: Icons.schedule_outlined,
  ),
  EstadoCreditoInfo(
    estado: EstadoCredito.pendiente,
    nombre: 'Pendiente',
    codigo: EstadoCredito.pendiente.codigo,
    icono: Icons.hourglass_empty_outlined,
  ),
  EstadoCreditoInfo(
    estado: EstadoCredito.desistimiento,
    nombre: 'Desistimiento',
    codigo: EstadoCredito.desistimiento.codigo,
    icono: Icons.backspace_outlined,
  ),
];
