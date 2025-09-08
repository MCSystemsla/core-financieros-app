enum Flavor {
  honduras,
  nicaragua,
  costaRica,
  unknown,
}

getCurrentFlavorString({required Flavor flavor}) {
  return switch (flavor) {
    Flavor.nicaragua => 'NIC',
    Flavor.costaRica => 'CR',
    Flavor.honduras => 'HN',
    _ => 'NIC',
  };
}
