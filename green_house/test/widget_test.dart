import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/dialogs/user_pending.dart';
import 'package:green_house/screens/household/components/activity_item_box.dart';
import 'package:green_house/screens/profile/components/registered_box.dart';
import 'package:green_house/widgets/custom_button.dart';
import 'package:intl/intl.dart';

void main() {
  const homeName = 'My Home';
  VoidCallback? onTap;
  testWidgets(
      'UserPendingDialog muestra correctamente el mensaje configurado y que genere su boton de cierre',
      (WidgetTester tester) async {
    const username = 'aherrera';
    // Crea un MaterialApp widget para contener al widget UserPendingDialog
    await tester.pumpWidget(
      MaterialApp(
        home: UserPendingDialog(username),
      ),
    );

    expect(
        find.text(
            'El usuario $username aún está pendiente por aceptar la invitación al hogar'),
        findsOneWidget);
    expect(find.byType(CustomButton), findsOneWidget);
  });

  testWidgets('ActivityItemBox muestra correctamente la información solicitada',
      (WidgetTester tester) async {
    // Define test data
    final String emissionId = '1';
    final String emissionTitle = 'My Emission';
    final double emissionValue = 12.34;
    final DateTime emissionDate = DateTime(2022, 1, 1);
    final String emissionData = 'Data';
    final Color color = Colors.red;

    // Build the ActivityItemBox widget
    await tester.pumpWidget(
      MaterialApp(
        home: ActivityItemBox(
          emissionId,
          emissionTitle,
          emissionValue,
          Timestamp.fromDate(emissionDate),
          emissionData,
          color,
        ),
      ),
    );

    expect(
        find.byWidgetPredicate((widget) =>
            widget is RichText && widget.text.toPlainText() == emissionTitle),
        findsOneWidget);
    expect(
        find.byWidgetPredicate((widget) =>
            widget is RichText &&
            widget.text.toPlainText() ==
                '${emissionValue.toStringAsFixed(2)} kg'),
        findsOneWidget);
  });

testWidgets('RegisteredBox muestra el nombre de la casa y el icono para salir', (WidgetTester tester) async {
  const homeName = 'Mi hogar';
  await tester.pumpWidget(MaterialApp(home: RegisteredBox(homeName: homeName, onTap: () {})));

  expect(find.text(homeName), findsOneWidget);
  expect(find.byType(SvgPicture), findsNWidgets(2));
});


}
