/// Represents paginated data returned from an API request.
class PaginatedData<T> {
  /// Creates an instance of [PaginatedData].
  ///
  /// [count]: The number of items in the current page.
  /// [data]: List of items in the current page.
  /// [pages]: Total number of available pages.
  /// [total]: Total number of items across all pages.
  /// [hasMore]: Indicates whether there are more pages available.
  const PaginatedData({
    required this.count,
    required this.data,
    required this.pages,
    required this.total,
    required this.hasMore,
  });

  /// Creates an instance of [PaginatedData] from JSON data.
  ///
  /// [json]: The JSON data to parse.
  /// [parser]: A function to parse the list of items from JSON data.
  factory PaginatedData.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> dataJson) parser,
  ) {
    final results = json['data'];
    final dataToParse = results['result'] as List<dynamic>;
    final meta = results['meta'];
    final count = dataToParse.length;
    final pages = meta['pages'];
    final total = meta['total'];
    final hasMore = meta['hasMore'];
    final data = [
      for (var jsonData in dataToParse) parser(Map.from(jsonData)),
    ];

    return PaginatedData(
      count: count,
      data: data,
      pages: pages,
      total: total,
      hasMore: hasMore,
    );
  }

  /// The number of items in the current page.
  final int count;

  /// List of items in the current page.
  final List<T> data;

  /// Total number of available pages.
  final int pages;

  /// Indicates whether there are more pages available.
  final bool hasMore;

  /// Total number of items across all pages.
  final int total;

  /// Returns a string representation of the [PaginatedData] instance.
  @override
  String toString() {
    return '$T Count: $count, Pages: $pages, Total: $total';
  }
}
