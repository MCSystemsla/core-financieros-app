part of 'infinite_pagination_bloc.dart';

/// Represents the pagination state of a list of items.
class InfinitePaginationState<T, K extends QueryHelperData> extends Equatable {
  /// Creates a new instance of PaginationState.
  ///
  /// [items] : List of items on the current page.
  /// [limit] : Maximum number of items per page.
  /// [page] : Current page.
  /// [status] : Pagination status.
  /// [totalPages] : Total number of available pages.
  /// [hasMore] : Indicates whether there are more pages available.
  /// [error] : Error message in case of an error.
  /// [queryData] : Query data related to pagination.
  const InfinitePaginationState({
    this.items = const [],
    this.page = 1,
    this.status = PaginationStatus.initial,
    this.totalItems = 0,
    this.totalPages = 1,
    this.error,
    required this.queryData,
    this.hasMore = true,
  });

  /// Current page.
  final int page;

  /// Total number of available pages.
  final int totalPages;

  /// Total items available.
  final int totalItems;

  /// Indicates whether there are more pages available.
  final bool hasMore;

  /// List of items on the current page.
  final List<T> items;

  /// Pagination status.
  final PaginationStatus status;

  /// Query data related to pagination.
  final K queryData;

  /// Error message in case of an error.
  final String? error;

  /// Creates a copy of the state with some properties updated.
  InfinitePaginationState<T, K> copyWith({
    int? page,
    int? totalPages,
    int? totalItems,
    List<T>? items,
    K? queryData,
    PaginationStatus? status,
    bool? hasMore,
  }) =>
      InfinitePaginationState(
        items: items ?? this.items,
        page: page ?? this.page,
        queryData: queryData ?? this.queryData,
        status: status ?? this.status,
        totalPages: totalPages ?? this.totalPages,
        totalItems: totalItems ?? this.totalItems,
        hasMore: hasMore ?? this.hasMore,
      );

  /// Creates a copy of the state with the state set to "error".
  InfinitePaginationState<T, K> copyWithError({
    required String message,
  }) =>
      InfinitePaginationState(
        error: message,
        items: items,
        page: page,
        queryData: queryData,
        status: PaginationStatus.failed,
        totalPages: totalPages,
        hasMore: hasMore,
        totalItems: totalItems,
      );

  /// Executes one of the provided functions based on the current state.
  ///
  /// This function takes three functions as parameters:
  /// - [fetched]: Called when data is successfully fetched.
  /// - [failed]: Called when there's an error in data retrieval.
  /// - [loading]: Called when data is loading.
  ///
  /// Returns a generic value `R` based on the current state and provided functions:
  /// - If the state is failed ([status.isFailed]), the [failed] function is called with the error message or an empty string if no error is provided.
  /// - If the state is loading ([status.isLoading]) and there are no items ([items.isEmpty]), the [loading] function is called.
  /// - Otherwise, the [fetched] function is called with the current elements ([items]), loading state ([status.isLoading]), and indication of whether more items are available ([hasMore]).
  ///
  /// Parameters:
  /// - [fetched]: Function that receives a list of elements `T`, a boolean flag for loading more items (`isLoadingNextPage`), and a boolean flag for more available items (`hasMoreItems`).
  /// - [failed]: Function that receives an error message as a string.
  /// - [loading]: Function without parameters called when data is loading.
  ///
  /// Usage Example:
  /// ```dart
  /// onState(
  ///   fetched: (data, isLoadingNextPage, hasMoreItems) {
  ///     // Logic to handle successfully fetched data
  ///   },
  ///   failed: (error) {
  ///     // Logic to handle failure in data retrieval
  ///   },
  ///   loading: () {
  ///     // Logic to handle loading state
  ///   },
  /// );
  /// ```
  R onState<R>({
    required R Function(
      List<T> data,
      bool isLoadingNextPage,
      bool hasMoreItems,
    ) fetched,
    required R Function(String error) failed,
    required R Function() loading,
  }) {
    if (status.isFailed) {
      return failed(error ?? '');
    } else if (status.isLoading && items.isEmpty) {
      return loading();
    } else {
      return fetched(
        items,
        status.isLoading,
        hasMore,
      );
    }
  }

  @override
  List<Object?> get props => [
        items,
        page,
        queryData,
        status,
        totalPages,
        hasMore,
        totalItems,
      ];
}
