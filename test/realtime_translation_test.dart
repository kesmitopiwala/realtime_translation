import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:realtime_translation/realtime_translation.dart';

void main() {
  const MethodChannel channel = MethodChannel('realtime_translation');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    // expect(await RealtimeTranslation.platformVersion, '42');
  });
}
