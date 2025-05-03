// lib/logger.dart
import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

/// A globally available Logger instance.
/// - In debug/profile builds it logs everything (Level.verbose).
/// - In release builds it only logs warnings+ (Level.warning).
final Logger logger = Logger(
  level: kReleaseMode ? Level.warning : Level.verbose,
  printer: PrettyPrinter(
    methodCount: 0,    // don't show method traces
    errorMethodCount: 5, // show more for errors
    lineLength: 80,
    colors: true,
    printEmojis: true,
  ),
);
