import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

/// Globally unique identifier
class GUID extends Equatable {
  final String _value;

  /// Generates a new random GUID
  GUID() : _value = const Uuid().v4();

  /// Used to generate a GUID object from a String representation of it
  ///
  /// Throws `AssertionError` if `value` is of invalid format and cannot be parsed
  GUID.fromValue(String value) : _value = value {
    assert(_isValidGUIDValue(value),
        'value is of invalid format and cannot be parsed in GUID');
  }

  /// Tries to generate a GUID from the value passed. If the value is not of
  /// proper GUID format, is empty, or cannot be serialized, it will return null
  static GUID? tryFromValue(String value) =>
      _isValidGUIDValue(value) ? GUID.fromValue(value) : null;

  const GUID._forceValue(String value) : _value = value;

  static const empty = GUID._forceValue(Uuid.NAMESPACE_NIL);

  @override
  String toString() => _value;

  @override
  List<Object> get props => [_value];

  static bool _isValidGUIDValue(String value) {
    if (value.isEmpty) return false;

    final RegExp _guidRegExp = RegExp(
        r'^(\{){0,1}[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}(\}){0,1}$');
    return _guidRegExp.hasMatch(value);
  }
}
