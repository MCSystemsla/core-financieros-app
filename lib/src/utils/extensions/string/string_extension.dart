extension CapitalizeString on String {
  String get capitalizeAll {
    return split(' ')
        .map((str) => str.isNotEmpty
            ? '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}'
            : str)
        .join(' ');
  }

  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }

  String get dashFormat {
    if (isEmpty) return this;
    String text = replaceAll('-', '');
    String formattedText =
        text.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)}-');
    return formattedText;
  }
}

extension EmptyOrZeroStringToNull on String? {
  String? toNullIfEmptyOrZero() {
    if (this == null ||
        this == '0' ||
        this == '0.0' ||
        this == '0.00' ||
        this!.trim().isEmpty) {
      return null;
    }
    return this;
  }
}

extension TokenFormatter on String {
  /// Divide un token de 6 dígitos en dos grupos de 3 (ej: 123 456)
  String get toOtpFormat {
    if (length != 6) return this;
    return '${substring(0, 3)} ${substring(3, 6)}';
  }
}
