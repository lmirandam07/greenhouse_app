import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_house/constants/app_colors.dart';
import '../services/firestore_services/firestore_services.dart';

class PieChartWidget extends StatelessWidget {
  final Map<String, double> emissionByType;

  PieChartWidget(this.emissionByType, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
        aspectRatio: 1.0,
        child: PieChart(PieChartData(
          sections: _chartSections(emissionByType),
          centerSpaceRadius: 50.0,
        )));
  }

  List<PieChartSectionData> _chartSections(Map<String, double> emissionByType) {
    final List<PieChartSectionData> list = [];

    for (var type in emissionByType.entries) {
      final data = PieChartSectionData(
          color: type.key == 'transport'
              ? AppColors.blueColor
              : AppColors.powerColor,
          value: type.value,
          radius: 40,
          title: type.key + "\n(${type.value})",
          titlePositionPercentageOffset: 1.8,
          titleStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 12));
      list.add(data);
    }
    return list;
  }
}
