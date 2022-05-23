part of '../logger.dart';

abstract class _StringOutputLogger implements Logger {
  _StringOutputLogger([_LogFormatter? logFormatter])
      : this._formatter = logFormatter ?? _LogFormatter(prettyExtrasPrint: true);

  final _LogFormatter _formatter;

  void output(String message);

  bool isLogAllowed(LogLevel logLevel) => true;

  @override
  void i(String message) {
    if (isLogAllowed(LogLevel.info)) {
      output(_formatter.formatLog(
        message,
        LogLevel.info,
      ));
    }
  }

  @override
  void w(String message) {
    if (isLogAllowed(LogLevel.warning)) {
      output(_formatter.formatLog(
        message,
        LogLevel.warning,
      ));
    }
  }

  /// In short - [StackTrace] can be null for [FlutterError]
  /// https://github.com/flutter/flutter/issues/30007
  @override
  void e(
      Object error, [
        StackTrace? stackTrace,
        String? message,
      ]) {
    if (isLogAllowed(LogLevel.error)) {
      output(_formatter.formatErrorLog(error, stackTrace, message: message));
    }
  }
}
