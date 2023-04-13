import 'package:flutter_test/flutter_test.dart';
import 'package:green_house/models/home_model.dart';
import 'package:green_house/services/firestore_services/firestore_services.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:green_house/models/home_members.dart';
import 'unit_test.mocks.dart';

class FirebaseTest extends Mock implements FirestoreService {}

@GenerateMocks([FirebaseTest])
Future<void> main() async {
  late MockFirebaseTest firabaseRepo;
  setUpAll(() {
    firabaseRepo = MockFirebaseTest();
  });

  test('create home', () async {
    final home = HomeModel(
        home_name: 'Casa Prueba',
        owner_id: '1',
        activated: true,
        ubication: {'lat': 0.0, 'lon': 0.0});
    final members = HomeMembersModel(
        member_id: '1', member_role: 'owner', member_status: 'accepted');
    final List<HomeMembersModel>? listMembers = [];
    when(firabaseRepo.createHome(home, listMembers))
        .thenAnswer((realInvocation) async => 'Success');

    expect(await firabaseRepo.createHome(home, listMembers), 'Success');
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
