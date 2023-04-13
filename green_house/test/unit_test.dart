import 'package:flutter_test/flutter_test.dart';
import 'package:green_house/services/firestore_services/firestore_services.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'unit_test.mocks.dart';

class FirebaseTest extends Mock implements FirestoreService {}

@GenerateMocks([FirebaseTest])
Future<void> main() async {
  late MockFirebaseTest firabaseRepo;
  setUpAll(() {
    firabaseRepo = MockFirebaseTest();
  });

  test('validate User Exist', () async {
    when(firabaseRepo.validateUserExist('aherrera'))
        .thenAnswer((realInvocation) async => true);

    expect(await firabaseRepo.validateUserExist('aherrera'), true);
  });

  test('validate User not Exist', () async {
    when(firabaseRepo.validateUserExist('lmiranda'))
        .thenAnswer((realInvocation) async => false);

    expect(await firabaseRepo.validateUserExist('lmiranda'), false);
  });
}
