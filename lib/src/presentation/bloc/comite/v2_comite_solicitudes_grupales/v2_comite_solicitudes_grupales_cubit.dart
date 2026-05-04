import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/datasource/comite/comite__approved_grupal_schema.dart';
import 'package:core_financiero_app/src/datasource/comite/comite_aproved_response.dart';
import 'package:core_financiero_app/src/domain/exceptions/app_exception.dart';
import 'package:core_financiero_app/src/domain/repository/comite/hn/comite_repository_hn.dart';
import 'package:core_financiero_app/src/presentation/bloc/auth/branch_team/branchteam_cubit.dart';
import 'package:core_financiero_app/src/presentation/widgets/pop_up/custom_alert_dialog.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

part 'v2_comite_solicitudes_grupales_state.dart';

class V2ComiteSolicitudesGrupalesCubit
    extends Cubit<V2ComiteSolicitudesGrupalesState> {
  final ComiteRepositoryHN _repository;
  V2ComiteSolicitudesGrupalesCubit(this._repository)
      : super(V2ComiteSolicitudesGrupalesInitial());

  Future<void> aprobarActasGrupal({required int grupoID}) async {
    emit(state.copyWith(status: Status.inProgress));
    try {
      final resp = await _repository.aprobarActasGrupal(
        data: ComiteApprovedGrupalSchema(
          grupoId: grupoID,
          groupMembers: state.groupMembers,
        ),
      );
      emit(state.copyWith(
        status: Status.done,
        successMsg: resp.message,
        responsables: resp.responsables,
      ));
    } on AppException catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.optionalMsg));
    } catch (e) {
      emit(state.copyWith(status: Status.error, errorMsg: e.toString()));
    }
  }

  bool addMemberToGroup(
    BuildContext context, {
    required ComiteGroupMember member,
    bool isServicesCreated = false,
  }) {
    final bool alreadyExists = state.groupMembers.any(
      (m) => m.numeroSolicitud == member.numeroSolicitud,
    );

    if (alreadyExists) {
      log('El miembro con solicitud ${member.numeroSolicitud} ya está en la lista.');
      CustomAlertDialog(
        context: context,
        title:
            'Miembro con numero de solicitud ${member.numeroSolicitud} ya esta en la lista de verificados',
        onDone: () => context.pop(),
      ).showDialog(context, dialogType: DialogType.infoReverse);
      return false;
    }
    if (!isServicesCreated) {
      return false;
    }

    log('Miembro Agregado a lista ${member.numeroSolicitud}');
    emit(
      state.copyWith(
        groupMembers: [...state.groupMembers, member],
      ),
    );
    return true;
  }

  void onFieldChanged(V2ComiteSolicitudesGrupalesState Function() copyWithFn) {
    emit(copyWithFn());
  }
}
