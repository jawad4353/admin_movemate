import 'package:admin_movemate/utilis/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../utilis/app_colors.dart';

class PieChartWidget extends StatelessWidget {
  final Color verifiedColor;
  final Color unverifiedColor;
  final double verifiedValue;
  final double unverifiedValue;
  final String unverifiedTitle;
  final String verifiedTitle;

  const PieChartWidget({super.key,
    required this.verifiedColor,
    required this.unverifiedColor,
    required this.verifiedValue,
    required this.unverifiedValue,
    required this.unverifiedTitle,
    required this.verifiedTitle
  });

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      verifiedTitle: verifiedValue,
     unverifiedTitle: unverifiedValue,
    };

    List<Color> colorList = [
      verifiedColor,
      unverifiedColor,
    ];

    return PieChart(
      dataMap: dataMap,
      colorList: colorList,
      chartRadius: MediaQuery.of(context).size.width / 2.2,
      chartType: ChartType.ring,
      ringStrokeWidth: 62,
      chartValuesOptions:  ChartValuesOptions(
        showChartValues: true,
        showChartValuesOutside: true,
        chartValueBackgroundColor: AppColors.black000000,
        chartValueStyle: AppTextStyles.raleWay(color: AppColors.pureWhite, fontSize: 12, weight: FontWeight.w600)!,
      ),
    );
  }
}
