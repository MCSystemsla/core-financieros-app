import 'package:flutter/material.dart';

enum OrderType {
  ascending('asc'),
  descending('desc');

  final String value;
  const OrderType(this.value);
}

class OrderTypeInfo {
  final OrderType orderType;
  final String nombre;
  final IconData icono;

  OrderTypeInfo({
    required this.nombre,
    required this.icono,
    required this.orderType,
  });
}

final List<OrderTypeInfo> orderTypeInfoList = [
  OrderTypeInfo(
    orderType: OrderType.ascending,
    nombre: 'Ordenar por orden ascendente',
    icono: Icons.sort_by_alpha,
  ),
  OrderTypeInfo(
    orderType: OrderType.descending,
    nombre: 'Ordenar por orden descendente',
    icono: Icons.sort_by_alpha,
  ),
];
