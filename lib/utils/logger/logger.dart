import 'package:flutter/foundation.dart';
import 'dart:core';

part 'internal/log_formatter.dart';
part 'internal/string_output_logger.dart';
part 'internal/console_print_logger.dart';
part 'internal/log_identifiers.dart';

class Log {

  static final _loggers = <Logger>[];

  static void initialize(List<Logger> loggers) {
    if (_loggers.isNotEmpty) throw LoggerException("Logger already initialized");
    _loggers.addAll(loggers);
  }

  static void i(Object? message) {
    if (_loggers.isEmpty) throw LoggerException("Logger is not initialized");
    if (message != null) {
      for (int i = 0; i < _loggers.length; i++) {
        _loggers[i].i(message.toString());
      }
    }
  }

  static void w(Object? message) {
    if (_loggers.isEmpty) throw LoggerException("Logger is not initialized");
    if (message != null) {
      for (int i = 0; i < _loggers.length; i++) {
        _loggers[i].w(message.toString());
      }
    }
  }

  static void e(Object exception, [StackTrace? stackTrace]) {
    if (_loggers.isEmpty) throw LoggerException("Logger is not initialized");
    for (int i = 0; i < _loggers.length; i++) {
      _loggers[i].e(exception, stackTrace);
    }
  }
}

abstract class Logger {

  void i(String message);

  void w(String message);

  void e(Object exception, [StackTrace? stackTrace]);
}

class LoggerException implements Exception {
  LoggerException([var message]);
}
