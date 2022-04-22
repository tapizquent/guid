import 'package:flutter_test/flutter_test.dart';

import 'package:guid/guid.dart';

void main() {
  test('new GUID should be of the valid GUID form', () {
    GUID guid = GUID();
    final RegExp _guidRegExp = RegExp(
        r'^(\{){0,1}[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}(\}){0,1}$');

    assert(_guidRegExp.hasMatch(guid.toString()));
  });

  test('props should contains GUID value', () {
    GUID guid = GUID();

    expect(guid.props, contains(guid.toString()));
  });

  test('GUIDs with same value should be equal', () {
    String guidValue = '2b3e94ce-4c93-449f-9154-6fbb968fdbe5';
    GUID guid = GUID.fromValue(guidValue);
    GUID guid1 = GUID.fromValue(guidValue);

    expect(guid, guid1);
  });

  group('fromValue', () {
    test('When invalid form, throws assertion exception', () {
      String invalidGuid = '121212-3222';

      expect(() => GUID.fromValue(invalidGuid), throwsAssertionError);
    });

    test('When valid GUID string, should build GUID with correct value', () {
      String validGuid = '2b3e94ce-4c93-449f-9154-6fbb968fdbe5';

      expect(GUID.fromValue(validGuid).toString(), validGuid);
    });
  });

  group('tryFromValue', () {
    test('When invalid form, returns null', () {
      String invalidGuid = '121212-3222';

      expect(() => GUID.tryFromValue(invalidGuid), returnsNormally);
      expect(GUID.tryFromValue(invalidGuid), isNull);
    });

    test('When valid GUID string, should build GUID with correct value', () {
      String validGuid = '2b3e94ce-4c93-449f-9154-6fbb968fdbe5';

      expect(() => GUID.tryFromValue(validGuid), returnsNormally);
      expect(GUID.tryFromValue(validGuid).toString(), validGuid);
    });
  });

  group('empty', () {
    test('GUID.empty should build GUID with all zeros and proper form', () {
      GUID emptyGuid = GUID.empty;

      expect(emptyGuid, GUID.fromValue('00000000-0000-0000-0000-000000000000'));
    });
  });

  group('ToString', () {
    test('should provide value of GUID', () {
      GUID emptyGuid = GUID.empty;

      expect(emptyGuid.toString(), '00000000-0000-0000-0000-000000000000');
    });
  });
}
