import 'package:core_financiero_app/src/utils/extensions/date/date_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';

class TransactionReviewCard extends StatelessWidget {
  final double monto;
  final String producto;
  final int plazo;
  final DateTime primerPago;
  final List<String> servicios;
  final double montoConServicios;
  final String tipoCredito;
  final String observaciones;

  const TransactionReviewCard({
    super.key,
    required this.monto,
    required this.producto,
    required this.plazo,
    required this.primerPago,
    required this.servicios,
    required this.montoConServicios,
    required this.tipoCredito,
    required this.observaciones,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(12),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// MONTO
            Center(
              child: Column(
                children: [
                  const Text(
                    'Monto aprobado',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'L ${monto.toCurrencyString()}',
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _row(Icons.account_balance_wallet_outlined, 'Producto del crédito',
                producto),
            _row(Icons.schedule_outlined, 'Plazo', '$plazo meses'),
            _row(Icons.calendar_today_outlined, 'Fecha de Primer pago',
                primerPago.selectorFormat()),
            _row(Icons.wallet, 'Monto total con servicios',
                montoConServicios.toCurrencyString()),
            _row(Icons.credit_card, 'Tipo Credito', tipoCredito),
            _row(Icons.remove_red_eye, 'Observaciones', observaciones),

            if (servicios.isNotEmpty) ...[
              const SizedBox(height: 20),
              const Text(
                'Servicios incluidos',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              ...servicios.map(
                (s) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        size: 18,
                        color: Colors.green,
                      ),
                      const SizedBox(width: 8),
                      Expanded(child: Text(s)),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _row(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.green),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
