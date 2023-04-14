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
        .thenAnswer((realInvocation) => 'Se creo correctamente el usuario');
    expect(firebaseRepo.createUser(user, 'aht'),
        'Se creo correctamente el usuario');
  });

  test('Exception en crear usuario', () async {
    final user = UserModel(
        name: 'Alex',
        username: 'aherrera',
        email: 'ah@test.com',
        password: '123');
    when(firebaseRepo.createUser(user, '1'))
        .thenThrow(Exception('No se pudo crear el usuario correctamente'));

    expect(() => firebaseRepo.createUser(user, '1'), throwsException);
    expect(
        () => firebaseRepo.createUser(user, '1'),
        throwsA(predicate((dynamic e) =>
            e is Exception &&
            e.toString() ==
                'Exception: No se pudo crear el usuario correctamente')));
  });

  test('crear modelo miembros de hogares', () {
    final members = HomeMembersModel(
        member_id: '1', member_role: 'owner', member_status: 'accepted');
    when(firebaseRepo.createHomeMembers('1', members))
        .thenAnswer((realInvocation) => 'Creacion exitosa');
    expect(firebaseRepo.createHomeMembers('1', members), 'Creacion exitosa');
  });

  test('Exception en crear modelo miembros de hogares', () {
    final members = HomeMembersModel(
        member_id: '1', member_role: 'owner', member_status: 'accepted');
    when(firebaseRepo.createHomeMembers('1', members))
        .thenThrow(Exception('No se pudo crear los miembros del hogar'));
    expect(()=>firebaseRepo.createHomeMembers('1', members), throwsException);
    expect(()=>firebaseRepo.createHomeMembers('1', members), throwsA(predicate((dynamic e) =>
            e is Exception &&
            e.toString() ==
                'Exception: No se pudo crear los miembros del hogar')));
  });

  test('crear hogar', () async {
    final home = HomeModel(
        home_name: 'Casa Prueba',
        owner_id: '1',
        activated: true,
        ubication: {'lat': 0.0, 'lon': 0.0});
    final List<HomeMembersModel>? listMembers = [];
    when(firebaseRepo.createHome(home, listMembers))
        .thenAnswer((realInvocation) async => 'Se creo correctamente el hogar');

    expect(await firebaseRepo.createHome(home, listMembers),
        'Se creo correctamente el hogar');
  });

  test('Exception crear hogar', () async {
    final home = HomeModel(
        home_name: 'Casa Prueba',
        owner_id: '1',
        activated: true,
        ubication: {'lat': 0.0, 'lon': 0.0});
    final members = HomeMembersModel(
        member_id: '1', member_role: 'owner', member_status: 'accepted');
    final List<HomeMembersModel>? listMembers = [];
    when(firebaseRepo.createHome(home, listMembers))
        .thenThrow(Exception('No se pudo crear el hogar correctamente'));

    expect(() => firebaseRepo.createHome(home, listMembers), throwsException);
    expect(
        () => firebaseRepo.createHome(home, listMembers),
        throwsA(predicate((dynamic e) =>
            e is Exception &&
            e.toString() ==
                'Exception: No se pudo crear el hogar correctamente')));
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
