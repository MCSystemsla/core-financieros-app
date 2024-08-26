enum PaginationStatus {
  initial,
  loading,
  fetched,
  failed;

  bool get isFetched => this == PaginationStatus.fetched;
  bool get isLoading => this == PaginationStatus.loading;
  bool get isFailed => this == PaginationStatus.failed;
}
