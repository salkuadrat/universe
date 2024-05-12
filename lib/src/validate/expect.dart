import 'validate.dart';

typedef LazyMessage = String Function();

String _defaultIsNullExMessage() => Validate.DEFAULT_IS_NULL_EX_MESSAGE;
String _defaultIsTrueExMessage() => Validate.DEFAULT_IS_TRUE_EX_MESSAGE;

T notNull<T>(
  T? object, {
  LazyMessage message = _defaultIsNullExMessage,
}) {
  if (object == null) {
    throw ArgumentError(message());
  }

  return object;
}

bool isTrue(bool? expression, {LazyMessage message = _defaultIsTrueExMessage}) {
  if (expression == null || expression == false) {
    throw ArgumentError(message());
  }
  return expression;
}
