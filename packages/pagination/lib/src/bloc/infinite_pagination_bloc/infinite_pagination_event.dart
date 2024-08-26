part of 'infinite_pagination_bloc.dart';

/// Base class for pagination events.
///
/// Represents events that can trigger changes in the pagination state.
sealed class InfinitePaginationEvent extends Equatable {
  const InfinitePaginationEvent();

  @override
  List<Object?> get props => [];
}

/// Event to fetch data for pagination.
///
/// This event is triggered when new data needs to be fetched for a specific page.
class GetDataInfinitePaginationEvent<T extends QueryHelperData>
    extends InfinitePaginationEvent {
  /// Creates a [GetDataPaginationEvent].
  ///
  /// [page]: The page for which data needs to be fetched.
  /// [queryData]: Additional query data related to the pagination.
  const GetDataInfinitePaginationEvent({required this.page, this.queryData});

  /// The page for which data needs to be fetched.
  final int page;

  /// Additional query data related to the pagination.
  final T? queryData;

  @override
  List<Object?> get props => [page, queryData];
}

class ClearDataPaginationEvent extends InfinitePaginationEvent {
  final PaginationStatus? optionalStatus;

  const ClearDataPaginationEvent({this.optionalStatus});
}
