import 'package:flutter_test/flutter_test.dart';
import 'package:green_house/models/home_model.dart';
import 'package:green_house/services/firestore_services/firestore_services.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:green_house/models/home_members.dart';
import 'package:green_house/models/user_model.dart';
import 'unit_test.mocks.dart';

class FirebaseTest extends Mock implements FirestoreService {}

@GenerateMocks([FirebaseTest])
Future<void> main() async {
  late MockFirebaseTest firebaseRepo;
  setUpAll(() {
    firebaseRepo = MockFirebaseTest();
  });

  test('crear usuario', () async {
    final user = UserModel(
        name: 'Alex',
        username: 'aherrera',
        email: 'ah@test.com',
        password: '123456');
    when(firebaseRepo.createUser(user, 'aht'))
        .thenAnswer((realInvocation) => 'Success');
    expect(firebaseRepo.createUser(user, 'aht'), 'Success');
  });

  test('Exception en crear usuario', () async {
    final user = UserModel(
        name: 'Alex',
        username: 'aherrera',
        email: 'ah@test.com',
        password: '123');
    when(firebaseRepo.createUser(user, '1'))
        .thenAnswer((realInvocation) => throw Exception());

    expect(firebaseRepo.createUser(user, '1'), isException);
  });

  test('crear hogar', () async {
    final home = HomeModel(
        home_name: 'Casa Prueba',
        owner_id: '1',
        activated: true,
        ubication: {'lat': 0.0, 'lon': 0.0});
    final members = HomeMembersModel(
        member_id: '1', member_role: 'owner', member_status: 'accepted');
    final List<HomeMembersModel>? listMembers = [];
    when(firebaseRepo.createHome(home, listMembers))
        .thenAnswer((realInvocation) async => 'Success');

    expect(await firebaseRepo.createHome(home, listMembers), 'Success');
  });

  test('Error crear hogar', () async {
    final home = HomeModel(
        home_name: 'Casa Prueba',
        owner_id: '1',
        activated: true,
        ubication: {'lat': 0.0, 'lon': 0.0});
    final members = HomeMembersModel(
        member_id: '1', member_role: 'owner', member_status: 'accepted');
    final List<HomeMembersModel>? listMembers = [];
    when(firebaseRepo.createHome(home, listMembers))
        .thenAnswer((realInvocation) async => 'Failed');

    expect(await firebaseRepo.createHome(home, listMembers), 'Failed');
  });

  test('Usuario Existe', () async {
    when(firebaseRepo.validateUserExist('aherrera'))
        .thenAnswer((realInvocation) async => true);

    expect(await firebaseRepo.validateUserExist('aherrera'), true);
  });

  test('Usuario no Existe', () async {
    when(firebaseRepo.validateUserExist('lmiranda'))
        .thenAnswer((realInvocation) async => false);
    expect(await firebaseRepo.validateUserExist('lmiranda'), isFalse);
  });
}
