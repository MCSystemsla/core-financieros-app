import 'package:pagination/src/models/paginated_data_model.dart';
import 'package:pagination/src/models/query_helper_data.dart';

/// Abstract base class for a paginated data repository.
///
/// Represents a repository responsible for fetching paginated data.
abstract class PaginatedDataRepository<T> {
  const PaginatedDataRepository();

  /// Fetches paginated data based on the provided parameters.
  ///
  /// [queryData]: Additional query data related to the request.
  /// [page]: The page number of the data to fetch.
  /// [limit]: The maximum number of items per page.
  Future<PaginatedData<T>> getData({
    required QueryHelperData? queryData,
    required int page,
    required int limit,
  });
}
