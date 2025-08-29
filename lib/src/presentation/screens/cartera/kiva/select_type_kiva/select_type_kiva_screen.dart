import 'package:core_financiero_app/src/presentation/bloc/internet_connection/internet_connection_cubit.dart';
import 'package:core_financiero_app/src/presentation/screens/cartera/kiva/solicitudes_kiva_offline/solicitudes_kiva_offline.dart';
import 'package:core_financiero_app/src/presentation/widgets/shared/cards/white_card/white_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class SelectTypeKivaScreen extends StatelessWidget {
  const SelectTypeKivaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final internetStatusProvider =
        context.read<InternetConnectionCubit>().state.connectionStatus;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona tipo de solicitudes kiva'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(20),
            _Card(
              title: 'Solicitudes KIVA pendientes',
              subtitle: '9 solicitudes guardadas',
              trailingTitle: '9',
              onTap: () {
                internetStatusProvider == ConnectionStatus.connected
                    ? context.push('/cartera/formulario-kiva')
                    : context.push('/cartera/kiva-offline');
              },
            ),
            const Gap(20),
            _Card(
              title: 'Solicitudes credito KIVA Offline',
              subtitle: '9 solicitudes guardadas',
              trailingTitle: '9',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SolicitudesKivaOffline(),
                  ),
                );
              },
            ),
            const Gap(20),
          ],
        ),
      ),
    );
  }
}

class _Card extends StatelessWidget {
  final String title;
  final String subtitle;
  final String trailingTitle;
  final VoidCallback onTap;

  const _Card({
    required this.title,
    required this.subtitle,
    required this.trailingTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: WhiteCard(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const _Leading(),
              const Gap(16),
              _Title(
                title: title,
                subtitle: subtitle,
              ),
              _Trailing(
                trailingTitle: trailingTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Trailing extends StatelessWidget {
  final String trailingTitle;
  const _Trailing({required this.trailingTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        trailingTitle,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.blue.shade700,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  final String subtitle;
  const _Title({
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const Gap(6),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
          ),
        ],
      ),
    );
  }
}

class _Leading extends StatelessWidget {
  const _Leading();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(
        Icons.offline_bolt_outlined,
        size: 28,
        color: Colors.grey,
      ),
    );
  }
}
