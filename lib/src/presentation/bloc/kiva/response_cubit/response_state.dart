// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'response_cubit.dart';

class ResponseState extends Equatable {
  final List<Response> responses;
  const ResponseState({
    this.responses = const [],
  });

  @override
  List<Object> get props => [responses];

  ResponseState copyWith({
    List<Response>? responses,
  }) {
    return ResponseState(
      responses: responses ?? this.responses,
    );
  }
}

final class ResponseInitial extends ResponseState {}
