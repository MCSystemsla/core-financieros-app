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
