extension BoolParsing on String? {
  bool toBool() {
    if (this == null) return false;
    return this!.toLowerCase() == 'true';
  }
}
