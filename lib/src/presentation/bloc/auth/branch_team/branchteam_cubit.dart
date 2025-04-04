import 'package:http/http.dart' as http;
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/entities/responses/branch_team_response.dart';
import 'package:core_financiero_app/src/domain/repository/auth/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'branchteam_state.dart';

class BranchteamCubit extends Cubit<BranchteamState> {
  final AuthRepository repository;
  BranchteamCubit(this.repository) : super(BranchteamInitial());

  Future<void> getBranchTeam(
      {required String accessCode, required BuildContext context}) async {
    emit(state.copyWith(status: Status.inProgress));
    final resp = await repository.getBranchTeam(accessCode: accessCode);
    emit(state.copyWith(branchTeams: resp.sucursales));
    // final isConnected = await isServerAvailable('8.8.8.8');
    // if (!context.mounted) return;
    // final message = isConnected
    //     ? '✅ Conectado a 10.120.4.4'
    //     : '❌ No hay conexión con  el servidor, por favor verifica tu conexión.';
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(content: Text(message)),
    // );

    // log(isConnected ? '✅ Conectado a 10.120.4.4' : '❌ No hay conexión');
    emit(state.copyWith(status: Status.done));
  }

  Future<bool> isServerAvailable(String ip) async {
    try {
      final response = await http
          .get(Uri.parse('http://10.120.4.4'))
          .timeout(const Duration(seconds: 3));
      return response.statusCode == 200;
    } catch (e) {
      log('Error al verificar la conexión: $e');
      return false;
    }
  }
}
