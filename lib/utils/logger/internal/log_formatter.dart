part of '../logger.dart';

class _FormatterStringSizes {
  final int messageLength, callLength;

  const _FormatterStringSizes(this.messageLength, this.callLength);

  const _FormatterStringSizes.defaultSizes()
      : messageLength = 150,
        callLength = 50;
}

class _LogFormatter {
  const _LogFormatter({
    bool prettyExtrasPrint = false,
    this.stringSizes = const _FormatterStringSizes.defaultSizes(),
  });

  final _FormatterStringSizes stringSizes;

  String formatLog(
      String message,
      LogLevel level,
  ) {
    final buffer = StringBuffer();

    _writeLogInformationPrefix(buffer, level);

    final paddedMessage = _padString(message, stringSizes.messageLength);
    buffer.write(paddedMessage);

    return buffer.toString();
  }

  String formatErrorLog(
      Object error,
      StackTrace? trace, {
        String? message,
      }) {
    final buffer = StringBuffer();

    _writeLogInformationPrefix(buffer, LogLevel.error);

    buffer.write('Exception thrown: $error, $trace');

    if (message != null) buffer.write(' MESSAGE: $message');

    if (trace != null) buffer.writeln(trace);

    return buffer.toString();
  }

  String _timeString() => DateTime.now().toIso8601String();

  /// Writes log time and code point of call
  ///
  /// Example: 2021-09-13T18:23:03.164773 I/: declarer.dart:200:19
  void _writeLogInformationPrefix(
      StringBuffer buffer,
      LogLevel logLevel,
      ) {
    buffer.writeAll([
      _timeString(),
      ' ',
      logLevel.charIdentifier,
      '/: ',
    ]);

    final codePoint = _extractCodePoint(StackTrace.current);
    if (codePoint != null) {
      final paddedCodePoint = _padString(codePoint, stringSizes.callLength);
      buffer.write(paddedCodePoint);
    }
  }

  /// Returns method call code point, ignoring all loggers class,
  /// or null if it's not found
  String? _extractCodePoint(StackTrace stackTrace) {
    List<String> calls = stackTrace.toString().split('\n');

    //Searching method call ignoring loggers calls
    final methodCallIndex =
    calls.firstIndexWhereNot((call) => call.toLowerCase().contains('log'));
    if (methodCallIndex == -1) return null;

    final methodCallStackLine = calls[methodCallIndex];

    return __extractCodePoint(methodCallStackLine);
  }

  /// Extracts code point from stackTrace line
  ///
  /// Example:
  /// Input: Some.build.<anonymous closure> (package:some_package/main.dart:52:18)
  /// returns: 'main.dart:52:18' or null if can't extract
  String? __extractCodePoint(String stackTraceLine) {
    final regexp = RegExp(r"\(([^)]+)\)");
    final matches = regexp.allMatches(stackTraceLine).toList();

    if (matches.isEmpty) return null;

    String? packageAndClass = matches.first
        .group(0); //extracted result (package:some_package/main.dart:54:18)

    return packageAndClass != null ? _removePackages(packageAndClass) : null;
  }

  String _removePackages(String str) =>
      str.substring(str.lastIndexOf('/') + 1).replaceAll(')', '');

  String _padString(String message, int padding) {
    if (message.length >= padding)
      return '$message    ';
    else
      return message.padRight(padding);
  }
}

extension FirstWhereNotExtension<E> on List<E> {
  ///Finds index of element which not satisfy [test] function
  int firstIndexWhereNot(bool test(E element)) {
    final _iterator = iterator;
    int index = 0;

    while (_iterator.moveNext()) {
      if (test(_iterator.current)) {
        index++;
      } else {
        return index != 0 ? index : -1;
      }
    }

    return -1;
  }
}

