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
        password: '123456',
        profile:
            'https://firebasestorage.googleapis.com/v0/b/green-house-app-4828a.appspot.com/o/default%2Fdefault.png?alt=media&token=6589ce94-d767-4fd5-b728-cf1d55fa77d7');
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
        password: '123',
        profile:
            'https://firebasestorage.googleapis.com/v0/b/green-house-app-4828a.appspot.com/o/default%2Fdefault.png?alt=media&token=6589ce94-d767-4fd5-b728-cf1d55fa77d7');
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
    expect(() => firebaseRepo.createHomeMembers('1', members), throwsException);
    expect(
        () => firebaseRepo.createHomeMembers('1', members),
        throwsA(predicate((dynamic e) =>
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

  test('Usuario existe en el hogar', () async {
    when(firebaseRepo.validateUserHomeExist('1', 'aherrera'))
        .thenAnswer((realInvocation) async => true);
    expect(await firebaseRepo.validateUserHomeExist('1', 'aherrera'), true);
  });
  test('Usuario no existe en el hogar', () async {
    when(firebaseRepo.validateUserHomeExist('1', 'lmiranda'))
        .thenAnswer((realInvocation) async => false);
    expect(await firebaseRepo.validateUserHomeExist('1', 'lmiranda'), false);
  });

  test('Exeption en Usuario existe en el hogar', () async {
    when(firebaseRepo.validateUserHomeExist('', 'aherrera'))
        .thenThrow(Exception('El parametro homeId no puede ser Null'));
    expect(() => firebaseRepo.validateUserHomeExist('', 'aherrera'),
        throwsException);
  });
  test('Obtener informacion del usuario', () async {
    when(firebaseRepo.getUserData('ahrrera'))
        .thenAnswer((realInvocation) => 'Exito');
    expect(firebaseRepo.getUserData('ahrrera'), 'Exito');
  });

  test('Exception Obtener informacion del usuario', () async {
    when(firebaseRepo.getUserData('lmiranda'))
        .thenThrow(Exception('No existe ese usuario'));
    expect(() => firebaseRepo.getUserData('lmiranda'), throwsException);
  });

  test('Obtener casas del usuario', () async {
    when(firebaseRepo.getUserHomeList()).thenAnswer((realInvocation) async => [
          {
            'home_id': '1',
            'home_name': 'Casa Prueba',
            'owner_id': '1',
            'ubicacion': {'lat': 0.0, 'long': 0.0}
          }
        ]);
    expect(await firebaseRepo.getUserHomeList(), isList);
    expect(await firebaseRepo.getUserHomeList(), isNotEmpty);
  });

  test('Lista de casas del usuario vacias', () async {
    when(firebaseRepo.getUserHomeList())
        .thenAnswer((realInvocation) async => []);
    expect(await firebaseRepo.getUserHomeList(), isList);
    expect(await firebaseRepo.getUserHomeList(), isEmpty);
  });

  test('Exception obtener casas de usuarios', () async {
    when(firebaseRepo.getUserHomeList()).thenThrow(
        Exception('No se pudo realizar la operacion. Vuelve a intentarlo'));
    expect(() => firebaseRepo.getUserHomeList(), throwsException);
  });

  test('Obtener cantidad de usuarios por casa', () async {
    when(firebaseRepo.getUserHomeCount('x7vbc')).thenAnswer(
        (realInvocation) async => {'count': 2, 'status': 'accepted'});
    expect(await firebaseRepo.getUserHomeCount('x7vbc'), isMap);
    expect(await firebaseRepo.getUserHomeCount('x7vbc'), isNotEmpty);
  });

  test('Diccionario vacio de información de cantdad de usuarios por hogar',
      () async {
    when(firebaseRepo.getUserHomeCount('x7vbc'))
        .thenAnswer((realInvocation) async => {});
    expect(await firebaseRepo.getUserHomeCount('x7vbc'), isMap);
    expect(await firebaseRepo.getUserHomeCount('x7vbc'), isEmpty);
  });

  test('Obtener informacion de un hogar', () async {
    when(firebaseRepo.getHomeData('x7vbc'))
        .thenAnswer((realInvocation) => 'Exito');
    expect(firebaseRepo.getHomeData('x7vbc'), 'Exito');
  });
  test('Exception en Obtener informacion de un hogar', () async {
    when(firebaseRepo.getHomeData('x7vbc')).thenThrow(
        Exception('No se pudo realizar la operación. Volver a intentar'));
    expect(() => firebaseRepo.getHomeData('x7vbc'), throwsException);
  });

  test('Obtener lista de usuarios de una casa', () async {
    when(firebaseRepo.getHomeUserList('x7vbc'))
        .thenAnswer((realInvocation) async => [
              {
                'username': 'aherrera',
                'email': 'ah@test.com',
                'name': 'Alex',
                'profile': 'profile.com'
              }
            ]);
    expect(await firebaseRepo.getHomeUserList('x7vbc'), isList);
    expect(await firebaseRepo.getHomeUserList('x7vbc'), isNotEmpty);
  });

  test('Lista vacia de usuarios de una casa', () async {
    when(firebaseRepo.getHomeUserList('x7vbc'))
        .thenAnswer((realInvocation) async => []);
    expect(await firebaseRepo.getHomeUserList('x7vbc'), isEmpty);
  });

  test('Exception en Lista de usuarios de una casa', () async {
    when(firebaseRepo.getHomeUserList('')).thenThrow(Exception(
        'No se ha podido realizar la operacion. Vuelva a intentarlo'));
    expect(() => firebaseRepo.getHomeUserList(''), throwsException);
  });

  test('Validar si un usario acepto la invitacion de un hogar', () async {
    when(firebaseRepo.userHomeStatus('x7vbc', 'z8abc'))
        .thenAnswer((realInvocation) async => true);

    expect(await firebaseRepo.userHomeStatus('x7vbc', 'z8abc'), isTrue);
    expect(await firebaseRepo.userHomeStatus('x7vbc', 'z8abc'), isNotNull);
  });

  test('Validar si un usario rechazo la invitacion de un hogar', () async {
    when(firebaseRepo.userHomeStatus('x7vbc', 'z7abc'))
        .thenAnswer((realInvocation) async => false);

    expect(await firebaseRepo.userHomeStatus('x7vbc', 'z7abc'), isFalse);
    expect(await firebaseRepo.userHomeStatus('x7vbc', 'z7abc'), isNotNull);
  });

  test('Exception en validar si un usario acepto la invitacion de un hogar',
      () async {
    when(firebaseRepo.userHomeStatus('x7vbc', 'z8abc')).thenThrow(
        Exception('No se pudo ejecutar la accion. Favor volver a intentarlo'));

    expect(
        () => firebaseRepo.userHomeStatus('x7vbc', 'z8abc'), throwsException);
  });

  test('Validar si el usuario en la sesion acepto la invitacion de un hogar',
      () async {
    when(firebaseRepo.currentUserHomeStatus('x7vbc'))
        .thenAnswer((realInvocation) async => true);

    expect(await firebaseRepo.currentUserHomeStatus('x7vbc'), isTrue);
    expect(await firebaseRepo.currentUserHomeStatus('x7vbc'), isNotNull);
  });

  test('Validar si el usuario en la sesion rechazo la invitacion de un hogar',
      () async {
    when(firebaseRepo.currentUserHomeStatus('x7vbc'))
        .thenAnswer((realInvocation) async => false);

    expect(await firebaseRepo.currentUserHomeStatus('x7vbc'), isFalse);
    expect(await firebaseRepo.currentUserHomeStatus('x7vbc'), isNotNull);
  });

  test(
      'Exception en validar si el usuario en la sesion  acepto la invitacion de un hogar',
      () async {
    when(firebaseRepo.currentUserHomeStatus('x7vbc')).thenThrow(
        Exception('No se pudo ejecutar la accion. Favor volver a intentarlo'));

    expect(() => firebaseRepo.currentUserHomeStatus('x7vbc'), throwsException);
  });

  test('Obtener lista de emisiones de una casa', () async {
    when(firebaseRepo.getHomeEmission('x7vbc'))
        .thenAnswer((realInvocation) async => [
              {
                'emision_home': 'x7vbc',
                'emision_register_date': 'Tue,28 Feb 2023 1:37:00',
                'emision_tile': 'Emision de Prueba',
                'emision_type': 'power',
                'emision_user': 'z7abc'
              }
            ]);
    expect(await firebaseRepo.getHomeEmission('x7vbc'), isList);
    expect(await firebaseRepo.getHomeEmission('x7vbc'), isNotEmpty);
  });

  test('Lista vacia de emisiones de una casa', () async {
    when(firebaseRepo.getHomeEmission('x7vbc'))
        .thenAnswer((realInvocation) async => []);
    expect(await firebaseRepo.getHomeUserList('x7vbc'), isEmpty);
  });

  test('Exception en Lista de emisiones de una casa', () async {
    when(firebaseRepo.getHomeEmission('')).thenThrow(Exception(
        'No se ha podido realizar la operacion. Vuelva a intentarlo'));
    expect(() => firebaseRepo.getHomeUserList(''), throwsException);
  });

  test('Obtener lista de emisiones del usuario actual en sesion', () async {
    when(firebaseRepo.getCurrentUserEmission())
        .thenAnswer((realInvocation) async => [
              {
                'emision_home': 'x7vbc',
                'emision_register_date': 'Tue,28 Feb 2023 1:37:00',
                'emision_tile': 'Emision de Prueba',
                'emision_type': 'power',
                'emision_user': 'z7abc'
              }
            ]);
    expect(await firebaseRepo.getCurrentUserEmission(), isList);
    expect(await firebaseRepo.getCurrentUserEmission(), isNotEmpty);
  });

  test('Lista vacia de emisiones del usuario actual en sesion', () async {
    when(firebaseRepo.getCurrentUserEmission())
        .thenAnswer((realInvocation) async => []);
    expect(await firebaseRepo.getCurrentUserEmission(), isEmpty);
  });

  test('Exception en Lista de emisiones del usuario actual en sesion',
      () async {
    when(firebaseRepo.getCurrentUserEmission()).thenThrow(Exception(
        'No se ha podido realizar la operacion. Vuelva a intentarlo'));
    expect(() => firebaseRepo.getCurrentUserEmission(), throwsException);
  });

  test('Obtener lista de emisiones de un usuario', () async {
    when(firebaseRepo.getUserEmission('z7abc'))
        .thenAnswer((realInvocation) async => [
              {
                'emision_home': 'x7vbc',
                'emision_register_date': 'Tue,28 Feb 2023 1:37:00',
                'emision_tile': 'Emision de Prueba',
                'emision_type': 'power',
                'emision_user': 'z7abc'
              }
            ]);
    expect(await firebaseRepo.getUserEmission('z7abc'), isList);
    expect(await firebaseRepo.getUserEmission('z7abc'), isNotEmpty);
  });

  test('Lista vacia de emisiones de un usuario', () async {
    when(firebaseRepo.getUserEmission('z7abc'))
        .thenAnswer((realInvocation) async => []);
    expect(await firebaseRepo.getUserEmission('z7abc'), isEmpty);
  });

  test('Exception en Lista de emisiones de un usuario', () async {
    when(firebaseRepo.getUserEmission('')).thenThrow(Exception(
        'No se ha podido realizar la operacion. Vuelva a intentarlo'));
    expect(() => firebaseRepo.getUserEmission(''), throwsException);
  });

  test('Obtener lista de emisiones del usuario en sesion en una casa',
      () async {
    when(firebaseRepo.getHomeUserEmissionList('x7vbc'))
        .thenAnswer((realInvocation) async => [
              {
                'emision_home': 'x7vbc',
                'emision_register_date': 'Tue,28 Feb 2023 1:37:00',
                'emision_tile': 'Emision de Prueba',
                'emision_type': 'power',
                'emision_user': 'z7abc'
              }
            ]);
    expect(await firebaseRepo.getHomeUserEmissionList('x7vbc'), isList);
    expect(await firebaseRepo.getHomeUserEmissionList('x7vbc'), isNotEmpty);
  });

  test('Lista vacia de emisiones de un usuario en sesion en una casa',
      () async {
    when(firebaseRepo.getHomeUserEmissionList('x7vbc'))
        .thenAnswer((realInvocation) async => []);
    expect(await firebaseRepo.getHomeUserEmissionList('x7vbc'), isEmpty);
  });

  test('Exception en Lista de emisiones de un usuario en sesion en una casa',
      () async {
    when(firebaseRepo.getHomeUserEmissionList('')).thenThrow(Exception(
        'No se ha podido realizar la operacion. Vuelva a intentarlo'));
    expect(() => firebaseRepo.getHomeUserEmissionList(''), throwsException);
  });

  test('Obtener lista de emisiones de un usuario en una casa', () async {
    when(firebaseRepo.getHomeUserEmission('x7vbc', 'z7abc'))
        .thenAnswer((realInvocation) async => [
              {
                'emision_home': 'x7vbc',
                'emision_register_date': 'Tue,28 Feb 2023 1:37:00',
                'emision_tile': 'Emision de Prueba',
                'emision_type': 'power',
                'emision_user': 'z7abc'
              }
            ]);
    expect(await firebaseRepo.getHomeUserEmission('x7vbc', 'z7abc'), isList);
    expect(
        await firebaseRepo.getHomeUserEmission('x7vbc', 'z7abc'), isNotEmpty);
  });

  test('Lista vacia de emisiones de un usuario en una casa', () async {
    when(firebaseRepo.getHomeUserEmission('x7vbc', 'z7abc'))
        .thenAnswer((realInvocation) async => []);
    expect(await firebaseRepo.getHomeUserEmission('x7vbc', 'z7abc'), isEmpty);
  });

  test('Exception en Lista de emisiones de un usuario en una casa', () async {
    when(firebaseRepo.getHomeUserEmission('', '')).thenThrow(Exception(
        'No se ha podido realizar la operacion. Vuelva a intentarlo'));
    expect(() => firebaseRepo.getHomeUserEmission('', ''), throwsException);
  });

  test('Obteniendo las emisiones totales de un hogar', () async {
    when(firebaseRepo.homeEmissionTotal('testHomeId'))
        .thenAnswer((realInvocation) async => 14.56);

    expect(await firebaseRepo.homeEmissionTotal('testHomeId'), 14.56);
    expect(await firebaseRepo.homeEmissionTotal('testHomeId'), isA<double>());
    expect(await firebaseRepo.homeEmissionTotal('testHomeId'), isNotNull);
  });
  test('Obteniendo las emisiones totales de un hogar sin emisiones', () async {
    when(firebaseRepo.homeEmissionTotal('testHomeId'))
        .thenAnswer((realInvocation) async => 0);

    expect(await firebaseRepo.homeEmissionTotal('testHomeId'), isZero);
    expect(await firebaseRepo.homeEmissionTotal('testHomeId'), isNotNull);
  });
  test('Exception en Obteniendo las emisiones totales de un hogar', () async {
    when(firebaseRepo.homeEmissionTotal('')).thenThrow(
        Exception('No se ha podido obtener la informacion. Volver a intentar'));

    expect(() => firebaseRepo.homeEmissionTotal(''), throwsException);
  });

  test('Obteniendo las emisiones totales de un hogar por tipo', () async {
    when(firebaseRepo.homeEmissionTotalByType('testHomeId')).thenAnswer(
        (realInvocation) async =>
            {'power': 14.56, 'transport': 20.0, 'gas': 37.38, 'trash': 5.67});
    expect(await firebaseRepo.homeEmissionTotalByType('testHomeId'), isMap);
    expect(await firebaseRepo.homeEmissionTotalByType('testHomeId'), isNotNull);
  });

  test('Exception en Obteniendo las emisiones totales de un hogar por tipo',
      () async {
    when(firebaseRepo.homeEmissionTotalByType('')).thenThrow(
        Exception('No se ha podido obtener la informacion. Volver a intentar'));

    expect(() => firebaseRepo.homeEmissionTotalByType(''), throwsException);
  });

  test('Obteniendo las emisiones totales de un usuario en un hogar', () async {
    when(firebaseRepo.homeUserEmissionTotal('testHomeId', 'testUserId'))
        .thenAnswer(
            (realInvocation) async => {1: 14.56, 2: 20.0, 3: 37.38, 4: 5.67});
    expect(await firebaseRepo.homeUserEmissionTotal('testHomeId', 'testUserId'),
        isMap);
    expect(await firebaseRepo.homeUserEmissionTotal('testHomeId', 'testUserId'),
        isNotNull);
  });

  test(
      'Exception en Obteniendo las emisiones totales de un usuario en un hogar',
      () async {
    when(firebaseRepo.homeUserEmissionTotal('', '')).thenThrow(
        Exception('No se ha podido obtener la informacion. Volver a intentar'));

    expect(() => firebaseRepo.homeUserEmissionTotal('', ''), throwsException);
  });

  test('Obteniendo las emisiones totales de un usuario en un hogar por tipo',
      () async {
    when(firebaseRepo.getHomeUserEmissionList('testHomeId'))
        .thenAnswer((realInvocation) async => [
              {
                'userName': 'testUser',
                'email': 'test@gmail.com',
                'profile': 'profile.com',
                'powerValue': 20.0,
                'transportValue': 35.67,
                'gasValue': 17.96,
                'trashValue': 27.35,
                'totalEmision': 100.98
              }
            ]);
    expect(await firebaseRepo.getHomeUserEmissionList('testHomeId'), isList);
    expect(await firebaseRepo.getHomeUserEmissionList('testHomeId'), isNotNull);
  });

  test(
      'Exception en Obteniendo las emisiones totales de un usuario en un hogar por tipo',
      () async {
    when(firebaseRepo.getHomeUserEmissionList('')).thenThrow(
        Exception('No se ha podido obtener la informacion. Volver a intentar'));

    expect(() => firebaseRepo.getHomeUserEmissionList(''), throwsException);
  });

  test('Obteniendo las emisiones totales del usuario en sesion', () async {
    when(firebaseRepo.currentUserEmissionTotal()).thenAnswer(
        (realInvocation) async => {1: 14.56, 2: 20.0, 3: 37.38, 4: 5.67});
    expect(await firebaseRepo.currentUserEmissionTotal(), isMap);
    expect(await firebaseRepo.currentUserEmissionTotal(), isNotNull);
  });

  test('Exception en Obteniendo las emisiones totales del usuario en sesion',
      () async {
    when(firebaseRepo.currentUserEmissionTotal()).thenThrow(
        Exception('No se ha podido obtener la informacion. Volver a intentar'));

    expect(() => firebaseRepo.currentUserEmissionTotal(), throwsException);
  });
}
