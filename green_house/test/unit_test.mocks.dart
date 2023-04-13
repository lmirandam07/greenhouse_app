// Mocks generated by Mockito 5.4.0 from annotations
// in green_house/test/widget_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:green_house/models/emission_model.dart' as _i8;
import 'package:green_house/models/home_members.dart' as _i6;
import 'package:green_house/models/home_model.dart' as _i5;
import 'package:green_house/models/user_model.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;

import 'unit_test.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeCollectionReference_0<T extends Object?> extends _i1.SmartFake
    implements _i2.CollectionReference<T> {
  _FakeCollectionReference_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeQuerySnapshot_1<T extends Object?> extends _i1.SmartFake
    implements _i2.QuerySnapshot<T> {
  _FakeQuerySnapshot_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [FirebaseTest].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseTest extends _i1.Mock implements _i3.FirebaseTest {
  MockFirebaseTest() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.CollectionReference<Map<String, dynamic>> get docUser =>
      (super.noSuchMethod(
        Invocation.getter(#docUser),
        returnValue: _FakeCollectionReference_0<Map<String, dynamic>>(
          this,
          Invocation.getter(#docUser),
        ),
      ) as _i2.CollectionReference<Map<String, dynamic>>);
  @override
  _i2.CollectionReference<Map<String, dynamic>> get docHome =>
      (super.noSuchMethod(
        Invocation.getter(#docHome),
        returnValue: _FakeCollectionReference_0<Map<String, dynamic>>(
          this,
          Invocation.getter(#docHome),
        ),
      ) as _i2.CollectionReference<Map<String, dynamic>>);
  @override
  _i2.CollectionReference<Map<String, dynamic>> get docEmission =>
      (super.noSuchMethod(
        Invocation.getter(#docEmission),
        returnValue: _FakeCollectionReference_0<Map<String, dynamic>>(
          this,
          Invocation.getter(#docEmission),
        ),
      ) as _i2.CollectionReference<Map<String, dynamic>>);
  @override
  dynamic createUser(
    _i4.UserModel? user,
    dynamic uid,
  ) =>
      super.noSuchMethod(Invocation.method(
        #createUser,
        [
          user,
          uid,
        ],
      ));
  @override
  dynamic createHome(
    _i5.HomeModel? home,
    List<_i6.HomeMembersModel>? members,
  ) =>
      super.noSuchMethod(Invocation.method(
        #createHome,
        [
          home,
          members,
        ],
      ));
  @override
  dynamic createHomeMembers(
    String? home_id,
    _i6.HomeMembersModel? member,
  ) =>
      super.noSuchMethod(Invocation.method(
        #createHomeMembers,
        [
          home_id,
          member,
        ],
      ));
  @override
  _i7.Future<bool> validateUserExist(String? username) => (super.noSuchMethod(
        Invocation.method(
          #validateUserExist,
          [username],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  _i7.Future<bool> validateUserHomeExist(
    String? homeId,
    String? username,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #validateUserHomeExist,
          [
            homeId,
            username,
          ],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  dynamic getUserData(String? username) => super.noSuchMethod(Invocation.method(
        #getUserData,
        [username],
      ));
  @override
  dynamic UpdateUserData(Map<String, Object?>? data) =>
      super.noSuchMethod(Invocation.method(
        #UpdateUserData,
        [data],
      ));
  @override
  dynamic UpdateHomeData(
    Map<String, Object?>? data,
    dynamic homeId,
  ) =>
      super.noSuchMethod(Invocation.method(
        #UpdateHomeData,
        [
          data,
          homeId,
        ],
      ));
  @override
  _i7.Future<_i2.QuerySnapshot<Map<String, dynamic>>> getUserHomes() =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserHomes,
          [],
        ),
        returnValue: _i7.Future<_i2.QuerySnapshot<Map<String, dynamic>>>.value(
            _FakeQuerySnapshot_1<Map<String, dynamic>>(
          this,
          Invocation.method(
            #getUserHomes,
            [],
          ),
        )),
      ) as _i7.Future<_i2.QuerySnapshot<Map<String, dynamic>>>);
  @override
  _i7.Future<_i2.QuerySnapshot<Map<String, dynamic>>> getUserHomesAccepted() =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserHomesAccepted,
          [],
        ),
        returnValue: _i7.Future<_i2.QuerySnapshot<Map<String, dynamic>>>.value(
            _FakeQuerySnapshot_1<Map<String, dynamic>>(
          this,
          Invocation.method(
            #getUserHomesAccepted,
            [],
          ),
        )),
      ) as _i7.Future<_i2.QuerySnapshot<Map<String, dynamic>>>);
  @override
  _i7.Future<List<dynamic>> getUserHomesId() => (super.noSuchMethod(
        Invocation.method(
          #getUserHomesId,
          [],
        ),
        returnValue: _i7.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<List<dynamic>>);
  @override
  _i7.Future<List<dynamic>> getUserHomesAcceptedId() => (super.noSuchMethod(
        Invocation.method(
          #getUserHomesAcceptedId,
          [],
        ),
        returnValue: _i7.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<List<dynamic>>);
  @override
  _i7.Future<Iterable<dynamic>> getUserHomeList() => (super.noSuchMethod(
        Invocation.method(
          #getUserHomeList,
          [],
        ),
        returnValue: _i7.Future<Iterable<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<Iterable<dynamic>>);
  @override
  _i7.Future<Iterable<dynamic>> getUserHomeAcceptedList() =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserHomeAcceptedList,
          [],
        ),
        returnValue: _i7.Future<Iterable<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<Iterable<dynamic>>);
  @override
  _i7.Future<Map<String, dynamic>> getUserHomeCount(String? homeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserHomeCount,
          [homeId],
        ),
        returnValue:
            _i7.Future<Map<String, dynamic>>.value(<String, dynamic>{}),
      ) as _i7.Future<Map<String, dynamic>>);
  @override
  dynamic getHomeData(String? homeId) => super.noSuchMethod(Invocation.method(
        #getHomeData,
        [homeId],
      ));
  @override
  dynamic updateHomeStatus(
    String? homeId,
    String? status,
  ) =>
      super.noSuchMethod(Invocation.method(
        #updateHomeStatus,
        [
          homeId,
          status,
        ],
      ));
  @override
  dynamic validateUserOwner(String? ownerId) =>
      super.noSuchMethod(Invocation.method(
        #validateUserOwner,
        [ownerId],
      ));
  @override
  dynamic exitHome(
    String? homeId,
    String? ownerId,
  ) =>
      super.noSuchMethod(Invocation.method(
        #exitHome,
        [
          homeId,
          ownerId,
        ],
      ));
  @override
  dynamic removeUser(
    String? homeId,
    String? username,
  ) =>
      super.noSuchMethod(Invocation.method(
        #removeUser,
        [
          homeId,
          username,
        ],
      ));
  @override
  _i7.Future<_i2.QuerySnapshot<Map<String, dynamic>>> getHomeUsers(
          String? homeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHomeUsers,
          [homeId],
        ),
        returnValue: _i7.Future<_i2.QuerySnapshot<Map<String, dynamic>>>.value(
            _FakeQuerySnapshot_1<Map<String, dynamic>>(
          this,
          Invocation.method(
            #getHomeUsers,
            [homeId],
          ),
        )),
      ) as _i7.Future<_i2.QuerySnapshot<Map<String, dynamic>>>);
  @override
  _i7.Future<_i2.QuerySnapshot<Map<String, dynamic>>> getHomeUsersAccepted(
          String? homeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHomeUsersAccepted,
          [homeId],
        ),
        returnValue: _i7.Future<_i2.QuerySnapshot<Map<String, dynamic>>>.value(
            _FakeQuerySnapshot_1<Map<String, dynamic>>(
          this,
          Invocation.method(
            #getHomeUsersAccepted,
            [homeId],
          ),
        )),
      ) as _i7.Future<_i2.QuerySnapshot<Map<String, dynamic>>>);
  @override
  _i7.Future<List<dynamic>> getHomeUsersId(String? homeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHomeUsersId,
          [homeId],
        ),
        returnValue: _i7.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<List<dynamic>>);
  @override
  _i7.Future<List<dynamic>> getHomeUsersIdAccepted(String? homeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHomeUsersIdAccepted,
          [homeId],
        ),
        returnValue: _i7.Future<List<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<List<dynamic>>);
  @override
  _i7.Future<Iterable<dynamic>> getHomeUserList(String? homeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHomeUserList,
          [homeId],
        ),
        returnValue: _i7.Future<Iterable<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<Iterable<dynamic>>);
  @override
  _i7.Future<Iterable<dynamic>> getHomeUserAcceptedList(String? homeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHomeUserAcceptedList,
          [homeId],
        ),
        returnValue: _i7.Future<Iterable<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<Iterable<dynamic>>);
  @override
  _i7.Future<bool> userHomeStatus(
    String? homeId,
    String? userId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #userHomeStatus,
          [
            homeId,
            userId,
          ],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  _i7.Future<bool> currentUserHomeStatus(String? homeId) => (super.noSuchMethod(
        Invocation.method(
          #currentUserHomeStatus,
          [homeId],
        ),
        returnValue: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  dynamic createEmission(_i8.EmissionModel? emission) =>
      super.noSuchMethod(Invocation.method(
        #createEmission,
        [emission],
      ));
  @override
  _i7.Future<Iterable<dynamic>> getHomeEmission(String? homeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHomeEmission,
          [homeId],
        ),
        returnValue: _i7.Future<Iterable<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<Iterable<dynamic>>);
  @override
  _i7.Future<Iterable<dynamic>> getCurrentUserEmission() => (super.noSuchMethod(
        Invocation.method(
          #getCurrentUserEmission,
          [],
        ),
        returnValue: _i7.Future<Iterable<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<Iterable<dynamic>>);
  @override
  _i7.Future<Iterable<dynamic>> getUserEmission(String? userId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getUserEmission,
          [userId],
        ),
        returnValue: _i7.Future<Iterable<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<Iterable<dynamic>>);
  @override
  _i7.Future<Iterable<dynamic>> getHomeUserEmission(
    String? homeId,
    String? userId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHomeUserEmission,
          [
            homeId,
            userId,
          ],
        ),
        returnValue: _i7.Future<Iterable<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<Iterable<dynamic>>);
  @override
  _i7.Future<double> homeEmissionTotal(String? homeId) => (super.noSuchMethod(
        Invocation.method(
          #homeEmissionTotal,
          [homeId],
        ),
        returnValue: _i7.Future<double>.value(0.0),
      ) as _i7.Future<double>);
  @override
  _i7.Future<Map<String, double>> homeEmissionTotalByType(String? homeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #homeEmissionTotalByType,
          [homeId],
        ),
        returnValue: _i7.Future<Map<String, double>>.value(<String, double>{}),
      ) as _i7.Future<Map<String, double>>);
  @override
  _i7.Future<Map<double, double>> currentUserEmissionTotal() =>
      (super.noSuchMethod(
        Invocation.method(
          #currentUserEmissionTotal,
          [],
        ),
        returnValue: _i7.Future<Map<double, double>>.value(<double, double>{}),
      ) as _i7.Future<Map<double, double>>);
  @override
  _i7.Future<Map<double, double>> homeUserEmissionTotal(
    String? homeId,
    String? userId,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #homeUserEmissionTotal,
          [
            homeId,
            userId,
          ],
        ),
        returnValue: _i7.Future<Map<double, double>>.value(<double, double>{}),
      ) as _i7.Future<Map<double, double>>);
  @override
  dynamic getHomeUserEmissionData(
    String? homeId,
    Iterable<dynamic>? homeUsers,
    List<Map<dynamic, dynamic>>? userEmission,
  ) =>
      super.noSuchMethod(Invocation.method(
        #getHomeUserEmissionData,
        [
          homeId,
          homeUsers,
          userEmission,
        ],
      ));
  @override
  _i7.Future<Iterable<dynamic>> getHomeUserEmissionList(String? homeId) =>
      (super.noSuchMethod(
        Invocation.method(
          #getHomeUserEmissionList,
          [homeId],
        ),
        returnValue: _i7.Future<Iterable<dynamic>>.value(<dynamic>[]),
      ) as _i7.Future<Iterable<dynamic>>);
  @override
  dynamic getEmissionData(String? emissionId) =>
      super.noSuchMethod(Invocation.method(
        #getEmissionData,
        [emissionId],
      ));
  @override
  dynamic updateEmission(
    Map<String, Object?>? data,
    String? emissionId,
  ) =>
      super.noSuchMethod(Invocation.method(
        #updateEmission,
        [
          data,
          emissionId,
        ],
      ));
  @override
  dynamic deleteEmission(String? emissionId) =>
      super.noSuchMethod(Invocation.method(
        #deleteEmission,
        [emissionId],
      ));
  @override
  dynamic setNotification(bool? activate) =>
      super.noSuchMethod(Invocation.method(
        #setNotification,
        [activate],
      ));
}