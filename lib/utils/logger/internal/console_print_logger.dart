part of '../logger.dart';

class ConsolePrintLogger extends _StringOutputLogger {
  @override
  void output(String message) => debugPrint(message);
}
