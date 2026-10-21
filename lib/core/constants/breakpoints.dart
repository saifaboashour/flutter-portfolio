/// Layout breakpoints used across the portfolio.
abstract final class Breakpoints {
  /// Below this width: compact (mobile) navigation.
  static const double compact = 768;

  /// Comfortable tablet / small desktop.
  static const double medium = 1024;

  /// Wide desktop.
  static const double expanded = 1440;

  static bool isCompact(double width) => width < compact;
}
