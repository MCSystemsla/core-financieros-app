import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:core_financiero_app/src/domain/entities/responses.dart';
import 'package:equatable/equatable.dart';

part 'response_state.dart';

class ResponseCubit extends Cubit<ResponseState> {
  ResponseCubit() : super(ResponseInitial());

  addResponses({required List<Response> responses}) {
    // Crear una lista mutable de las respuestas actuales
    final updatedResponses = List<Response>.from(state.responses);

    // Intentar encontrar la respuesta existente para la pregunta
    // Recorrer la lista de nuevas respuestas
    for (var response in responses) {
      // Intentar encontrar la respuesta existente para la pregunta
      final index =
          updatedResponses.indexWhere((r) => r.question == response.question);

      if (index != -1) {
        // Si existe, actualizar la respuesta
        updatedResponses[index] = response;
      } else {
        // Si no existe, agregar la nueva respuesta
        updatedResponses.add(response);
      }
    }

    // Emitir el nuevo estado con las respuestas actualizadas
    emit(state.copyWith(responses: updatedResponses));
    log(state.responses.map((e) => e.question).toList().toString());
    log(state.responses.map((e) => e.response).toList().toString());
  }
}
