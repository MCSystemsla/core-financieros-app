import 'package:core_financiero_app/global_locator.dart';
import 'package:core_financiero_app/src/datasource/flavor/flavor.dart';
import 'package:core_financiero_app/src/presentation/bloc/flavor/flavor_cubit.dart';

/// Nombre y simbolo de la moneda segun el pais (flavor) activo.
class CurrencyHelper {
  const CurrencyHelper._();

  static Flavor get _flavor => global<FlavorCubit>().state.flavor;

  /// Nombre de la moneda en singular. Ej: `lempira`, `cordoba`, `colon`.
  static String currencyName({Flavor? flavor}) {
    return switch (flavor ?? _flavor) {
      Flavor.honduras => 'lempira',
      Flavor.nicaragua => 'cordoba',
      Flavor.costaRica => 'colon',
      _ => 'cordoba',
    };
  }

  /// Nombre de la moneda en plural. Ej: `lempiras`, `cordobas`, `colones`.
  static String currencyNamePlural({Flavor? flavor}) {
    return switch (flavor ?? _flavor) {
      Flavor.honduras => 'lempiras',
      Flavor.nicaragua => 'cordobas',
      Flavor.costaRica => 'colones',
      _ => 'cordobas',
    };
  }

  /// Simbolo de la moneda. Ej: `L`, `C$`, `₡`.
  static String currencySymbol({Flavor? flavor}) {
    return switch (flavor ?? _flavor) {
      Flavor.honduras => 'L',
      Flavor.nicaragua => 'C\$',
      Flavor.costaRica => '₡',
      _ => 'C\$',
    };
  }

  /// Prefijo tal como se muestra en la UI antes del monto. Ej: `L.`, `C$.`, `₡`.
  static String currencyPrefix({Flavor? flavor}) {
    return switch (flavor ?? _flavor) {
      Flavor.honduras => 'L.',
      Flavor.nicaragua => 'C\$.',
      Flavor.costaRica => '₡',
      _ => 'C\$.',
    };
  }

  /// Codigo ISO de la moneda. Ej: `HNL`, `NIO`, `CRC`.
  static String currencyCode({Flavor? flavor}) {
    return switch (flavor ?? _flavor) {
      Flavor.honduras => 'HNL',
      Flavor.nicaragua => 'NIO',
      Flavor.costaRica => 'CRC',
      _ => 'NIO',
    };
  }
}
