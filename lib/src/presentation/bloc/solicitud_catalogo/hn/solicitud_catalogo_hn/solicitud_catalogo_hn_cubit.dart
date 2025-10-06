import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'solicitud_catalogo_hn_state.dart';

class SolicitudCatalogoHnCubit extends Cubit<SolicitudCatalogoHnState> {
  SolicitudCatalogoHnCubit() : super(SolicitudCatalogoHnInitial());
}
