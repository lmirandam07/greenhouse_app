import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          centerSpaceRadius: 48.0,
        )));
  }

  List<PieChartSectionData> _chartSections(Map<String, double> emissionByType) {
    final List<PieChartSectionData> list = [];

    // for (var sector in emissionByType.keys) {
    //   const double radius = 40.0;
    //   final data = PieChartSectionData(
    //     color: sector.color,
    //     value: sector.value,
    //     radius: radius,
    //     title: '',
    //   );
    //   list.add(data);
    // }
    return list;
  }
}
