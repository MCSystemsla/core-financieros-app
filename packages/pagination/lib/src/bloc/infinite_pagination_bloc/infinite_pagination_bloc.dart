import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:pagination/src/models/models.dart';
import 'package:pagination/src/repository/repository.dart';

import 'package:rxdart/rxdart.dart';

part 'infinite_pagination_event.dart';
part 'infinite_pagination_state.dart';

typedef _Emitter = Emitter<InfinitePaginationState>;

const _duration = Duration(milliseconds: 300);

/// A BLoC responsible for managing pagination state and events.
///
/// Manages the state changes based on different pagination events.
class InfinitePaginationBloc<T, K extends QueryHelperData>
    extends Bloc<InfinitePaginationEvent, InfinitePaginationState<T, K>> {
  /// Creates a [PaginationBloc] instance.
  ///
  /// [repository]: The repository used for fetching paginated data.
  InfinitePaginationBloc({
    required PaginatedDataRepository<T> repository,
    required K filter,
    int limit = 20,
  })  : _limit = limit,
        _repository = repository,
        super(InfinitePaginationState(queryData: filter)) {
    on<GetDataInfinitePaginationEvent<K>>(
      _onGetData,
      transformer: debounce(_duration),
    );
    on<ClearDataPaginationEvent>(_onClearData);
  }

  /// Handles the [GetDataPaginationEvent] by fetching data from the repository.
  void _onGetData(
    GetDataInfinitePaginationEvent<K> event,
    _Emitter emit,
  ) async {
    final page = event.page;
    final queryData = event.queryData ?? state.queryData;
    try {
      final lastItems = page == 1 ? <T>[] : [...state.items];
      emit(
        state.copyWith(
          status: PaginationStatus.loading,
          items: page == 1 ? <T>[] : null,
          queryData: queryData,
        ),
      );

      final result = await _repository.getData(
        queryData: queryData,
        limit: _limit,
        page: page,
      );

      emit(
        state.copyWith(
          status: PaginationStatus.fetched,
          items: [...lastItems, ...result.data],
          page: page,
          queryData: queryData,
          totalPages: result.pages,
          hasMore: result.hasMore,
          totalItems: result.total,
        ),
      );
    } catch (error) {
      emit(state.copyWithError(message: error.toString()));
    }
  }

  void _onClearData(
    ClearDataPaginationEvent event,
    _Emitter emit,
  ) {
    final newState = InfinitePaginationState<T, K>(
      queryData: state.queryData,
      status: event.optionalStatus ?? PaginationStatus.initial,
    );
    emit(newState);
  }

  EventTransformer<GetDataPaginationEvent> debounce<GetDataPaginationEvent>(
    Duration duration,
  ) {
    return (events, mapper) {
      return droppable<GetDataPaginationEvent>()
          .call(events.debounceTime(duration), mapper);
    };
  }

  final PaginatedDataRepository<T> _repository;
  final int _limit;
}
