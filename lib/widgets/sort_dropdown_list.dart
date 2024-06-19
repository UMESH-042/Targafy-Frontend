List<T> sortList<T>(List<T> list, String Function(T) keyExtractor) {
  list.sort((a, b) => keyExtractor(a).compareTo(keyExtractor(b)));
  return list;
}
