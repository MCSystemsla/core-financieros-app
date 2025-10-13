import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_by_document_state.dart';

class UserByDocumentCubit extends Cubit<UserByDocumentState> {
  UserByDocumentCubit() : super(UserByDocumentInitial());
}
