abstract class ListItem {}

class ListItemNotImplementedException implements Exception {
  final String message;

  ListItemNotImplementedException(ListItem listItem)
      : message = "Such ListItem ${listItem.runtimeType} not implemented";
}
