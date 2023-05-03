import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:green_house/charts/bar_chart.dart';
import 'package:green_house/charts/pie_chart.dart';
import 'package:green_house/constants/exports.dart';
import 'package:green_house/screens/dialogs/user_pending.dart';
import 'package:green_house/screens/household/components/activity_item_box.dart';
import 'package:green_house/screens/profile/components/registered_box.dart';
import 'package:green_house/screens/setting/components/setting_box.dart';
import 'package:green_house/widgets/custom_button.dart';

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
    final String emissionUser = 'aherrera';
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
            emissionUser),
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

  testWidgets(
      'RegisteredBox muestra el nombre de la casa y el icono para salir',
      (WidgetTester tester) async {
    const homeName = 'Mi hogar';
    await tester.pumpWidget(
        MaterialApp(home: RegisteredBox(homeName: homeName, onTap: () {})));

    expect(find.text(homeName), findsOneWidget);
    expect(find.byType(SvgPicture), findsNWidgets(2));
  });

  testWidgets('SettingBox muestra la informacion correcta',
      (WidgetTester tester) async {
    // Create a mock onTap callback function
    void mockOnTap() {}

    // Define test variables
    const titleText = 'Settings';
    const subTitleText = 'Cambia tus preferencias aqui';
    const iconPath = 'assets/icons/settingIcon.svg';

    // Build the widget tree
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SettingBox(
            onTap: mockOnTap,
            titleText: titleText,
            subTitleText: subTitleText,
            iconPath: iconPath,
          ),
        ),
      ),
    );

    // Verify that the widget tree has the correct widgets
    expect(find.text(titleText), findsOneWidget);
    expect(find.text(subTitleText), findsOneWidget);
    expect(find.byType(SvgPicture), findsOneWidget);
    expect(find.byType(SizedBox), findsNWidgets(2));
    expect(find.byType(Expanded), findsOneWidget);
    expect(find.byType(Column), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2));
    expect(find.byType(Bounceable), findsOneWidget);
    expect(find.byType(Container), findsOneWidget);
  });

  testWidgets('BarChartWidget renderiza correctamente',
      (WidgetTester tester) async {
    Color _getExpectedColor(int x) {
      switch (x) {
        case 1:
          return AppColors.blueColor;
        case 2:
          return AppColors.powerColor;
        case 3:
          return AppColors.gasColor;
        case 4:
          return AppColors.trashColor;
        default:
          return Colors.black;
      }
    }

    final Map<double, double> testPoints = {1: 10, 2: 20, 3: 30, 4: 40};
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(body: BarChartWidget(points: testPoints)),
    ));

    expect(find.byType(AspectRatio), findsOneWidget);
    expect(find.byType(BarChart), findsOneWidget);

    final barChart = tester.widget<BarChart>(find.byType(BarChart));
    final barChartData = barChart.data;

    expect(barChartData.barGroups.length, testPoints.length);

    // Check if all the bar chart groups are rendered correctly
    for (int i = 0; i < barChartData.barGroups.length; i++) {
      final barChartGroupData = barChartData.barGroups[i];

      final expectedX = testPoints.keys.toList()[i].toInt();
      expect(barChartGroupData.x.toInt(), expectedX);

      final expectedToY = testPoints.values.toList()[i];
      expect(barChartGroupData.barRods[0].toY, expectedToY);

      final expectedColor = _getExpectedColor(expectedX);
      expect(barChartGroupData.barRods[0].color, expectedColor);
    }
  });

  testWidgets('PieChartWidget displays correctly', (WidgetTester tester) async {
    Map<String, double> testData = {
      'transporte': 50.0,
      'energia': 25.0,
      'gas': 15.0,
      'basura': 10.0,
    };

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PieChartWidget(testData),
        ),
      ),
    );

    expect(find.byType(AspectRatio), findsOneWidget);
    expect(find.byType(PieChart), findsOneWidget);
  });
}
