import 'package:equatable/equatable.dart';

/// Abstract base class for query helper data.
///
/// Represents data that can be used as query parameters in requests.
///
abstract class QueryHelperData extends Equatable {
  /// Creates a new instance of [QueryHelperData].
  const QueryHelperData();

  /// Converts the query helper data to a map of query parameters.
  Map<String, dynamic> toQueryParams();

  Map<String, dynamic> toFilterBody();

  /// Creates a copy of the query helper data with updated properties.
  QueryHelperData copyWith();

  @override
  List<Object?> get props => [];
}

abstract class SortData<T extends Enum> {
  const SortData({
    required this.enumValue,
    required this.order,
  });
  final T enumValue;
  final Order order;
}

extension SortDataExtension on SortData? {
  bool get isAscendant => this?.order == Order.asc;
  bool get isDescendant => this?.order == Order.desc;
}

enum Order {
  asc('ASC'),
  desc('DESC');

  const Order(this.value);
  final String value;
}

extension OrderExtension on Order? {
  Order change() {
    if (this == Order.asc) return Order.desc;
    if (this == Order.desc) return Order.asc;
    return Order.desc;
  }
}
