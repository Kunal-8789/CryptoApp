import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
//import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class ChartScreen extends StatefulWidget {
  ChartScreen({
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.price,
    required this.change,
    required this.changePercentage_24,
    required this.changePercentage_1h,
    required this.changePercentage_7d,
    required this.changePercentage_14d,
    required this.changePercentage_30d,
    required this.changePercentage_200d,
    required this.changePercentage_1y,
  });

  final String name;
  final String symbol;
  final String imageUrl;
  final double price;
  final double change;
  final double changePercentage_24;
  final double changePercentage_1h;
  final double changePercentage_7d;
  final double changePercentage_14d;
  final double changePercentage_30d;
  final double changePercentage_200d;
  final double changePercentage_1y;

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<ChangeChart> details = [];

  @override
  void initState() {
    details = getchartdata();
    super.initState();
  }

  List<ChangeChart> getchartdata() {
    List<ChangeChart> details = [
      ChangeChart(widget.changePercentage_1y, "1y"),
      ChangeChart(widget.changePercentage_200d, "200d"),
      ChangeChart(widget.changePercentage_30d, "30d"),
      ChangeChart(widget.changePercentage_14d, "14d"),
      ChangeChart(widget.changePercentage_7d, "7d"),
      ChangeChart(widget.changePercentage_24, "24h"),
      ChangeChart(widget.changePercentage_1h, "1h"),
    ];
    return details;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromRGBO(11, 12, 54, 1),
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        title: Text(
          'COIN CHART',
          style: TextStyle(
            color: Colors.grey[900],
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 450,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(2, 2),
                    blurRadius: 3,
                  ),
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(-2, -2),
                    blurRadius: 3,
                  ),
                ],
              ),
              child: SfCartesianChart(
                  plotAreaBorderWidth: 0,
                  primaryXAxis: CategoryAxis(),
                  title: ChartTitle(text: '%Change in the price across year'),
                  legend: Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  trackballBehavior: TrackballBehavior(
                    lineColor: Colors.red,
                    enable: true,
                    activationMode: ActivationMode.singleTap,
                    shouldAlwaysShow: true,
                  ),
                  series: <ChartSeries>[
                    LineSeries<ChangeChart, String>(
                        dataSource: details,
                        xValueMapper: (ChangeChart details, _) =>
                            details.duration,
                        yValueMapper: (ChangeChart details, _) =>
                            details.changes,
                        name: 'Time',
                        enableTooltip: true),
                  ]),
            )
          ],
        ),
      ),
    ));
  }
}

class ChangeChart {
  double changes;
  String duration;
  ChangeChart(this.changes, this.duration);
}
