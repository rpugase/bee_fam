
typedef OnIfEmpty = String Function();

extension StringExtensions on String {
  String ifEmpty(OnIfEmpty onIfEmpty) {
    return isEmpty ? onIfEmpty() : this;
  }
}
