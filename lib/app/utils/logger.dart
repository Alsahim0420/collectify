import 'dart:developer' as developer;

enum LogLevel { debug, info, warning, error }

class Logger {
  static void log(
    String message, {
    LogLevel level = LogLevel.info,
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    final tagPrefix = tag != null ? '[$tag] ' : '';
    final levelPrefix = _getLevelPrefix(level);
    final fullMessage = '$tagPrefix$levelPrefix$message';

    switch (level) {
      case LogLevel.debug:
        developer.log(fullMessage, level: 500);
        break;
      case LogLevel.info:
        developer.log(fullMessage, level: 800);
        break;
      case LogLevel.warning:
        developer.log(fullMessage, level: 900, error: error);
        break;
      case LogLevel.error:
        developer.log(
          fullMessage,
          level: 1000,
          error: error,
          stackTrace: stackTrace,
        );
        break;
    }
  }

  static void debug(String message, {String? tag}) {
    log(message, level: LogLevel.debug, tag: tag);
  }

  static void info(String message, {String? tag}) {
    log(message, level: LogLevel.info, tag: tag);
  }

  static void warning(String message, {String? tag, Object? error}) {
    log(message, level: LogLevel.warning, tag: tag, error: error);
  }

  static void error(
    String message, {
    String? tag,
    Object? error,
    StackTrace? stackTrace,
  }) {
    log(
      message,
      level: LogLevel.error,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static String _getLevelPrefix(LogLevel level) {
    switch (level) {
      case LogLevel.debug:
        return '[DEBUG] ';
      case LogLevel.info:
        return '[INFO] ';
      case LogLevel.warning:
        return '[WARNING] ';
      case LogLevel.error:
        return '[ERROR] ';
    }
  }
}
